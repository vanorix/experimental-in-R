#library(mongolite)

#Imports from a CSV file to the mongo database.
importIntoDatabase <- function(filepath){
  #library(mongolite)
  file <- read.csv(filepath, header = TRUE, sep = ",")

  con <- mongo(collection = "experimental", db = "research")

  con$insert(file)
}

#Import a dataset into an specefic collection
#colname: Name of the collection
#filepath: Absolute path of the CSV file containing the data
importIntoCollection <- function(colname, filepath){
  file <- read.csv(filepath, header = TRUE, sep = ",")

  con <- mongo(collection = colname, db = "research")

  con$insert(file)
}

#Imports all CSV files from a given directory into the database
importAll <- function(dirpath){
  dir <- list.files(dirpath, pattern = "^.*\\.(csv)$", full.names = TRUE)
  con <- mongo(collection = "experimental", db = "test")
  for(i in 1:length(dir)){
    data <- read.csv(dir[i], header = TRUE, sep = ",")
    con$insert(data)
  }
}
