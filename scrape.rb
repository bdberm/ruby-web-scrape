require 'open-uri'
require 'nokogiri'
require 'byebug'

doc = Nokogiri::HTML(open("https://www.bestbuy.com/site/searchpage.jsp?st=smart+tv&_dyncharset=UTF-8&id=pcat17071&type=page&sc=Global&cp=1&nrp=&sp=&qp=&list=n&af=true&iht=y&usc=All+Categories&ks=960&keys=keys"))

list_items = doc.xpath('//div[@class=\'list-item\']')
puts(list_items[0])
# puts(doc)
# debugger
