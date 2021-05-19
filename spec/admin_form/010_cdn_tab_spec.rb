require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "010: CDN Tab" do
    before(:all) do
    end

    after(:all) do
    end

    before(:each) do
        client = Selenium::WebDriver::Remote::Http::Default.new
        client.open_timeout = 180
        client.read_timeout = 180

        @browser = Watir::Browser.new :chrome, :http_client => client

        @login_page = CircLoginPage.new(@browser)
        @admin_page = CircAdminPage.new(@browser)
        
        @cdn_form = CircAdminCDNForm.new(@browser)
    end

    after(:each) do
        @browser.close
    end

    it "Returns success message after resubmitting https://cdn/" do
        @login_page.goto_url
        @login_page.login_as(ENV['CIRC_USERNAME'], ENV['CIRC_PASSWORD'])
        @admin_page.goto_url
        
        @admin_page.cdn_tab.wait_until(&:present?).click
        
        @cdn_form.resubmit_cdn_edit
        expect(@admin_page.success_message.present?).to eql true
    end
end