#' Represents the functional dependency of the experimental model. It uses the 'euler'
#' method and the ODE function from the DeSolve package to generate the output.
#' @param df Data frame containing the data capture during the experimental session.
#' @param Aef Effective section of the discharge.
#' @param Aint Effective interception area.
#' @param hm Maximum lamina the produces a discharge.
#' @param hd Value of the lamina that triggers the discharge in the container.
#' @note The parameter df must contain the columns "Tiempo" and "Descarga", each containing
#' time values and their respective water discharge quantities.
#' @return A DeSolve object containing the columns 't', 'h(t)', 'Qd(t)', which correspond to
#' the times, behavior of the laminas in time t, and functional dependency of the discharge
#' time t, respectively.
model <- function(df, Aef, Aint, hm, hd){
  f <- function(t, y, parms){
    with(as.list(c(y, parms)),{
      dh <- (df$Descarga[c(df$Tiempo == t)] - (Aef * sqrt(2 * 9.78 * h))) / Aint
      if(h > 0)
        dq <- ((Aef * 9.78) / sqrt(2 * 9.78 * h)) * ((df$Descarga[c(df$Tiempo == t)] - Qd) / h)
      else
        dq <- 0
      list(c(dh, dq))
    })
  }

  eventFunc <- function(t, y, parms) {
    with(as.list(c(y, parms)),{
      if (h >= hd) {
        return(c(h = hm, Qd = Qd))
      } else if (h <= hm) {
        return(c(h = h, Qd = 0))
      }
      return(c(h = h, Qd = Qd))
    })
  }

  yini = c(h= 0, Qd= 0)

  sol <- ode(y = yini, times = df[,c("Tiempo")], func = f, parms = NULL , method = "euler", events = list(func = eventFunc, times=df[,c("Tiempo")]))

  colnames(sol) <- list('t', 'h(t)', 'Qd(t)')

  return(sol)
}

#' This function is intended to optimize the functional dependency of the discharge and the
#' time t using the squared deviation.
#' @param Aef Efective section of the discharge.
#' @param Aint Efective interception area.
#' @param hm Maximum lamina the produces a discharge.
#' @param hd Value of the lamina that triggers the discharge in the container.
#' @note The function returned automatically makes a plot comparing the observed data
#' with the estimate data calculated by the model function.
#' @return A function with the entry parameter being a data frame as specified in the model
#' function.
optimizeQ <- function(Aef, Aint, hm, hd){
  return(
    function(df){
      est <- model(df, Aef, Aint, hm, hd)
      plot(x= res, main="Solución de la ecuación", xlab = 't', ylab = 'y', type= "l")

      plot(df[,'Descarga'],type="l",col="red",xlab='Tiempo',ylab='Qd(t)')
      lines(df[,'Tiempo'],est[,'Qd(t)'],col="green")
      legend("topleft", c("Observada", "Estimada"), lty=c(1,1), lwd=c(1.5,1.5), col=c('red','green'))

      return(sum((df[,c("Descarga")] - est[,c("Qd(t)")])^2))
    }
  )
}

optimizeH <- function(hm, hd, Aef, Aint){
  return(
    function(df){
      est <- model(df, Aef, Aint, hm, hd)
      return(sum((df[,c("Descarga")] - est[,c("Qd(t)")])^2))
    }
  )
}
