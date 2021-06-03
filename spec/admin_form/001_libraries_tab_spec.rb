require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "001: Libraries Tab" do
    before(:all) do
    end

    after(:all) do
    end

    before(:each) do
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