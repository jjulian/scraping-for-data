# Scrape the Baltimore city government website to get the details of
# water bills for specific addresses.
addresses = (1..3).map { |num| "12%.2d William St" % num }

require 'rubygems'
require 'mechanize'
require 'json'
require 'logger'

# Mechanize.log = Logger.new $stderr
agent = Mechanize.new
agent.user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1"

page = agent.get 'http://cityservices.baltimorecity.gov/water/'
f = page.forms.first

bills = addresses.map do |address|
  f["ctl00$ctl00$rootMasterContent$LocalContentPlaceHolder$ucServiceAddress$txtServiceAddress"] = address
  page = f.submit(f.button_with(:name => 'ctl00$ctl00$rootMasterContent$LocalContentPlaceHolder$btnGetInfoServiceAddress'))
  water_bill = {}
  page.search('.dataTable tr').each do |row|
    name = row.css('th').inner_text.strip.downcase.gsub(':','').gsub(' ', '_')
    val = row.css('td span').inner_text.strip
    water_bill[name] = val
  end
  water_bill.keys.each do |k|
    water_bill[k] = water_bill[k].sub('$','') if k =~ /_amount$/ || k =~ /_balance$/
    water_bill[k] = Date.strptime(water_bill[k], "%m/%d/%Y") if k =~ /_date$/
  end
  water_bill
end.reject { |b| b.empty? }

# JSON
puts JSON.pretty_generate(bills)
# CSV
bills.each do |water_bill|
  puts [water_bill['service_address'], water_bill['current_bill_amount'], water_bill['current_balance']].join(',')
end
