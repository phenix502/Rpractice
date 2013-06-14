# init 
libs <- c ("tm", "ply","class")
lappy(libs,require,character.only = TRUE)

# set options
options(stringASFactors = FALSE)

#set parameters
candidates <- c("romney", "obama")
pathname <- "c:/users/tdauria/Google Drive/videos/speeches"

#clean text

cleancorpus <- function(corpus){
	corpus.tmp <- tm_map(corpus, removePunctuation)
	corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
	corpus.tmp <- tm_map(corpus.tmp, tolower)
	corpus.tmp <- tm_map(corpus.tmp, removeWords, stopwords("english"))
	return(corpus.tmp)
}

#	build  TDM
generateTDM <- function(cand,path){
	s.dir <- sprintf("%s/%s",path,cand)
	s.cor <- Corpus(DirSource(directory = s.dir, encoding = "ANSI"))
	s.cor.cl <- cleancorpus(s.cor)
	s.tdm <- TermDocumentMatrix(s.cor.cl)

	s.tdm <-  removeSparesTerm(s.tdm, 0.7)
	result <- list(name = cand, tdm = s.tdm)
}
tdm <- lappy(candidates, generateTDM, path = pathname)