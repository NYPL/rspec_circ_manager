require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "004: Patron Authentication Tab" do
    before(:all) do
    end

    after(:all) do
    end

    before(:each) do
        @login_page = CircLoginPage.new(@browser)
        @admin_page = CircAdminPage.new(@browser)
        
        @patron_auth_form = CircAdminPatronAuthForm.new(@browser)

        @created_value = random_name
    end

    after(:each) do
        @admin_page.delete_by_value_with_load(@browser, @admin_page.patron_auth_tab, @created_value, @patron_auth_form.loading_message)
        @browser.close
    end

    it "Returns success message with valid form fill" do

        @login_page.goto_url
        @login_page.login_as(ENV['CIRC_USERNAME'], ENV['CIRC_PASSWORD'])
        @admin_page.goto_url
        
        @admin_page.patron_auth_tab.wait_until(&:present?).click
        
        @patron_auth_form.fill_form_with_millenium_test_values(@created_value)
        expect(@admin_page.success_message.present?).to eql true
    end
end