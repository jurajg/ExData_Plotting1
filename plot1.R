fname <- "household_power_consumption.txt"
picfile <- "plot1.png"
datemin <- as.Date("2007-02-01", format="%Y-%m-%d")
datemax <- as.Date("2007-02-02", format="%Y-%m-%d")

# read the csv file
data_all <- read.table(fname, sep=";", header=TRUE, na.strings="?")

# convert date strings which are coming in format dd/mm/yyyy into Date class
data_all[,1] <- as.Date(d[,1], format="%d/%m/%Y")

# limit data between date interval <datemin, datemax>
data <- data_all[(d$Date>=datemin) & (d$Date<=datemax),]

# open a PNG file to draw to
png(filename = picfile,
    width = 480, height = 480)

# draw the histogram of Global active power in the date interval
hist(data$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

# close the png device
dev.off()
