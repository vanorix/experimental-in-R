#TO-DO
#- Filtered search of information on the database
#- Find all
#- Find by date
#- Find planton by session
#- Find punto by session

test <- function(colname){
  library(mongolite)
  con <- mongo(collection = colname, db = "research")
  res <- con$find(query = '{"loteID" : 3}')
  return(res)
}
