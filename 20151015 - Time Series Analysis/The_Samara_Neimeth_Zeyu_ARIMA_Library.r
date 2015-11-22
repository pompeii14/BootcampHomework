library(TSA)
library(forecast)
library(tseries)

#Functions:
PATH <<- "/Users/avi/programming/data/Week3LectureCodeData/"
setwd(PATH)

#CONSTANTS
#determine significance cutoffs
SignificantPValue <<- 0.075
SignificantWaldPValue <<- 0.05

#max values to test
maxDiff <<- 10
maxpval <<- 6
maxqval <<- 6
maxdval <<- 10

df <- WWWusage
df <- hare
df <- nhtemp
df <- df.brobs

ArimaPDQAIC <- fitARIMAModel(df)

fitARIMAModel = function(df){
  
  plot(df, main = "The Neimeth Package Analyzing Dataset")
  
  adf.test(df)
  #find optimal DVAL by checking all the ADF test until P values is less than 0.05 (SignificantPValue)
    for (dval in 0:maxDiff){
      if(dval==0){
        ddf=df
      }else{
        ddf <- diff(df,differences=dval)
      }
        adf.test(ddf)
        Acf(ddf)
        Pacf(ddf)
        
      print(paste("----Testing Dickey-Fuller test with D=",dval))
        print(adf.test(ddf))
    if (adf.test(ddf)[4]$p.value < SignificantPValue){
      print(paste("P Value is below significance level ",SignificantPValue,". Selecting a Dval = ",dval,sep=""))
      break
    }
  }

  #Also called the wald test
  sig = function(model) {
    return(round((1 - pnorm(abs(model$coef)/sqrt(diag(model$var.coef))))*2, 3))
  }
  
  someData <- rep(0, maxpval*maxdval*maxqval*4)
  ArimaPDQAIC <- array(someData, c(maxpval, maxqval,6)); #1=name, #2=aic, =3=bic
  #ArimaPDQVAL <- array(someData, c(maxpval+1, maxdval+1, maxqval+1,1));  
  
  for (pval in 1:maxpval){
      for (qval in 1:maxqval){
        #The Wald Test
        waldTest <- sig(Arima(df, order = c((pval-1), dval, (qval-1))))
        waldTest[is.nan(waldTest)] <- 0
        
        #Need to catch for a weird bug when the sig function returns a vector of length 0 because R
        if(length(waldTest)==0){
          waldTest <- 0
          maxWaldTestNoIntercept <- 0
        } else{
          maxWaldTestNoIntercept <- max(waldTest[1:(length(waldTest)-1)])
        }
        
        if(maxWaldTestNoIntercept > SignificantWaldPValue){
          print("MODEL NOT SIGNIFICANT")
        }
        
        #      ArimaPDQVAL[pval,dval,qval] <-
        ArimaPDQAIC[pval,qval,1] <- paste("Model= P=",(pval-1),", D=",dval,", Q=",(qval-1),sep="")
        ArimaPDQAIC[pval,qval,2] <- Arima(df, order = c((pval-1), dval, (qval-1)))[6]$aic   #AIC Value
        ArimaPDQAIC[pval,qval,3] <- Arima(df, order = c((pval-1), dval, (qval-1)))[15]$aicc #AICC Value
        ArimaPDQAIC[pval,qval,4] <- Arima(df, order = c((pval-1), dval, (qval-1)))[16]$bic  #BIC Value
        ArimaPDQAIC[pval,qval,5] <- summary(Arima(df, order = c((pval-1), dval, (qval-1))))[2]   #RMSE Value
        ArimaPDQAIC[pval,qval,6] <- maxWaldTestNoIntercept  #wald test
        
        #        ArimaPDQAIC[pval,(dval+1),qval,5] <- paste(sig(Arima(ddf, order = c((pval-1), dval, (qval-1)))))
      }
  }  
  #deletes models where Wald Test is insignificant
  ArimaPDQAIC[ArimaPDQAIC[,,6]>=SignificantWaldPValue] <- 99999999999  #make all values insignifiant when wald test failes

  print("columns are Best Model,       AIC,                AICC,                  BIC,                   RMSE,          Max WALD Score")
  print(ArimaPDQAIC[ArimaPDQAIC[,,2]==min(ArimaPDQAIC[,,2])])  #Min AIC
  print(ArimaPDQAIC[ArimaPDQAIC[,,3]==min(ArimaPDQAIC[,,3])])  #Min AICC
  print(ArimaPDQAIC[ArimaPDQAIC[,,4]==min(ArimaPDQAIC[,,4])])  #Min BIC
  print(ArimaPDQAIC[ArimaPDQAIC[,,5]==min(ArimaPDQAIC[,,5])])  #Min RMSE
  
  #FIND THE BEST MODEL WHERE THE AIC IS MIN
  #bestAIC <- ArimaPDQAIC[ArimaPDQAIC[,,2]==min(ArimaPDQAIC[,,2])][1]
  #bestAICC <- ArimaPDQAIC[ArimaPDQAIC[,,3]==min(ArimaPDQAIC[,,3])][1]
  #bestBIC <- ArimaPDQAIC[ArimaPDQAIC[,,4]==min(ArimaPDQAIC[,,4])][1]
  #bestRMSE <- ArimaPDQAIC[ArimaPDQAIC[,,5]==min(ArimaPDQAIC[,,5])][1]

  #print (paste("dval=",dval,", PDQ=",bestAIC,sep="")) 
  return(ArimaPDQAIC)
}
