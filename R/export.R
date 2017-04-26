#' Exports the whole experimental collection from the research database into a CSV file.
#' @note the CSV file will be saved by default on the working directory of the project.
exportDatabaseToCSV <- function(){
  db = connect()
  df = db('{ }', '{ }')
  exportDataFrameToCSV(df, "backup.csv")
}

#' Exports a data frame into an specified CSV file
#' @param df data frame to be exported
#' @param filename Name of the file in which the data frame will be inserted
#' @note filename can also receive a relative path to where the CSV file will be save.
#' Keep in mind that the path should and with <name-of-file>.csv in order for the
#' function to recognize it as a valid file name. In case the just <name-of-file>.csv
#' is provided with no explicit path to where the file should be saved, the function will
#' save it into the project's working directory.
exportDataFrameToCSV <- function(df, filename){
  write.csv(df, file = filename)
}
