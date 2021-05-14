require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "011: Storage Tab" do
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
        
        # @admin_form = CircAdminAdminsForm.new(@browser)
    end

    after(:each) do
        # @admin_page.delete_by_value(browser_instance, tab, entry_value, loading_message)
        @browser.close
    end

    xit "Returns success message with valid form fill" do
        ENV['CIRC_USERNAME'] = "consultjsmith@nypl.org"
        ENV['CIRC_PASSWORD'] = "turtlepower"

        @login_page.goto_url
        @login_page.login_as(ENV['CIRC_USERNAME'], ENV['CIRC_PASSWORD'])
        @admin_page.goto_url
        
        # goto tab
        
        # fill form

        expect(@admin_page.success_message.present?).to eql true
    end
end