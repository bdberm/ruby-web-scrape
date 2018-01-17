# Example Ruby Web Scrape

This repo contains code for a very basic web scraper built entirely in Ruby. It makes extensive use of two powerful Ruby Gems: SQLite3 and Nokogiri.

The web scraper searches various terms on bestbuy.com such as "smart tv". It then iterates through the pages and saves the various search rankings, and associated brand, product, average and number of ratings to a simple one-table SQL database.

## Technologies

* [SQLite3](https://github.com/sparklemotion/sqlite3-ruby) - SQLite3 provides a lightweight normalized database technology. The web scraper uses the sqlite3 ruby library to save search ranking to the database. You can also execute queries in sqlite3 from the command line or in ruby scripts.
* [Nokogiri](https://github.com/sparklemotion/nokogiri) - Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser. Among Nokogiri's many features is the ability to search documents via XPath or CSS3 selectors. Within the scraper, I primarily make use of the CSS selector functionality.

## Scrape Script

The actual scraper script can be found in the file `lib/scrape.rb`. For each search term, the script will go to bestbuy.com search results for that term by constructing the url and using Nokogiri to save the HTML document to the doc variable. It will then use CSS selector to find all elements with class `.list-item`. It will then use various attributes of that item to save a new ranking to the database. The relevant code:
```ruby
doc = Nokogiri::HTML(open(search_url))
list_items = doc.css('.list-item')

list_items.each do |list_item|
  brand_content = list_item.attribute('data-brand').content
  brand = brand_content.index(":") ? brand_content[brand_content.index(":")+2..-3] : nil
  title = list_item.attribute('data-title').content
  num_ratings = list_item.attribute('data-review-count').content.to_i
  average_rating = list_item.attribute('data-average-rating').content.to_f
  save_new_ranking(db, search_term, search_time, rank, brand, page_num, num_ratings, average_rating) if brand
  rank += 1
end
```

The script iterates through all the pages of search results which it calculates by grabbing the number of results off the first page.

## Instructions for Running the Scrape

After cloning the repo, first navigate to the root directory and execute the command `bundle install` to install the sqlite3 and Nokogiri libraries.

If it's your first time running the script you will first need to create the database. To do so navigate to the root directory and run the command `cat lib/db_files/create_best_buy_rankings.sql | sqlite3 lib/db_files/best_buy_rankings.db`.

The scrape can be run at any time from the command line. Navigate to the root directory and run the command `ruby lib/scrape.rb`. This will run the scrape for any search terms included in the `SEARCH_TERMS` constant in the `lib/scrape.rb` file.
