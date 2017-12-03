# Getting table sizes
`SELECT table_schema "TABLENAME", sum( data_length + index_length ) / 1024 / 1024 "Data Base Size in MB" FROM information_schema.TABLES GROUP BY table_schema`
