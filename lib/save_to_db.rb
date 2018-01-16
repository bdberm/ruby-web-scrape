def save_new_ranking(db, search_term, search_time, search_rank, brand, page_num)
  db.execute(<<-SQL, search_term, search_time, search_rank, brand, page_num)
    INSERT INTO best_buy_rankings (search_term, search_time, search_rank, brand, page_num)
    VALUES (?,?,?,?,?)

  SQL
end
