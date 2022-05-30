pollution <- read.csv("E:/Work/Data Science/R/4 Exploratory Data Analysis/avgpm dataset/avgpm25.csv", colClasses = c("numeric", "character", "factor", "numeric", "numeric"))

head(pollution)

#        pm25  fips region longitude latitude
# 1  9.771185 01003   east -87.74826 30.59278
# 2  9.993817 01027   east -85.84286 33.26581
# 3 10.688618 01033   east -87.72596 34.73148
# 4 11.337424 01049   east -85.79892 34.45913
# 5 12.119764 01055   east -86.03212 34.01860
# 6 10.827805 01069   east -85.35039 31.18973