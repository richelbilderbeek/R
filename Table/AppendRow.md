# Append a row to a data.frame

```
dist_m<-c(1600,1970,1800)
Species<-c("Bare_ground","Bare_ground","Bare_ground")
Cover_2x2m<-c(100,100,100)
# bind the together in a dataframe
newrows<-data.frame(dist_m,Species,Cover_2x2m)
data7<-rbind(data7,newrows) #Append data
```
