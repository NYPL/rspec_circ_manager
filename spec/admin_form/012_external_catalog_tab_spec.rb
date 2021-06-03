require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "012: External Catalogs Tab" do
    before(:all) do
    end

    after(:all) do
    end

    before(:each) do
        @login_page = CircLoginPage.new(@browser)
        @admin_page = CircAdminPage.new(@browser)
        
        @external_catalogs_form = CircAdminExtCatalogForm.new(@browser)
    end

    after(:each) do
        @browser.close
    end

    it "Returns success message after resubmitting MARC Export catalog" do
        @login_page.goto_url
        @login_page.login_as(ENV['CIRC_USERNAME'], ENV['CIRC_PASSWORD'])
        @admin_page.goto_url
        
        @admin_page.external_catalogs_tab.wait_until(&:present?).click
        
        @external_catalogs_form.resubmit_MARC_catalog_edit
        expect(@admin_page.success_message.present?).to eql true
    end
end