# 20150923 - Basic R Homework - Joe Eckert

# Question 1 - Sum of even Fibonacci numbers under 4mm

fibonacci = c(1,2) #initialize the sequence
curFib = fibonacci[length(fibonacci)] + fibonacci[length(fibonacci) - 1] #calc next num in seq

while (curFib <= 4000000) {

  fibonacci = c(fibonacci, curFib) #add the next num to the sequence
  curFib = fibonacci[length(fibonacci)] + fibonacci[length(fibonacci) - 1] #calc next num in seq
  
}

isEven = fibonacci %% 2 == 0 #check if the numbers in the vector are even

evenFib = fibonacci * isEven #non even fibonacci numbers will be set to zero

paste("The sum of even Fibonacci numbers under 4mm is: ", sum(evenFib))

##########################################################################

# Question 2 - What is the largest prime factor of the number 600851475143?

# findprime function from lecture notes
findprime = function(x) {
  if (x %in% c(2, 3, 5, 7)) return(TRUE)
  if (x %% 2 == 0 | x == 1) return(FALSE)
  xsqrt = round(sqrt(x))
  xseq = seq(from = 3, to = xsqrt, by = 2)
  if (all(x %% xseq != 0)) return(TRUE) else return(FALSE)
}

number = 600851475143 
factorTest = 2 #initialize by checking if 2 is a prime factor
remain = number #remainder to factorize
factors = c() #initialize factors vector

while (remain > 1){ 
  
  if (findprime(factorTest) == TRUE){ #check if the number is prime
    if (remain %% factorTest == 0){ #check if the number is a prime factor
      factors = c(factors, factorTest) #if so add to the factors vector
      
      remain = remain / factorTest #re calculate the remainder
      
    }
  }
  
  factorTest = factorTest + 1 #increment the test number
  
}

paste("The largest prime factor of ", number, " is : ", factors[length(factors)])
