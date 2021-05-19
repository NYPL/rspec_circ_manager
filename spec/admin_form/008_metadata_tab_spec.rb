require 'watir'

require_relative "../../pages/circ_login_page.rb"
require_relative "../../pages/circ_admin_page.rb"

RSpec.describe "008: Metadata Tab" do
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
        
        @metadata_form = CircAdminMetadataForm.new(@browser)

        @created_value = random_name
        # @protocol = "Library Simplified Metadata Wrangler"
    end

    after(:each) do
        @admin_page.delete_by_value_with_load(@browser, @admin_page.metadata_tab, @protocol, @metadata_form.loading_message)
        @browser.close
    end

    it "Returns success message with valid form fill" do
        @login_page.goto_url
        @login_page.login_as(ENV['CIRC_USERNAME'], ENV['CIRC_PASSWORD'])
        @admin_page.goto_url
        
        @admin_page.metadata_tab.wait_until(&:present?).click
        
        @metadata_form.fill_form_as_lsmm(@created_value)
        expect(@admin_page.success_message.present?).to eql true
    end
end