require 'open-uri'
require 'nokogiri'
require 'byebug'

doc = Nokogiri::HTML(open("https://www.bestbuy.com/site/searchpage.jsp?st=smart+tv&_dyncharset=UTF-8&id=pcat17071&type=page&sc=Global&cp=1&nrp=&sp=&qp=&list=n&af=true&iht=y&usc=All+Categories&ks=960&keys=keys"))

list_items = doc.css('.list-item')
count = doc.at_css('.count').content[1...-1].to_i

list_items.each do |list_item|
  brand_content = list_item.attribute('data-brand').content
  puts(brand_content[brand_content.index(":")+2..-3])
end
