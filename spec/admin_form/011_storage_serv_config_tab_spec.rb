require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "011: Storage Tab" do
    before(:all) do
    end

    after(:all) do
    end

    before(:each) do
        @login_page = CircLoginPage.new(@browser)
        @admin_page = CircAdminPage.new(@browser)
        
        @storage_form = CircAdminStorageForm.new(@browser)
    end

    after(:each) do
        # @admin_page.delete_by_value(browser_instance, tab, entry_value, loading_message)
        @browser.close
    end

    it "Returns success after resubmitting MinIO storage edit" do
        @login_page.goto_url
        @login_page.login_as(ENV['CIRC_USERNAME'], ENV['CIRC_PASSWORD'])
        @admin_page.goto_url
        
        @admin_page.storage_tab.wait_until(&:present?).click
        
        @storage_form.resubmit_minIO_edit
        expect(@admin_page.success_message.present?).to eql true
    end
end