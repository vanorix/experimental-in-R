library(mongolite)

#Imports from a CSV file to the mongo database.
importLotes <- function(filepath){
  library(mongolite)
  file <- read.csv(filepath, header = TRUE, sep = ",")

  con <- mongo(collection = "experimental", db = "research")

  con$insert(file)
}

#Import a dataset into an specefic collection
#colname: Name of the collection
#filepath: Absolute path of the CSV file containing the data
importInto <- function(colname, filepath){
  file <- read.csv(filepath, header = TRUE, sep = ",")

  con <- mongo(collection = colname, db = "proyecto")

  con$insert(file)
}
