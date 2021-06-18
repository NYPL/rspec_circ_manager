class CircLoginPage
    include Selenium

    def initialize(browser)
        @browser                = browser
        @email_text_field       = @browser.text_field(name: "email")
        @password_text_field    = @browser.text_field(name: "password")
        @submit_button          = @browser.element(type: "submit")
        @login_url              = "https://disposable-circulation.librarysimplified.org/admin/web"
        @admin_portal_url       = "https://disposable-circulation.librarysimplified.org/admin/web/config/libraries"

    end

    def goto_url
        @browser.goto @login_url
    end

    def login_as(email, password)
        @email_text_field.wait_until(&:present?).set(email)
        @password_text_field.wait_until(&:present?).set(password)
        @submit_button.wait_until(&:present?).click
    end

    def navigate_to_admin_page_as(email, password)
        @email_text_field.wait_until(&:present?).set(email)
        @password_text_field.wait_until(&:present?).set(password)
        @submit_button.wait_until(&:present?).click
        @submit_button.wait_while(&:present?)
        sleep(30)
        @browser.goto @admin_portal_url
        sleep(30)
        @email_text_field.wait_until(&:present?).set(email)
        @password_text_field.wait_until(&:present?).set(password)
        @submit_button.wait_until(&:present?).click
        @submit_button.wait_while(&:present?)
        sleep(30)
        @browser.goto @admin_portal_url
        sleep(30)
    end
end
