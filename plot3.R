fname <- "household_power_consumption.txt"
picfile <- "plot3.png"
datemin <- as.Date("2007-02-01", format="%Y-%m-%d")
datemax <- as.Date("2007-02-02", format="%Y-%m-%d")

#set the locale to English to obtain correct x labels
Sys.setlocale("LC_TIME", "English")

# read the csv file
data_all <- read.table(fname, sep=";", header=TRUE, na.strings="?")


# Convert string time to time + date
# Time conversion is from this reference source:
# http://stackoverflow.com/questions/11609252/r-tick-data-merging-date-and-time-into-a-single-object
data_all[,2] <- as.POSIXct(paste(data_all$Date, data_all$Time), format="%d/%m/%Y %H:%M:%S")

# convert date strings which are coming in format dd/mm/yyyy into Date class
data_all[,1] <- as.Date(d[,1], format="%d/%m/%Y")

# limit data between date interval <datemin, datemax>
data <- data_all[(d$Date>=datemin) & (d$Date<=datemax),]

# open a PNG file to draw to
png(filename = picfile,
    width = 480, height = 480)

# Inspired by this reference:
# http://www.statmethods.net/graphs/line.html

xrange <- range(data$Time) # date+time
yrange <- range(data$Sub_metering_1)

# prepare the chart
plot(xrange, yrange, type="n",
     xlab = "", ylab = "Energy sub metering")

# add the line plot
lines(data$Time, data$Sub_metering_1)
lines(data$Time, data$Sub_metering_2, col="red")
lines(data$Time, data$Sub_metering_3, col="blue")

# add a legend to plotted lines
legend("topright",
       col=c("black", "red", "blue"),
       lty=c(1,1,1),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3") )

# close the png device
dev.off()