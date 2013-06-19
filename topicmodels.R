install.packages("corpus.JSS.papers",repos = "http://datacube.wu.ac.at/",
                 type = "source")
data("JSS_papers", package = "corpus.JSS.papers")

set.seed(1102)
library("tm")
library("topicmodels")
library("XML")

remove_HTML_markup <- function(s) {
 doc <- htmlTreeParse(s, asText = TRUE, trim = FALSE)
 iconv(xmlValue(xmlRoot(doc)), "", "UTF-8")
 }
 
corpus <- Corpus(VectorSource(sapply(JSS_papers[, "description"],
remove_HTML_markup)))

dtm <- DocumentTermMatrix(corpus,control = list(stemming = TRUE, stopwords = TRUE, minWordLength = 3,
removeNumbers = TRUE))

dtm <- removeSparseTerms(dtm, 0.99)
dim(dtm)