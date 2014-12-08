#!/usr/bin/env ruby

require "pry"
require "nokogiri"
require "open-uri"
require "date"

first_date = "2014-12-9"

def scrape_page(date)
  url = "http://www.blogto.com/events/?date=#{date}"

  page = Nokogiri::HTML(open(url))
  
  events = page.css(".events-list .events-item")
  date = page.css(".events-overview .info")
  	.text
  	.split(",")[1..2]
  	.join(",")
  
  events.map do |event|
    {
  	title: event.css(".event-name").text,
  	summary: event.css(".event-summary").text,
  	address: event.css(".event-address").text,
  	date: Date.parse(date),
  	time: event.css(".event-time").text.strip
    }
  end
end

results = scrape_page(first_date)

binding.pry
