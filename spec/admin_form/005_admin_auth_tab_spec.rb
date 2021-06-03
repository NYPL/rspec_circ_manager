require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "005: Admin Authentication Tab" do
    before(:all) do
    end

    after(:all) do
    end

    before(:each) do
        @login_page = CircLoginPage.new(@browser)
        @admin_page = CircAdminPage.new(@browser)
        
        @admin_auth_form = CircAdminAdminAuthForm.new(@browser)
    end

    after(:each) do
        @browser.close
    end

    it "Exists after clicking tab" do
        @login_page.goto_url
        @login_page.login_as(ENV['CIRC_USERNAME'], ENV['CIRC_PASSWORD'])
        @admin_page.goto_url
        
        @admin_page.admin_auth_tab.wait_until(&:present?).click

        expect(@admin_auth_form.admin_auth_page_header.present?).to be true
    end

    xit "Returns success message with valid form fill (MANUAL)" do
        # Due to inability to create new admin auth, this is a manually tested
    end
end