require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'sqlite3'
require_relative 'save_to_db.rb'



SEARCH_TERMS = ['smart tv','smart television', 'curved smart tv', 'curved smart television']
MAX_RESULTS_PER_PAGE = 24
URL_START = "https://www.bestbuy.com/site/searchpage.jsp?cp="
URL_MID = "&searchType=search&st="
URL_END ="&_dyncharset=UTF-8&id=pcat17071&type=page&sc=Global&nrp=&sp=&qp=&list=n&af=true&iht=y&usc=All%20Categories&ks=960&keys=keys"

DB = SQLite3::Database.open('lib/db_files/best_buy_rankings.db')



# SEARCH_TERMS.each do |search_term|
#
#   search_url = URL_START + 1.to_s + URL_MID + search_term.split.join("+") + URL_END
#   doc = Nokogiri::HTML(open(search_url))
#
#
#   count = doc.at_css('.count').content[1...-1].to_i
#   last_page_remainder = count % MAX_RESULTS_PER_PAGE
#   num_pages = last_page_remainder != 0 ? count / MAX_RESULTS_PER_PAGE + 1 : count / MAX_RESULTS_PER_PAGE
#
#
#   rank = 1
#
#   (1..num_pages).each do |page_num|
#     search_url = URL_START + page_num.to_s + URL_MID + search_term.split.join("+") + URL_END
#     doc = Nokogiri::HTML(open(search_url))
#     list_items = doc.css('.list-item')
#
#     list_items.each do |list_item|
#       brand_content = list_item.attribute('data-brand').content
#       #Geek Squad Listings do not have brand content, part of Best Buy.
#       #Have chosen to exclude from analysis and not save to result db
#       brand = brand_content.index(":") ? brand_content[brand_content.index(":")+2..-3] : nil
#       title = list_item.attribute('data-title').content
#       num_ratings = list_item.attribute('data-review-count').content.to_i
#       average_rating = list_item.attribute('data-average-rating').content.to_f
#
#       # puts(rank.to_s + ": " + brand) if brand
#       rank += 1
#     end
#
#   end
# end

puts(save_new_ranking(DB, "test", DateTime.now.strftime("%Y/%-m/%-d, %H:%M:%S") , 1, "sony", 1 ))

DB.close
