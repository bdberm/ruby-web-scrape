def save_new_ranking(db, search_term, search_time, search_rank, brand, page_num, num_ratings, average_rating)
  db.execute(<<-SQL, search_term, search_time, search_rank, brand, page_num, num_ratings, average_rating)
    INSERT INTO best_buy_rankings (search_term, search_time, search_rank, brand, page_num, num_ratings, average_rating)
    VALUES (?,?,?,?,?,?,?)

  SQL
end
