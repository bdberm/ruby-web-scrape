CREATE TABLE best_buy_rankings (
  id INTEGER PRIMARY KEY,
  search_term VARCHAR(255) NOT NULL,
  search_time VARCHAR(255) NOT NULL,
  search_rank INTEGER NOT NULL,
  brand VARCHAR(255) NOT NULL,
  page INTEGER NOT NULL
);
