require 'watir/rspec'

RSpec.configure do |config|
  # Use Watir::RSpec::HtmlFormatter to get links to the screenshots, html and
  # all other files created during the failing examples.
  config.add_formatter(:documentation) if config.formatters.empty?
  config.add_formatter(Watir::RSpec::HtmlFormatter)

  config.before :all do
    # We want to build our selenium test suite against Chrome.
    # If a selenium test runs in Chrome, it usually also runs in Firefox.
    # The reverse is true far less often.
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome

    @browser = Watir::Browser.new(
      :remote,
      url: "http://#{ENV.fetch('HUB_HOST')}/wd/hub",
      desired_capabilities: capabilities
    )
  end

  config.after :all do
    @browser&.close
  end

  # Include RSpec::Helper into each of your example group for making it possible to
  # write in your examples instead of:
  #   @browser.goto "localhost"
  #   @browser.text_field(name: "first_name").set "Bob"
  #
  # like this:
  #   goto "localhost"
  #   text_field(name: "first_name").set "Bob"
  #
  # This needs that you've used @browser as an instance variable name in
  # before :all block.
  config.include Watir::RSpec::Helper

  # Include RSpec::Matchers into each of your example group for making it possible to
  # use #within with some of RSpec matchers for easier asynchronous testing:
  #   expect(@browser.text_field(name: "first_name")).to exist.within(2)
  #   expect(@browser.text_field(name: "first_name")).to be_present.within(2)
  #   expect(@browser.text_field(name: "first_name")).to be_visible.within(2)
  #
  # You can also use #during to test if something stays the same during the specified period:
  #   expect(@browser.text_field(name: "first_name")).to exist.during(2)
  config.include Watir::RSpec::Matchers

  config.tty = true
  config.color = true
  config.default_formatter = 'doc'
end
