require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "006: Sitewide Settings Tab" do
    before(:all) do
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
        
        @sitewide_settings_form = CircAdminSitewideSettingsForm.new(@browser)

        @login_page.goto_url
        @login_page.login_as(ENV['CIRC_USERNAME'], ENV['CIRC_PASSWORD'])
        @admin_page.goto_url
        
        @admin_page.sitewide_settings_tab.wait_until(&:present?).click

        @sitewide_settings_form.navigate_to_new_setting_form
    end

    after(:all) do
        @browser.close
    end

    it "Displays key text field in form" do
        expect(@sitewide_settings_form.key_text_field.present?).to eql true
    end

    it "Displays value text field in form" do
        expect(@sitewide_settings_form.value_text_field.present?).to eql true
    end

    it "Displays submit button in form" do
        expect(@sitewide_settings_form.submit_button.present?).to eql true
    end

    xit "Returns success message with valid form fill (MANUAL)" do
        # Due to limited values, this is a manual test
    end
end