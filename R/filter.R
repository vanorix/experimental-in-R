#' Connects to the experimental collection in the research database
#' @return A function to query from the connected collection
connect <- function(){
  return(
    #' Lets you query the experimental collection from the research database
    #' @param q Query string
    #' @param f Fields wanted in the result from the query
    function(q, f){
      con <- mongo(collection = "experimental", db = "research")
      res <- con$find(query = q, fields = f)
      return(res)
    }
  )
}

#' Connects to the specified collection in the specified database
#' @param from (string) Database name
#' @param to (string) Collection name, must exist in the database to be able to query it.
#' @return A function to query from the connected collection
connectTo <- function(from, to){
  return(
    #' Lets you query the experimental collection from the research database
    #' @param q Query string
    #' @param f Fields wanted in the result from the query
    function(q, f){
      con <- mongo(collection = to, db = from)
      res <- con$find(query = q, fields = f)
      return(res)
    }
  )
}

#' Returns all experimental sessions related to the loteID provided
#' @param loteID Identifier of the lote as specified in the CSV file.
#' @return values Returned: dataID, windDirection, windSpeed, temperature, humidity, startDate, endDate
getSessionByLote <- function(loteID){
  db = connect()
  query = '{"loteID":'
  query = paste(query, loteID, '}', sep = " ")
  projection = '{"_id": 0, "dataID": 1, "windDirection": 1, "windSpeed": 1, "temperature": 1, "humidity": 1, "startDate": 1, "endDate": 1}'
  return(db(query, projection))
}

#' Returns all experimental sessions within the date range provided
#' @param sd Starting date of the search range.
#' @param ed Ending date of the search range.
#' @note The date range is inclusive. If any of the parameters ISN't
#' going to be used, specify it as NULL. Otherwise there'll be an
#' error.
#' @return Values Returned: dataID, windDirection, windSpeed, temperature, humidity, startDate, endDate
getSessionByDate <- function(sd, ed){
  db = connect()
  startDate = '"startDate":{"$gte":'
  endDate = '"endDate":{"$lte":'
  query = paste('{', startDate, '"', sd, '"', '},', endDate, '"', ed, '"', '}}', sep = "")
  if(is.null(sd)){
    query = paste('{', endDate, '"', ed, '"', '}}', sep = "")
  }
  if(is.null(ed)){
    query = paste('{', startDate, '"', sd, '"', '}}', sep = "")
  }
  projection = '{"_id": 0, "dataID": 1, "windDirection": 1, "windSpeed": 1, "temperature": 1, "humidity": 1, "startDate": 1, "endDate": 1}'
  return(db(query, projection))
}

#' Returns the experimental session asociated with the ID provided
#' @param sessionID Identifier of the session as specified in the CSV as the dataID field
#' @return Values Returned: dataID, windDirection, windSpeed, temperature, humidity, startDate, endDate
getSessionByID <- function(sessionID){
  db = connect()
  query = '{"dataID":'
  query = paste(query, sessionID, '}', sep = " ")
  projection = '{"_id": 0, "dataID": 1, "windDirection": 1, "windSpeed": 1, "temperature": 1, "humidity": 1, "startDate": 1, "endDate": 1}'
  return(db(query, projection))
}

#' Returns all experimental sessions within the temperature range specified
#' @param st Minimum value of the search range.
#' @param et Maximum value of the search range.
#' @note The temperature range is inclusive. If any of the parameters ISN't
#' going to be used, specify it as NULL. Otherwise there'll be an
#' error.
#' @return Values Returned: dataID, windDirection, windSpeed, temperature, humidity, startDate, endDate
getSessionByTemp <- function(st, et){
  db = connect()
  temp = '"temperature":'
  gte = '"$gte":'
  lte = '"$lte":'
  query = paste('{', temp, '{', gte, st, ',', lte, et, '}}',sep = "")
  if(is.null(st)){
    query = paste('{', temp, '{', lte, et, '}}',sep = "")
  }
  if(is.null(et)){
    query = paste('{', temp, '{', gte, st, '}}',sep = "")
  }
  projection = '{"_id": 0, "dataID": 1, "windDirection": 1, "windSpeed": 1, "temperature": 1, "humidity": 1, "startDate": 1, "endDate": 1}'
  return(db(query, projection))
}

#' Returns all experimental sessions wihtin the humidity range specified
#' @param sh Minimum value of the search range.
#' @param eh Maximum value of the search range.
#' @note The humidity range is inclusive. If any of the parameters ISN't
#' going to be used, specify it as NULL. Otherwise there'll be an
#' error.
#' @return Values Returned: dataID, windDirection, windSpeed, temperature, humidity, startDate, endDate
getSessionByHum <- function(sh, eh){
  db = connect()
  hum = '"humidity":'
  gte = '"$gte":'
  lte = '"$lte":'
  query = paste('{', hum, '{', gte, sh, ',', lte, eh, '}}',sep = "")
  if(is.null(sh)){
    query = paste('{', hum, '{', lte, eh, '}}',sep = "")
  }
  if(is.null(eh)){
    query = paste('{', hum, '{', gte, sh, '}}',sep = "")
  }
  projection = '{"_id": 0, "dataID": 1, "windDirection": 1, "windSpeed": 1, "temperature": 1, "humidity": 1, "startDate": 1, "endDate": 1}'
  return(db(query, projection))
}

#' Returns all the plantones asociated with the specified loteID
#' @param loteID Identifier of the lote as specified in the CSV
#' @return Returned Values: plantonID, plantonLongitude, plantonLatitude, plantonBordeBit
getPlantByLote <- function(loteID){
  db = connect()
  query = '{"loteID":'
  query = paste(query, loteID, '}', sep = " ")
  projection = '{"_id": 0, "plantonID": 1, "plantonLatitude": 1, "plantonLongitude": 1, "plantonBordeBit": 1}'
  return(db(query, projection))
}

#' Returns all the capture points asociated with the loteID and plantonID specified
#' @param loteID Identifier of the lote as specified in the CSV
#' @param platonID Identifier of the planton asociated to the loteID
#' @return Returned Values: puntoCaptID, puntoCaptLatitud, puntoCaptLongitud, puntoCaptAlturaSurco, puntoCaptAmplitudSurco, puntoCaptRadioEfectivo
getPlantCapPoint <- function(loteID, plantonID){
  db = connect()
  lote = '"loteID":'
  planton = '"plantonID":'
  query = paste('{', lote, loteID, ',', planton, plantonID, '}', sep = " ")
  projection = '{"_id": 0, "puntoCaptID": 1, "puntoCaptLatitud": 1, "puntoCaptLongitud": 1, "puntoCaptAlturaSurco": 1, "puntoCaptAmplitudSurco": 1, "puntoCaptRadioEfectivo": 1}'
  return(db(query, projection))
}

#' Returns all capture points within the specifed lote
#' @param loteID Identifier of the lote as specified in the CSV
#' @return Returned Values: puntoCaptID, puntoCaptLatitud, puntoCaptLongitud, puntoCaptAlturaSurco, puntoCaptAmplitudSurco, puntoCaptRadioEfectivo
getCapPointByLote <- function(loteID){
  db = connect()
  lote = '"loteID":'
  query = paste('{', lote, loteID, '}', sep = " ")
  projection = '{"_id": 0, "puntoCaptID": 1, "puntoCaptLatitud": 1, "puntoCaptLongitud": 1, "puntoCaptAlturaSurco": 1, "puntoCaptAmplitudSurco": 1, "puntoCaptRadioEfectivo": 1}'
  return(db(query, projection))
}

#' Returns all capture points asociated with the specifed sessionID
#' @param sessionID Identifier of the session as specified in the CSV as the dataID field
#' @return Returned Values: puntoCaptID, puntoCaptLatitud, puntoCaptLongitud, puntoCaptAlturaSurco, puntoCaptAmplitudSurco, puntoCaptRadioEfectivo
getCapPointByExp <- function(sessionID){
  db = connect()
  session = '"dataID":'
  query = paste('{', session, sessionID, '}', sep = " ")
  projection = '{"_id": 0, "puntoCaptID": 1, "puntoCaptLatitud": 1, "puntoCaptLongitud": 1, "puntoCaptAlturaSurco": 1, "puntoCaptAmplitudSurco": 1, "puntoCaptRadioEfectivo": 1}'
  return(db(query, projection))
}

#' Returns all lotes within the specifed plantation date range
#' @param sd Starting date of the search range.
#' @param ed Ending date of the search range.
#' @note The date range is inclusive. If any of the parameters ISN't
#' going to be used, specify it as NULL. Otherwise there'll be an
#' error.
#' @return values Returned: loteID, lotePlantationDate, loteLatitude, loteLongitude
getLoteByDate <- function(sd, ed){
  db = connect()
  term = '"lotePlantationDate":'
  gte = '"$gte":'
  lte = '"$lte":'
  query = paste('{', term, '{', gte, '"', sd, '"', ',', lte, '"', ed, '"', '}}',sep = "")
  if(is.null(sd)){
    query = paste('{', term, '{', lte, '"', ed, '"', '}}',sep = "")
  }
  if(is.null(ed)){
    query = paste('{', term, '{', gte, '"', sd, '"', '}}',sep = "")
  }
  projection = '{"_id": 0, "loteID": 1, "loteLatitude": 1, "loteLongitude": 1, "lotePlantationDate": 1}'
  return(db(query, projection))
}

#' Returns the specific lotes asociated with the specifed sessionID
#' @param sessionID Identifier of the session as specified in the CSV as the dataID field
#' @return Values Returned: loteID, lotePlantationDate, loteLatitude, loteLongitude
getLoteByExp <- function(sessionID){
  db = connect()
  session = '"dataID":'
  query = paste('{', session, sessionID, '}', sep = " ")
  projection = '{"_id": 0, "loteID": 1, "loteLatitude": 1, "loteLongitude": 1, "lotePlantationDate": 1}'
  return(db(query, projection))
}

#' Returns all laminas capture in the specified capture point in diferent experimental sessions
#' @param capPointID Identifier of the capture point the laminas are asociated to.
#' @return Returned Values: laminaID, laminaCaptureMoment, laminaPrecipitacion, fechaCaptLamina
getLamByCapPoint <- function(captPointID){
  db = connect()
  captPoint = '"puntoCaptID":'
  query = paste('{', captPoint, captPointID, '}', sep = " ")
  projection = '{"_id": 0, "laminaID": 1, "laminaCaptureMoment": 1, "laminaPrecipitacion": 1, "fechaCaptLamina": 1}'
  return(db(query, projection))
}

#' Returns all capture points within an specified hour-of-capture range from different experimental sessions
#' @param sh Minimum value of the search range.
#' @param eh Maximum value of the search range.
#' @note The hour range is inclusive. If any of the parameters ISN't
#' going to be used, specify it as NULL. Otherwise there'll be an
#' error.
#' @return Returned Values: laminaID, laminaCaptureMoment, laminaPrecipitacion, fechaCaptLamina
getLamByCapHour <- function(sh, eh){
  db = connect()
  hour = '"laminaCaptureMoment":'
  gte = '"$gte":'
  lte = '"$lte":'
  query = paste('{', hour, '{', gte, '"', sh, '"', ',', lte, '"', eh, '"', '}}',sep = "")
  if(is.null(sh)){
    query = paste('{', hour, '{', lte, '"', eh, '"', '}}',sep = "")
  }
  if(is.null(eh)){
    query = paste('{', hour, '{', gte, '"', sh, '"', '}}',sep = "")
  }
  projection = '{"_id": 0, "laminaID": 1, "laminaCaptureMoment": 1, "laminaPrecipitacion": 1, "fechaCaptLamina": 1}'
  return(db(query, projection))
}

