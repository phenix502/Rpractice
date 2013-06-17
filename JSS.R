install.packages("corpus.JSS.papers",repos = "http://datacube.wu.ac.at/",
                 type = "source")
data("JSS_papers", package = "corpus.JSS.papers")

JSS_papers <- JSS_papers[JSS_papers[, 'date'] < "2010-08-05",]
JSS_papers <- JSS_papers[sapply(JSS_papers[, "description"],Encoding) 
                         == "unknown",]
library("tm")
library("XML")
remove_HTML_markup <- function(s){
  tryCatch(
    {
    doc <- htmlTreeParse(paste("<!DOCTYPE html>", s),
                         asText =  TRUE, trim = FALSE)
    xmlValue(xmlRoot(doc))
  },error = function(s) s)
}

corpus <- Corpus(VectorSource(sapply(JSS_papers[,"description"],remove_HTML_markup)))

Sys.setlocale("LC_COLLATE", "C")
JSS_dtm <- DocumentTermMatrix(corpus)

dim(JSS_dtm)
