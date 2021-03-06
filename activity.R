activity <- read.csv("activity.csv")
View(activity)

stepsTotalPerDay <- tapply(activity$steps, activity$date, sum)

hist(stepsTotalPerDay, xlab = "Steps Taken Per Day", ylab = "Frequency")

mean(stepsTotalPerDay, na.rm = TRUE)

median(stepsTotalPerDay, na.rm = TRUE)

stepsMeanPerInterval <- tapply(activity$steps, activity$interval, mean, na.rm = T)

plot(stepsMeanPerInterval, type = "l", ylab = "# of steps")

stepsMeanPerInterval <- tapply(activity$steps, activity$interval, mean, na.rm = T)
seq(along = stepsMeanPerInterval)[stepsMeanPerInterval == max(stepsMeanPerInterval)]

sum(as.numeric(is.na(activity$steps)))
temp_stepsMeanPerInterval <- as.vector(stepsMeanPerInterval)
temp_stepsMeanPerInterval <- rep(temp_stepsMeanPerInterval, 61)
temp_stepsMeanPerInterval[!is.na(activity$steps)] = 1
temp_dataTest <- as.vector(activity$steps)
temp_dataTest[is.na(temp_dataTest)] = 1

data_NoNA <- activity

data_NoNA$steps <- temp_stepsMeanPerInterval * temp_dataTest
stepsTotalPerDay_NoNA <- tapply(data_NoNA$steps, data_NoNA$date, sum)
hist(stepsTotalPerDay_NoNA,  main = "Histogram without NAs", xlab = "Number of steps per day", ylab = "Frequency")
stepsMeanPerInterval_NoNA <- tapply(data_NoNA$steps, data_NoNA$interval, mean)
mean(stepsTotalPerDay_NoNA)
median(stepsTotalPerDay_NoNA)
plot(stepsMeanPerInterval_NoNA, type = "l", xlab = "Interval", ylab = "# of Steps", main = "Time Series without NAs")


tmpLT <- as.POSIXlt(activity$date, format = "%Y-%m-%d")
tmpWeekDays <- tmpLT$wday
tmpWeekDays[tmpWeekDays == 0] = 0
tmpWeekDays[tmpWeekDays == 6] = 0
tmpWeekDays[tmpWeekDays != 0] = 1
tmpWeekDaysFactor <- factor(tmpWeekDays, levels = c(0, 1))
activity$WD <- tmpWeekDaysFactor
stepsMeanPerWeekday <- tapply(activity$steps, list(activity$interval, activity$WD), mean, na.rm = TRUE)
par(mfrow = c(2, 1))

with(activity, {
  par(mai = c(0, 1, 1, 0))
  plot(stepsMeanPerWeekday[, 1], type = "l", main = ("Steps vs. Interval"), 
       xaxt = "n", ylab = "Week ends")
  title = ("# of Steps v.s. Interval")
  par(mai = c(1, 1, 0, 0))
  plot(stepsMeanPerWeekday[, 2], type = "l", xlab = "Interval", ylab = "Week days")
  
})

