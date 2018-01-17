require 'byebug'
require 'sqlite3'

def find_brand_coverage_all_search_terms(start_date_str, end_date_str)
  db = SQLite3::Database.open('lib/db_files/best_buy_rankings.db')



  result = db.execute(<<-SQL)

    SELECT * FROM best_buy_rankings
  SQL

  db.close
  result
end
