require 'open-uri'
require 'nokogiri'
require 'byebug'

max_results_per_page = 24

url_start = "https://www.bestbuy.com/site/searchpage.jsp?cp="
url_mid = "&searchType=search&st="
search_term = "smart tv"
url_end ="&_dyncharset=UTF-8&id=pcat17071&type=page&sc=Global&nrp=&sp=&qp=&list=n&af=true&iht=y&usc=All%20Categories&ks=960&keys=keys"

search_url = url_start + 1.to_s + url_mid + search_term.split.join("+") + url_end
doc = Nokogiri::HTML(open(search_url))


count = doc.at_css('.count').content[1...-1].to_i
last_page_remainder = count % max_results_per_page
num_pages = last_page_remainder != 0 ? count / max_results_per_page + 1 : count / max_results_per_page


rank = 1

(1..num_pages).each do |page_num|
  search_url = url_start + page_num.to_s + url_mid + search_term.split.join("+") + url_end
  doc = Nokogiri::HTML(open(search_url))
  list_items = doc.css('.list-item')

  list_items.each do |list_item|
    brand_content = list_item.attribute('data-brand').content
    brand = brand_content.index(":") ? brand_content[brand_content.index(":")+2..-3] : nil
    title = list_item.attribute('data-title').content
    num_ratings = list_item.attribute('data-review-count').content.to_i
    average_rating = list_item.attribute('data-average-rating').content.to_f
    #Geek Squad Listings do not have brand content, part of Best Buy
    puts(rank.to_s + ": " + brand) if brand
    rank += 1
  end

end
