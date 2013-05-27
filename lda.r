# 加载包
libs <- c ("tm", "topicmodels","Rwordseg")
lapply(libs,require,character.only = TRUE)

# set options
options(stringASFactors = FALSE)

# 读取停止词
mystopwords<- unlist (read.table("stopword.txt",stringsAsFactors=F)) 

#读取语料库的路径
pathname <- "D:/Rcode/LDA/corpus"

#clean text

cleancorpus <- function(corpus){
  #分词
  corpus.tmp <- tm_map(corpus, segmentCN)
  return(corpus.tmp)
}

#  产生TDM
cor <- Corpus(DirSource(directory = pathname, encoding = "UTF-8"))
# cor.cl <- cleancorpus(cor)
cor.cl <- tm_map(cor,segmentCN)
# tdm <- TermDocumentMatrix(cor.cl,control = list(stopwords = mystopwords))  
tdm <- DocumentTermMatrix(cor.cl)  
