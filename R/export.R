#Attempts to find all Lotes inside the collection
findAllLote <- function(){
  library(mongolite)
  con <- mongo(collection = "lotes", db = "research")
  res = con$find(query = "{ }", fields = '{"_id": 0, "X": 0}')
  return(res)
}

#Attempts to find all data contained in the specifed collection
#colname: Name of the collection
findAllfrom <- function(colname){
  library(mongolite)
  con <- mongo(collection = colname, db = "research")
  res = con$find(query = "{ }", fields = '{"_id": 0, "X": 0}')
  return(res)
}

test <- function(colname){
  library(mongolite)
  con <- mongo(collection = colname, db = "research")
  res <- con$find(query = '{"loteID" : 3}')
  return(res)
}
