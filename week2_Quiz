# coursera03_Getting_and_Cleaning_Data
# Data Science(coursera) - 03. Getting and Cleaning Data


##### Q1
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#    Replace your key and secret below.

## You can make your own application at the section of 'Developer Applications'.
## When making an application, please input the http://localhost:1410 as the callback url.
## myapp <- oauth_app("my application name", key = "Client ID", secrete = "Client Secret"

myapp <- oauth_app("github",
                   key = "b04cfe77a57d90ca6ded",
                   secret = "e31e44b0b15638be27953ead237d6f7ec5ec2108")

# 3. Get OAuth credentials
## You should authorize the application before the next step.
## If you didn't authorize it on the newly opened browser and get the 401 error when 'stop_for_status(req)', 
## please insert 'cache=FALSE'

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp, cache=FALSE)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# converting the json object
library(jsonlite)

json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

# find out the created time of datasharing repo
## name == "datasharing"
## select = c(create_at)
subset(json2, name == "datasharing", select = c(created_at))


##### Q2~Q3

# 1. Download the data into your directory and set the directory.
# 2. read the data
acs <- read.csv("getdata-data-ss06pid.csv")

# 3. install and load the package, 'sqldf'
install.packages("sqldf")
library(sqldf)


##### Q4

# 1. set the url
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)
htmlCode

#2. read the row
htmlCode[10]

##### Q5.
# 1. When reading file type, 'for', you can use 'read.fwf'
# 2. Inpute 'skip=4' to skip first 4 rows
# 3. 'Widths' sets columns for fixed columns. The numbers are adjusted manually.

FOR <- read.fwf("getdata-wksst8110.for", 
                skip=4,
                widths=c(10,9,4,9,4,9,4,9,4))
