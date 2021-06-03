require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "001: Libraries Tab" do
    before(:all) do
    end

    after(:all) do
    end

    before(:each) do

        
        @client = Selenium::WebDriver::Remote::Http::Default.new
            @client.open_timeout = 180
            @client.read_timeout = 180
            @profile = Selenium::WebDriver::Chrome::Profile.new
            @profile['browser.download.dir'] = "/tmp/webdriver-downloads"
            @profile['browser.download.folderList'] = 2
            @profile['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
            puts @client.to_s
            puts @profile.to_s

        if ENV['app_type'] == 'headless'
            $opts = Selenium::WebDriver::Chrome::Options::new
            # chrome_bin_path = ENV.fetch('GOOGLE_CHROME_SHIM',nil)
            # $opts.binary = chrome_bin_path if chrome_bin_path
            $opts.add_argument('--headless')
            $opts.add_argument('--window-size=1920x1080')
            @capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(accept_insecure_certs: true)
            puts $opts.to_s
            @browser = Watir::Browser.new :chrome, :profile => @profile, :http_client => @client, :desired_capabilities => @capabilities, :options => $opts
            puts "Window Size: #{@browser.driver.manage.window.size}"
            @browser.ready_state.eql? "complete"
        else
            $opts = Selenium::WebDriver::Chrome::Options::new
            # chrome_bin_path = ENV.fetch('GOOGLE_CHROME_SHIM',nil)
            # $opts.binary = chrome_bin_path if chrome_bin_path
            @browser = Watir::Browser.new :chrome, :profile => @profile, :http_client => @client
            @browser.instance_variable_set :@speed, :slow
            @browser.window.maximize()
            @browser.ready_state.eql? "complete"
        end
            
            
        
        @login_page = CircLoginPage.new(@browser)
        @admin_page = CircAdminPage.new(@browser)
        @libraries_form = CircAdminLibrariesForm.new(@browser)

        @created_value = random_name
    end

    after(:each) do
        @admin_page.delete_by_value_no_load(@browser, @admin_page.libraries_tab, @created_value)
        @browser.close
    end

    it "Returns success message with valid form fill" do
        @login_page.goto_url
        @login_page.login_as(ENV['CIRC_USERNAME'], ENV['CIRC_PASSWORD'])
        @admin_page.goto_url
        
        @libraries_form.fill_form(@created_value, "http://www.google.com", "example@nypl.org", "example@nypl.org")
        expect(@admin_page.success_message.present?).to eql true
    end
end