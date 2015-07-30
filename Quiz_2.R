library(httr)
library(httpuv)
library(jsonlite)
library(data.table)

# https://github.com/settings/applications  -  developers/register new API
# authorization callback URL : http://localhost:1410
# application name: github
# Client ID : 376e9aed88987a8d1c4d
# Client Secret: 4be14853241e432b017e2dd234c7e249313fce68

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")
# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "376e9aed88987a8d1c4d",
                   secret = "4be14853241e432b017e2dd234c7e249313fce68")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)
req$created_at
# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)
Json1=content(req)
Json2=jsonlite::fromJSON(toJSON(Json1))
Json2 <- data.table(Json2)
Json2[["created_at"]][6]
Json2[["name"]][6]

# [[1]]
# [1] "2013-11-07T13:25:07Z"