library(testit)

# This function is heavily inspired by the DAISIE_plot_sims
# function, by Rampal S. Etienne, Luis M. Valente, Albert B. Phillimore & Bart Haegeman
plot_average_ltt_and_quartiles <- function(island_replicates)
{
  assert(class(island_replicates) == "list")
  assert(class(island_replicates[[1]]) == "list")
  assert(class(island_replicates[[1]][[1]]) == "list")
  assert(names(island_replicates[[1]][[1]]) == c("island_age","not_present","stt_all"))
  assert(class(island_replicates[[1]][[1]]$stt_all) == "matrix")
  assert(is.null(names(island_replicates[[1]][[1]]$stt_all)))
  
  replicates<-length(island_replicates)
  time<-max(island_replicates[[1]][[1]]$stt_all[,1])
  
  ###  STT ALL species
  s_freq<-length(island_replicates[[1]][[1]]$stt_all[,1])
  complete_arr <-array(dim=c(s_freq,7,replicates))
  
  for(x in 1:replicates)
  {
    sum_endemics<-island_replicates[[x]][[1]]$stt_all[,"nA"]+island_replicates[[x]][[1]]$stt_all[,"nC"]
    total<-island_replicates[[x]][[1]]$stt_all[,"nA"]+island_replicates[[x]][[1]]$stt_all[,"nC"]+island_replicates[[x]][[1]]$stt_all[,"nI"]
    complete_arr[,,x]<-cbind(island_replicates[[x]][[1]]$stt_all,sum_endemics,total)
  }
  
  
  stt_average_all<-apply(complete_arr,c(1,2),median)
  stt_q0.025_all<-apply(complete_arr,c(1,2),quantile,0.025)
  stt_q0.25_all<-apply(complete_arr,c(1,2),quantile,0.25)
  stt_q0.75_all<-apply(complete_arr,c(1,2),quantile,0.75)
  stt_q0.975_all<-apply(complete_arr,c(1,2),quantile,0.975)
  
  colnames(stt_average_all)<-c("Time","nI","nA","nC","present","Endemic","Total")
  colnames(stt_q0.025_all)<-c("Time","nI","nA","nC","present","Endemic","Total")
  colnames(stt_q0.25_all)<-c("Time","nI","nA","nC","present","Endemic","Total")
  colnames(stt_q0.75_all)<-c("Time","nI","nA","nC","present","Endemic","Total")
  colnames(stt_q0.975_all)<-c("Time","nI","nA","nC","present","Endemic","Total")
  
  
  dev.new(width=6, height=6)
  par(mfrow=c(1,1)) 
  suppressWarnings(plot(NULL,NULL,xlim=rev(c(0, time)),ylim=c(1,max(stt_q0.975_all)),ylab="No of species + 1",bty="l", xaxs="i",xlab="Time before present",main="Species-through-time - All species",log='y',cex.lab=1.2,cex.main=1.2,cex.axis=1.2))
  polygon(c(stt_average_all[,"Time"],rev(stt_average_all[,"Time"])),c(stt_q0.025_all[,"Total"]+1,rev(stt_q0.975_all[,"Total"]+1)),col="light grey",border=NA)
  polygon(c(stt_average_all[,"Time"],rev(stt_average_all[,"Time"])),c(stt_q0.25_all[,"Total"]+1,rev(stt_q0.75_all[,"Total"]+1)),col="dark grey",border=NA)
  lines(stt_average_all[,"Time"],stt_average_all[,"Total"]+1,lwd=2)
  lines(stt_average_all[,"Time"],stt_average_all[,"nI"]+1,lwd=2,col='cyan3')
  lines(stt_average_all[,"Time"],stt_average_all[,"Endemic"]+1,lwd=2,col='dodgerblue1')
  
  legend(time,max(stt_q0.975_all),c("Total","Non-endemic","Endemic"),lty=1,lwd=2,col=c("black","cyan3","dodgerblue1"),cex=1.2,border=NA,bty='n')

}