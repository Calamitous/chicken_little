#!/usr/bin/env ruby

require 'uri'
require 'net/http'
require 'net/smtp'

CONFIG = {
  :recipients => ['lazy_admin@example.com', 'sloppy.admin@example.com'],
  :sender => 'system@example.com',
  :urls_to_check => ['http://127.0.0.1:3000', 'http://example.com/falling/down'],

  # All of the following are optional... leaving them out will default SMTP to localhost:25
  # See Net::SMTP docs for further details
  :smtp_server => 'example.com',
  :port => 25,
  :domain => 'example.com',
  :account => 'system@example.com',
  :password => '5y5t3m!',
  :authtype => :login
}

class FallingSky
  def self.squawk(url, response)
    body = "Subject: [#{url.to_s}] is falling!\n"
    body += "OH NOES!!!\n  I expected a 200 from #{url.to_s} but got a #{response.to_s} instead!"

    Net::SMTP.start(CONFIG[:smtp_server], CONFIG[:port], CONFIG[:domain], CONFIG[:account], CONFIG[:password], CONFIG[:authtype]) do |sender|
      sender.sendmail(body, CONFIG[:sender], CONFIG[:recipients])
    end
  end
end

CONFIG[:urls_to_check].each do |url|
  begin
    response_code = Net::HTTP.get_response(URI.parse(url)).code
  rescue => e
    response_code = e
  ensure
    puts response_code.to_s
    FallingSky.squawk(url, response_code) unless response_code == '200'
  end
end
