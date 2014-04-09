# encoding: utf-8
desc "ParsingWiki"
require 'nokogiri'
require 'open-uri'


task parse: :environment do
  doc = Nokogiri::HTML(open("http://ru.wikipedia.org/wiki/%D0%A1%D0%BF%D0%B8%D1%81%D0%BE%D0%BA_%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%B2_%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D0%B8"))
  doc.css(".wikitable tr").each_with_index do |tr, i|
    unless i == 0
      city = Area.new
      city.title = tr.css('td')[1].css('a')[0].text
      city.alias = Admin::ImportsController.slug city.title
      city.params = {}
      city.params['region'] = tr.css('td')[2].text
      city.params['subject'] = tr.css('td')[3].text
      city.params['population'] = tr.css('td')[4].text
      city.params['link'] = tr.css('td')[1].css('a')[0]['href']
      city.save!
    end
  end

  # doc.css(".vcard")
end
