# Scrape the Baltimore city government website to get the details of a
# water bill for a specific address.
addresses = (1..3).map { |num| "12%.2d William St" % num }

require "uri"
require 'nokogiri'
require 'json'
require 'helpers'
require 'json'

# This is the page (also where the data is POSTed)
uri = URI.parse("http://cityservices.baltimorecity.gov/water/")

# Emulate a browser; request the page, submit the form.
# Collect all of the silly ASP.NET form fields and send them back with the POST
html = get(uri.host, uri.request_uri).body
# scrape the form data
form_data = {}
doc = Nokogiri::HTML(html)
doc.css('form input').each do |field|
  form_data[field['name']] = field['value']
end

bills = addresses.map do |address|
  html = post(uri.host, uri.request_uri, form_data.merge({
    'ctl00$ctl00$rootMasterContent$LocalContentPlaceHolder$ucServiceAddress$txtServiceAddress' => address
  })).body
  # scrape the account info
  water_bill = {}
  doc = Nokogiri::HTML(html)
  doc.css('.dataTable tr').each do |row|
    name = row.css('th').inner_text.strip.downcase.gsub(':','').gsub(' ', '_')
    val = row.css('td span').inner_text.strip
    water_bill[name] = val
  end
  water_bill
  # TODO tweak the individual data types, remove $, etc
end.reject { |b| b.empty? }

# JSON
puts JSON.pretty_generate(bills)
# CSV
bills.each do |water_bill|
  puts [water_bill['service_address'], water_bill['current_bill_amount'], water_bill['current_balance']].join(',')
end
