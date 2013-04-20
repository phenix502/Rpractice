# 读取数据
hotdogs<-read.csv("http://datasets.flowingdata.com/hot-dog-contest-winners.csv",sep=",",header=TRUE)
# 颜色向量
   fill_colors<-c()
for( i in 1:length(hotdogs$Country))
  {
  if(hotdogs$Country[i]== "United States")
    {
      fill_colors<-c(fill_colors,"#821122")
    } 
  else
    {
      fill_colors<-c(fill_colors,"#cccccc")
    }
}

barplot(hotdogs$Dogs.eaten,names.arg=hotdogs$Year,col=fill_colors,
	border=NA,xlab="Year",ylab="Hot dogs and burns (HDB) eaten")
