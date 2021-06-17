def run_sql(sql_query, params = [])
  connection = PG.connect(ENV["DATABASE_URL"] || {dbname: "souperb"})
  connection.prepare("sql prep statement", sql_query)
  results = connection.exec_prepared("sql prep statement", params)
  connection.close
  results
end