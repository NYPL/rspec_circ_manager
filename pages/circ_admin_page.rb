require 'rspec'

class CircAdminPage
    include Selenium
    include RSpec::Matchers

    def initialize(browser)
        # Browser Instance
        @browser                = browser

        # Messages
        @success_message        = @browser.div(class: ["alert", "alert-success"])
        @loading_message        = @browser.elements(xpath: '//div[@class="loading"]/h1')
        
        # Side Menu Tabs
        @libraries_tab                  = @browser.element(xpath: '//li/a[text()="Libraries"]')
        @admins_tab                     = @browser.element(xpath: '//li/a[text()="Admins"]')
        @collections_tab                = @browser.element(xpath: '//li/a[text()="Collections"]')
        @admin_auth_tab                 = @browser.element(xpath: '//li/a[text()="Admin Authentication"]')
        @patron_auth_tab                = @browser.element(xpath: '//li/a[text()="Patron Authentication"]')
        @sitewide_settings_tab          = @browser.element(xpath: '//li/a[text()="Sitewide Settings"]')
        @logging_tab                    = @browser.element(xpath: '//li/a[text()="Logging"]')
        @metadata_tab                   = @browser.element(xpath: '//li/a[text()="Metadata"]')
        @analytics_tab                  = @browser.element(xpath: '//li/a[text()="Analytics"]')
        @cdn_tab                        = @browser.element(xpath: '//li/a[text()="CDN"]')
        @search_tab                     = @browser.element(xpath: '//li/a[text()="Search"]')
        @storage_tab                    = @browser.element(xpath: '//li/a[text()="Storage"]')
        @external_catalogs_tab           = @browser.element(xpath: '//li/a[text()="External Catalogs"]')
        
        # URLs
        @admin_portal_url       = "https://disposable-circulation.librarysimplified.org/admin/web/config/libraries"
    end

    #  PAGE ACTIONS
    def goto_url
        @browser.goto @admin_portal_url
        sleep(10) #change this later; needs adaptive wait
    end

    def validate_page
        expect(@libraries_tab.present?).to eql true
        expect(@admins_tab.present?).to eql true
        expect(@collections_tab.present?).to eql true
        expect(@admin_auth_tab.present?).to eql true
        expect(@patron_auth_tab.present?).to eql true
        expect(@sitewide_settings_tab.present?).to eql true
        expect(@logging_tab.present?).to eql true
        expect(@metadata_tab.present?).to eql true
        expect(@analytics_tab.present?).to eql true
        expect(@cdn_tab.present?).to eql true
        expect(@search_tab.present?).to eql true
        expect(@external_catalogs_tab.present?).to eql true
    end

    def wait_for_loading_message(loading_message)
        loading_message.wait_until(&:present?)
        loading_message.wait_while(&:present?)
    end

    def delete_by_value_no_load(browser_instance, tab, entry_value)
        if @success_message.present?
            button_xpath="//h3[contains(text(), '#{entry_value}')]/following-sibling::button"
            deleted_entry = browser_instance.element(xpath: button_xpath)
            tab.wait_until(&:present?).click
            deleted_entry.wait_until(&:present?).click
            browser_instance.alert.ok
            deleted_entry.wait_while(&:present?)
        end
    end

    def delete_by_value_with_load(browser_instance, tab, entry_value, loading_message)
        if @success_message.present?
            button_xpath="//h3[contains(text(), '#{entry_value}')]/following-sibling::button"
            deleted_entry = browser_instance.element(xpath: button_xpath)
            tab.wait_until(&:present?).click
            deleted_entry.wait_until(&:present?).click
            browser_instance.alert.ok
            wait_for_loading_message(loading_message)
            deleted_entry.wait_while(&:present?)
        end
    end

    # GETTERS
    def success_message
        @success_message
    end

    def loading_message
        @loading_message
    end

    def libraries_tab
        @libraries_tab
    end

    def admins_tab
        @admins_tab
    end

    def collections_tab
        @collections_tab
    end

    def admin_auth_tab
        @admin_auth_tab
    end

    def patron_auth_tab
        @patron_auth_tab
    end

    def sitewide_settings_tab
        @sitewide_settings_tab
    end

    def logging_tab
        @logging_tab
    end

    def metadata_tab
        @metadata_tab
    end

    def analytics_tab
        @analytics_tab
    end

    def cdn_tab
        @cdn_tab
    end

    def storage_tab
        @storage_tab
    end

    def external_catalogs_tab
        @external_catalogs_tab
    end
end

class CircAdminLibrariesForm < CircAdminPage
    def initialize(browser)
        @browser = browser

        @library_loading_message            = @browser.element(xpath: '//h2[text()="Library configuration"]/../div[@class="loading"]/h1')
        
        # Libraries Tab Buttons
        @library_create_button              = @browser.element(class: ['btn', 'btn-default', 'create-item'])
        @library_form_submit_button         = @browser.button(xpath: '//h2[text()="Library configuration"]/following-sibling::div/form/button')
        # @library_delete_buttons             = @browser.element(class: ['btn','danger', 'delete-item', 'small'])

        # Libraries Form Fields
        @library_form_name_field            = @browser.text_field(name: "name")
        @library_form_short_name_field      = @browser.text_field(name: "short_name")
        @library_form_url_field             = @browser.text_field(name: "website")
        @library_form_support_email_field   = @browser.text_field(name: "help-email")
        @library_form_vendor_email_field    = @browser.text_field(name: "default_notification_email_address")
    end

    # PAGE ACTIONS
    def fill_form (name, url, patron_support_email, vendor_email)
        # puts "is library create button present? " + @library_create_button.present?
        @library_create_button.wait_until(&:present?).click
        # wait_for_loading_message(@library_loading_message)
        sleep(10)
        @library_form_name_field.wait_until(&:present?).set(name)
        @library_form_short_name_field.wait_until(&:present?).set(name)
        @library_form_url_field.wait_until(&:present?).set(url)
        @library_form_support_email_field.wait_until(&:present?).set(patron_support_email)
        @library_form_vendor_email_field.wait_until(&:present?).set(vendor_email)
        @library_form_submit_button.wait_until(&:present?).click
        # wait_for_loading_message(@library_loading_message)
        sleep(10)
    end
end

class CircAdminAdminsForm < CircAdminPage
    def initialize(browser)
        @browser = browser
        
        @admin_loading_message              = @browser.element(xpath: '//h2[text()="Individual admin configuration"]/../div[@class="loading"]/h1')
        
        # Admins Tab Buttons
        @admin_create_button                = @browser.element(xpath: '//h2[text()="Individual admin configuration"]/following-sibling::div/a[@class="btn btn-default create-item"]')
        @admin_form_submit_button           = @browser.element(xpath: '//h2[text()="Individual admin configuration"]/following-sibling::div/form/button')

        # Admins Form Fields
        @admin_email_text_field             = @browser.text_field(name: "email")        
    end

    # PAGE ACTIONS
    def fill_form (email)
        @admin_create_button.wait_until(&:present?).click
        # wait_for_loading_message(@admin_loading_message)
        sleep(10)
        @admin_email_text_field.wait_until(&:present?).set(email)
        @admin_form_submit_button.wait_until(&:present?).click
        # wait_for_loading_message(@admin_loading_message)
        sleep(10)
    end

    # GETTERS
    def loading_message
        @admin_loading_message
    end
end

class CircAdminCollectionsForm < CircAdminPage
    def initialize(browser)
        @browser = browser
        
        @collections_loading_message        = @browser.element(xpath: '//h1[@id="loading"]')
        
        # Collection Form Buttons
        @create_collection_button           = @browser.element(xpath: '//a[contains(@href,"/admin/web/config/collections/create")]')
        @collections_submit_button          = @browser.element(xpath: '(//button[@type="submit"])[5]')

        # Admins Form Fields
        @collections_name_text_field_1      = @browser.text_field(xpath: '(//input[@name="name"])[1]')
        @collections_name_text_field_2      = @browser.text_field(xpath: '(//input[@name="name"])[2]')
        @collections_protocol_select_list   = @browser.select_list(xpath: '//select[@name="protocol"]')

        @collections_library_id_text_field  = @browser.text_field(xpath: '//input[@name="external_account_id"]')
        @collections_website_id_text_field  = @browser.text_field(xpath: '//input[@name="website_id"]')
        @collections_client_key_text_field  = @browser.text_field(xpath: '//input[@name="username"]')
        @collections_client_secret_text_field  = @browser.text_field(xpath: '(//input[@name="password"])[2]')
    end

    # PAGE ACTIONS
    def fill_form_with_overdrive_test_values (name)
        @create_collection_button.wait_until(&:present?).click
        # @collections_loading_message.wait_while(&:present?)
        sleep(10)
        if @collections_name_text_field_1.present?
            @collections_name_text_field_1.wait_until(&:present?).set(name)
        elsif @collections_name_text_field_2.present?
            @collections_name_text_field_2.wait_until(&:present?).set(name)
        end
        @collections_protocol_select_list.wait_until(&:present?).select "Overdrive"
        @collections_library_id_text_field.wait_until(&:present?).set("test")
        @collections_website_id_text_field.wait_until(&:present?).set("test")
        @collections_client_key_text_field.wait_until(&:present?).set("test")
        @collections_client_secret_text_field.wait_until(&:present?).set("test")
        @collections_submit_button.wait_until(&:present?).click
        # @collections_loading_message.wait_while(&:present?)
        sleep(10)
    end

    # GETTERS
    def loading_message
        @collections_loading_message
    end
end

class CircAdminPatronAuthForm < CircAdminPage
    def initialize(browser)
        @browser = browser
        
        @patron_auth_loading_message        = @browser.element(xpath: '//h1[@id="loading"]')
        
        # Collection Form Buttons
        @create_patron_auth_button           = @browser.element(xpath: '//a[contains(@href,"/admin/web/config/patronAuth/create")]')
        @patron_auth_submit_button          = @browser.element(xpath: '(//button[@type="submit"])[7]')

        # Admins Form Fields
        @patron_auth_name_text_field            = @browser.text_field(xpath: "(//input[@name='name'])[4]")
        @patron_auth_protocol_select_list       = @browser.select_list(xpath: "(//select[@name='protocol'])[3]")
        @patron_auth_url_text_field             = @browser.text_field(xpath: "(//input[@name='url'])[2]")
        @patron_auth_test_identifier_text_field = @browser.text_field(name: "test_identifier")
        @patron_auth_barcode_format_select_list = @browser.select_list(name: "identifier_barcode_format")
        @patron_auth_keyboard_id_select_list    = @browser.select_list(name: "identifier_keyboard")
    end

    # PAGE ACTIONS
    def fill_form_with_millenium_test_values (name)
        @create_patron_auth_button.wait_until(&:present?).click
        # wait_for_loading_message(@patron_auth_loading_message)
        sleep(10)
        @patron_auth_name_text_field.wait_until(&:present?).set(name)
        @patron_auth_protocol_select_list.wait_until(&:present?).select "Millenium"
        @patron_auth_url_text_field.wait_until(&:present?).set("https://millenium.com/")
        @patron_auth_test_identifier_text_field.wait_until(&:present?).set("test")
        @patron_auth_barcode_format_select_list.wait_until(&:present?).select "Patron identifiers are not rendered as barcodes"
        @patron_auth_keyboard_id_select_list.wait_until(&:present?).select "System default"
        @patron_auth_submit_button.wait_until(&:present?).click
        # wait_for_loading_message(@patron_auth_loading_message)
        sleep(10)
    end

    # GETTERS
    def loading_message
        @patron_auth_loading_message
    end
end

class CircAdminAdminAuthForm < CircAdminPage
    def initialize(browser)
        @browser = browser
        
        @admin_auth_page_header     = @browser.element(xpath: "//div[@id='opds-catalog']/div/main/div/div/div[4]/div/h2")
        
        @expected_header_text       = "Admin authentication service configuration"
    end

    # PAGE ACTIONS
    def verify_page
        expect(@admin_auth_page_header.present?).to eql true
    end

    # GETTERS
    def admin_auth_page_header
        @admin_auth_page_header
    end

    def expected_header_text
        @expected_header_text
    end
end

class CircAdminSitewideSettingsForm < CircAdminPage
    def initialize(browser)
        @browser = browser

        @sitewide_settings_loading_message      = @browser.element(xpath: '//h2[text()="Sitewide setting configuration"]/../div[@class="loading"]/h1')
        
        # PAGE BUTTONS
        @create_sitewide_settings_button        = @browser.element(xpath: "//a[contains(@href, '/admin/web/config/sitewideSettings/create')]")
        @sitewide_settings_submit_button        = @browser.element(xpath: '(//button[@type="submit"])[8]')
        
        # PAGE FIELDS
        @sitewide_settings_key_text_field       = @browser.select_list(name: "key")
        @sitewide_settings_value_text_field     = @browser.text_field(name: "value")

    end

    # PAGE ACTIONS
    def navigate_to_new_setting_form
        @create_sitewide_settings_button.wait_until(&:present?).click
        # wait_for_loading_message(@sitewide_settings_loading_message)
    end

    # GETTERS
    def key_text_field
        @sitewide_settings_key_text_field
    end

    def value_text_field
        @sitewide_settings_value_text_field
    end

    def submit_button
        @sitewide_settings_submit_button
    end
end

class CircAdminLoggingForm < CircAdminPage
    def initialize(browser)
        @browser = browser

        @logging_loading_message      = @browser.element(xpath: '//h2[text()="Logging service configuration"]/../div[@class="loading"]/h1')
        
        # PAGE BUTTONS
        @create_logging_button                  = @browser.element(xpath: "//a[contains(@href, '/admin/web/config/logging/create')]")
        @logging_submit_button                  = @browser.element(xpath: '(//button[@type="submit"])[9]')
        
        # PAGE FIELDS
        @logging_name_text_field                = @browser.text_field(xpath: '(//input[@name="name"])[5]')
        @logging_protocol_select_list           = @browser.select_list(xpath: '(//select[@name="protocol"])[4]')
    end

    # PAGE ACTIONS
    def fill_form_as_sysLog(name)
        @create_logging_button.wait_until(&:present?).click
        # wait_for_loading_message(@logging_loading_message)
        sleep(10)
        @logging_protocol_select_list.select "sysLog"
        @logging_name_text_field.wait_until(&:present?).set(name)
        @logging_submit_button.wait_until(&:present?).click
        # wait_for_loading_message(@logging_loading_message)
        sleep(10)
    end

    # GETTERS
    def loading_message
        @logging_loading_message
    end
end

class CircAdminMetadataForm < CircAdminPage
    def initialize(browser)
        @browser = browser

        @metadata_loading_message      = @browser.element(xpath: '//h2[text()="Metadata service configuration"]/../div[@class="loading"]/h1')
        
        # PAGE BUTTONS
        @create_metadata_button                 = @browser.element(xpath: "//a[contains(@href, '/admin/web/config/metadata/create')]")
        @metadata_submit_button                  = @browser.element(xpath: '(//button[@type="submit"])[10]')
        
        # PAGE FIELDS
        @metadata_name_text_field               = @browser.text_field(xpath: '(//input[@name="name"])[6]')
        @metadata_protocol_select_list          = @browser.select_list(xpath: '(//select[@name="protocol"])[5]')
        @metadata_api_key_text_field            = @browser.text_field(xpath: '(//input[@name="password"])[5]')
    end

    # PAGE ACTIONS
    def fill_form_as_lsmm(name)
        @create_metadata_button.wait_until(&:present?).click
        # wait_for_loading_message(@metadata_loading_message)
        sleep(10)
        @metadata_protocol_select_list.select "Library Simplified Metadata Wrangler"
        @metadata_name_text_field.wait_until(&:present?).set(name)
        @metadata_submit_button.wait_until(&:present?).click
        sleep(10)
    end

    # GETTERS
    def loading_message
        @metadata_loading_message
    end
end

class CircAdminAnalyticsForm < CircAdminPage
    def initialize(browser)
        @browser = browser

        @analytics_loading_message      = @browser.element(xpath: '//h2[text()="Analytics service configuration"]/../div[@class="loading"]/h1')
        
        # PAGE BUTTONS
        @edit_local_analytics_button                = @browser.element(css: "div:nth-child(9) li:nth-child(1) > .edit-item svg")
        @analytics_submit_button                    = @browser.element(xpath: '(//button[@type="submit"])[2]')
    end

    # PAGE ACTIONS
    def resubmit_local_analytics_edit
        # This assumes that "Local Analytics" is already set up
        @edit_local_analytics_button.wait_until(&:present?).click
        # wait_for_loading_message(@analytics_loading_message)
        sleep(10)
        @analytics_submit_button.wait_until(&:present?).click
        sleep(10)
    end

    # GETTERS
    def loading_message
        @analytics_loading_message
    end
end

class CircAdminCDNForm < CircAdminPage
    def initialize(browser)
        @browser = browser

        # FORM FIELDS
        @cdn_name_field                         = @browser.text_field(xpath: "(//input[@name='name'])[8]")
        @cdn_protocol_select_list               = @browser.select_list(xpath: "(//select[@name='protocol'])[7]")
        @cdn_url_field                          = @browser.text_field(xpath: "(//input[@name='url'])[4]")
        @cdn_domain_field                       = @browser.text_field(name: "mirrored_domain")
        
        # PAGE BUTTONS
        @edit_cdn_button                        = @browser.element(css: "div:nth-child(10) .edit-item svg")
        @cdn_new_submit_button                  = @browser.element(xpath: "(//button[@type='submit'])[12]")
        @cdn_existing_submit_button             = @browser.element(xpath: "//button[@type='submit']")
        @create_cdn_service_button              = @browser.element(xpath: "//a[contains(@href,'/admin/web/config/cdn/create')]")
    end

    # PAGE ACTIONS
    def resubmit_cdn_edit
        # This assumes that "https://cdn/" is already set up
        # sleep(300)
        @edit_cdn_button.wait_until(&:present?).click
        sleep(10)
        @cdn_existing_submit_button.wait_until(&:present?).click
        sleep(10)
    end

    def fill_form_as_cdn(name="test cdn 1", protocol="CDN", url="https://cdn/", mirrored_domain="original.com")
        @create_cdn_service_button.wait_until(&:present?).click
        puts "button clicked!"
        sleep(10)
        puts "made it to page"
        @cdn_protocol_select_list.select protocol
        @cdn_name_field.wait_until(&:present?).set(name)
        @cdn_url_field.wait_until(&:present?).set(url)
        @cdn_domain_field.wait_until(&:present?).set(mirrored_domain)
        @cdn_new_submit_button.wait_until(&:present?).click
        puts "submit button clicked!"
        sleep(10)
    end

    # GETTERS
end

class CircAdminStorageForm < CircAdminPage
    def initialize(browser)
        @browser = browser
        
        # PAGE BUTTONS
        @edit_minIO_storage_button          = @browser.element(css: "div:nth-child(12) .edit-item svg")
        @storage_submit_button              = @browser.element(xpath: '//button[@type="submit"]')
    end

    # PAGE ACTIONS
    def resubmit_minIO_edit
        # This assumes that "minIO" is already set up
        @edit_minIO_storage_button.wait_until(&:present?).click
        sleep(10)
        @storage_submit_button.wait_until(&:present?).click
        sleep(10)
    end

    # GETTERS
end

class CircAdminExtCatalogForm < CircAdminPage
    def initialize(browser)
        @browser = browser
        
        # PAGE BUTTONS
        @edit_MARC_export_button            = @browser.element(css: "div:nth-child(13) .edit-item svg")
        @external_catalog_submit_button     = @browser.element(xpath: '//button[@type="submit"]')
    end

    # PAGE ACTIONS
    def resubmit_MARC_catalog_edit
        # This assumes that "minIO" is already set up
        @edit_MARC_export_button.wait_until(&:present?).click
        sleep(10)
        @external_catalog_submit_button.wait_until(&:present?).click
        sleep(10)
    end

    # GETTERS
end