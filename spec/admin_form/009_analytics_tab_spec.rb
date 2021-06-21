require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "009: Analytics Tab" do
    before(:all) do
    end

    after(:all) do
    end

    before(:each) do
        # Browser launch to be handled by launch_browser_instance in spec_helper in future
        if ENV['app_type'] == 'headless'
            opts = Selenium::WebDriver::Chrome::Options::new(args: ['--headless', '--window-size=1920x1080'])
            client = Selenium::WebDriver::Remote::Http::Default.new
            client.open_timeout = 180
            client.read_timeout = 180
            @browser = Watir::Browser.new :chrome, :http_client => client, :options => opts
        else
            client = Selenium::WebDriver::Remote::Http::Default.new
            client.open_timeout = 180
            client.read_timeout = 180
            @browser = Watir::Browser.new :chrome, :http_client => client
        end
        
        @login_page = CircLoginPage.new(@browser)
        @admin_page = CircAdminPage.new(@browser)
        
        @analytics_form = CircAdminAnalyticsForm.new(@browser)
    end

    after(:each) do
        @browser.close
    end

    it "Returns success message after resubmitting Local Analytics" do
        @login_page.goto_url
        @login_page.login_as(ENV['CIRC_USERNAME'], ENV['CIRC_PASSWORD'])
        @admin_page.goto_url
        
        @admin_page.analytics_tab.wait_until(&:present?).click
        
        @analytics_form.resubmit_local_analytics_edit
        expect(@admin_page.success_message.present?).to eql true
    end
end