#library(mongolite)

#' Imports from a CSV file to the mongo database.
#'
#' @param filepath Absolute path of for the CSV file containing the data to be inserted
importIntoDatabase <- function(filepath){
  #library(mongolite)
  file <- read.csv(filepath, header = TRUE, sep = ",")

  con <- mongo(collection = "experimental", db = "research")

  con$insert(file)
}

#' Import a dataset into an specefic collection
#' @param colname Name of the collection
#' @param filepath Absolute path of the CSV file containing the data
importIntoCollection <- function(colname, filepath){
  file <- read.csv(filepath, header = TRUE, sep = ",")

  con <- mongo(collection = colname, db = "research")

  con$insert(file)
}

#' Imports all CSV files from a given directory into the database.
#' @param dirpath Absolute path to the directory containing the CSV files
importAll <- function(dirpath){
  dir <- list.files(dirpath, pattern = "^.*\\.(csv)$", full.names = TRUE)
  con <- mongo(collection = "experimental", db = "test")
  for(i in 1:length(dir)){
    data <- read.csv(dir[i], header = TRUE, sep = ",")
    con$insert(data)
  }
}
