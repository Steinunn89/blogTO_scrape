#!/usr/bin/env ruby

require "pry"
require "nokogiri"
require "open-uri"
require "date"

file = File.open("index.html", "r").read

page = Nokogiri::HTML(file)

events = page.css(".events-list .events-item")
date = page.css(".events-overview .info")
	.text
	.split(",")[1..2]
	.join(",")

parsed_events = events.map do |event|
  {
	title: event.css(".event-name").text,
	summary: event.css(".event-summary").text,
	address: event.css(".event-address").text,
	date: Date.parse(date),
	time: event.css(".event-time").text.strip
  }
end


binding.pry
