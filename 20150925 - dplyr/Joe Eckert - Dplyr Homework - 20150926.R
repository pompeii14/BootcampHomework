library("dplyr")

#Load NYC Jobs data to a data frame
nycjobs <- read.csv('NYC_Jobs.csv', header = TRUE, stringsAsFactors = FALSE)

#Convert the data frame to a tbl_df object
nycjobs <- tbl_df(nycjobs)

#Check for unique salary frequencies
unique(nycjobs$Salary.Frequency)

#Create annualize table, assumes 40 hours per week, 50 weeks per year
annualize <- data.frame(freq = c("Annual", "Daily", "Hourly"), multiplier = c(1, 5*50, 8*5*50))

#Convert annualize data frame to tbl_df object
annualize <- tbl_df(annualize)

#Left join the multiplier based on salary frequency
nycjobs2 <- left_join(nycjobs, annualize, by = c("Salary.Frequency" = "freq"))

#Calculate the annualized salary range for each position
nycjobs2 <- mutate(nycjobs2, annSalaryFrom = Salary.Range.From * multiplier, annSalaryTo = Salary.Range.To * multiplier)

#Calculate the midrange salary to be used for summary statistics
nycjobs2 <- mutate(nycjobs2, salaryMidpoint = (annSalaryFrom + annSalaryTo) / 2)

#Group by agency
agencyGroup <- group_by(nycjobs2, Agency)

#Calculate summary statistics by agency
agencyStats <- summarise(agencyGroup, meanSalary = mean(salaryMidpoint), medianSalary = median(salaryMidpoint), minSalary = min(salaryMidpoint), maxSalary = max(salaryMidpoint))

#What are the mean and median beginning and ending salaries for each agency?
cat("Mean, Median, Min and Max Salary by Agency")
print(agencyStats, n=100)

#Calculate best average starting salary
agencyStartSalary <- summarise(agencyGroup, meanStart = mean(annSalaryFrom))
agencyStartSalary <- arrange(agencyStartSalary, desc(meanStart))
cat(as.character(select(top_n(agencyStartSalary, 1),Agency)), "has the highest average starting salary: $", prettyNum(as.double(select(top_n(agencyStartSalary, 1),meanStart)), big.mark = ","))

#Group by posting type
postingType <- group_by(nycjobs2, Posting.Type)

#Find average starting range by posting type
postingType <- summarise(postingType, meanStart = mean(annSalaryFrom), meanEnd = mean(annSalaryTo))
postingType
cat("Posting type does not have a big impact on the average salary range.")

#Group by level
levelGroup <- group_by(nycjobs2, Level)

#Calculate average salary range by level
levelGroup <- summarise(levelGroup, meanStart = mean(annSalaryFrom), meanEnd = mean(annSalaryTo))

#Rank the levels by average starting salary
levelRank <- mutate(levelGroup, rank = rank(desc(meanStart)))
cat("Average salary range by posting level, ranked by average starting salary:")
levelRank

#Calculate total posting budget (number of postings * max salary)
postingBudget <- mutate(nycjobs2, budget = (X..Of.Positions * annSalaryTo))

#Group by agency
postingBudget <- group_by(postingBudget, Agency)

#Calculate total budget by agency
postingBudget <- summarise(postingBudget, totalBudget = sum(budget))
cat("Total posting budget by agency (calculated on max salary):")
print(postingBudget, n=100)
cat("Total budget for all NYC agencies: $", prettyNum(as.double(summarise(postingBudget, sum(totalBudget))), big.mark = ","))

#Group by civil service title
serviceTitle <- group_by(nycjobs2, Civil.Service.Title)

#Calculate average salary range by service title
serviceTitle <- summarise(serviceTitle, meanStart = mean(annSalaryFrom), meanEnd = mean(annSalaryTo))

#Sort the table by starting salary to find best title with the best salary range
serviceTitle <- arrange(serviceTitle, desc(meanEnd))
cat(as.character(select(top_n(serviceTitle, 1),Civil.Service.Title)), "has the highest average salary range: $", prettyNum(as.double(select(top_n(serviceTitle, 1),meanStart)), big.mark = ","), "to $", prettyNum(as.double(select(top_n(serviceTitle, 1),meanEnd)), big.mark = ","))

