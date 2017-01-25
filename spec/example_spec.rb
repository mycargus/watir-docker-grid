require 'spec_helper'

describe 'Loading the app under test' do
  it 'displays the home page' do
    puts 'Watir test started'

    goto "http://#{ENV.fetch('APP_HOST')}"
    expect(browser.text).to include 'Hello, Docker World!'

    puts 'Watir test finished'
    puts '¸¸♬·¯·♩¸¸♪·¯·♫¸¸Happy Dance¸¸♬·¯·♩¸¸♪·¯·♫¸¸'
  end
end
