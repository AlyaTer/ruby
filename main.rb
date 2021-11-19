require 'open-uri'
require 'byebug'
require 'nokogiri'
require 'csv'
require 'json'
require 'date'

url = 'https://www.transfermarkt.com/zenit-st-petersburg/startseite/verein/964/saison_id/2019'
html = open(url) { |result| result.read }

document = Nokogiri::HTML(html)

players = 
  document.css('table.items > tbody > tr').map do |tr_node|
    {
      name: tr_node.at('.hide-for-small').text,
      price: tr_node.at('.rechts.hauptlink').text.gsub(/[^\d\.a-z]/, ''),
      date: Date.parse(tr_node.css('.zentriert')[1].text)
      
    }
  end
 csv= CSV.open("data.csv", "w") do |wr|
    #wr << [players.first]
 end
 
column_names = players.first.keys
    s=CSV.generate do |csv|
    csv << column_names
    players.each do |x|
    csv << x.values
  end
end
File.write('data.csv', s)
csv= CSV.open("data.csv", "w") do |wr|
  wr << [players]
end

puts JSON.pretty_generate(players)

byebug
puts players.inspect