library(tm)
library(topicmodels)
library(Rwordseg)
# 给定文档数，得到一个文件名的列表 1.txt 2.txt 3.txt...n.txt
docname <- function(n){
    doc.name <- paste(1:n,".txt",sep="")
}


# 对文件进行分词，并保存
wordseg <- function (doc.name) {
  # 获取 begin 目录下所有txt文档
  doc.path <- paste("D:/clothe/", doc.name, sep="")
  txt <- readLines(doc.path,encoding='UTF-8')
  res = txt[txt!=" "]
  words = unlist(lapply(X = res,FUN = segmentCN))
  # 分词完保存到clean目录下
  file <- paste("D:/Rcode/LDA/clean/",doc.name)
  write.table(words, file, fileEncoding = 'utf-8')

}


doc.name <- docname(400)
# 对每个文档进行分词
lapply(doc.name,wordseg)

#读取语料库的路径
cor.path <- "corpus"
cor <- Corpus(DirSource(directory = cor.path, encoding = "UTF-8"))

cor.cl <- tm_map(cor,stripWhitespace)
cor.cl <- tm_map(cor.cl,removePunctuation)
cor.cl <- tm_map(cor.cl,removeNumbers)
## 加载停止词
mystopwords <- readLines("stopwords.txt",encoding = "UTF-8")

cor.dtm <- DocumentTermMatrix(cor.cl,control = list(wordLengths = c(2, Inf),stopwords = mystopwords,removePunctuation= TRUE))
dim(cor.dtm)
##去掉稀疏矩阵中地频率的词
cor.dtm <- removeSparseTerms(cor.dtm, 0.99)
## 使得每一行至少有一个词不为0
rowTotals <- apply(cor.dtm, 1, sum)
cor.dtm <- cor.dtm[rowTotals > 0]


result_LDA <- LDA(cor.dtm[1:250,],control = list(alpha = 0.1), k = 5)
jss_CTM <- CTM(cor.dtm[1:250], k = 10)

post <- posterior(result_LDA, newdata = cor.dtm[-c(1:250),])
round(post$topics[1:5,],digits = 2)
get_terms(result_LDA, 5)


