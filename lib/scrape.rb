require 'open-uri'
require 'nokogiri'
require 'byebug'

max_results_per_page = 24

url_start = "https://www.bestbuy.com/site/searchpage.jsp?cp="
page_num = 1
url_mid = "&searchType=search&st="
search_term = "smart tv"
url_end ="&_dyncharset=UTF-8&id=pcat17071&type=page&sc=Global&nrp=&sp=&qp=&list=n&af=true&iht=y&usc=All%20Categories&ks=960&keys=keys"

search_url = url_start + 1.to_s + url_mid + search_term.split.join("+") + url_end
doc = Nokogiri::HTML(open("https://www.bestbuy.com/site/searchpage.jsp?st=smart+tv&_dyncharset=UTF-8&id=pcat17071&type=page&sc=Global&cp=1&nrp=&sp=&qp=&list=n&af=true&iht=y&usc=All+Categories&ks=960&keys=keys"))


count = doc.at_css('.count').content[1...-1].to_i
last_page_remainder = count % max_results_per_page
num_pages = last_page_remainder != 0 ? count / max_results_per_page + 1 : count / max_results_per_page




(1..num_pages).each do |page_num|
  search_url = url_start + page_num.to_s + url_mid + search_term.split.join("+") + url_end
  puts(search_url)
  doc = Nokogiri::HTML(open(search_url))
  list_items = doc.css('.list-item')

  list_items.each do |list_item|
    brand_content = list_item.attribute('data-brand').content
    title_content = list_item.attribute('data-title').content
    num_ratings = list_item.attribute('data-review-count').content.to_i
    average_rating = list_item.attribute('data-average-rating').content.to_f
    puts(brand_content[brand_content.index(":")+2..-3])
    # puts(average_rating)
  end

end
