require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "006: Sitewide Settings Tab" do
    before(:all) do
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