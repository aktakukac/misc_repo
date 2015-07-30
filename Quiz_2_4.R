library(XML)

url <- ("http://biostat.jhsph.edu/~jleek/contact.html")

conn <- url(url)

doc <- readLines(conn)

close(conn)

print(nchar(doc[10]))
print(nchar(doc[20]))
print(nchar(doc[30]))
print(nchar(doc[100]))

# 45 31 7 25