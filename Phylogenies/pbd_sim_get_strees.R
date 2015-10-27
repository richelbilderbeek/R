pbd_sim = function(pars,age,soc = 2)
{

sample2 = function(x,size,replace = FALSE,prob = NULL)
{
    if(length(x) == 1)
    { 
        x = c(x,x)
        prob = c(prob,prob)
    }
    return(sample(x,size,replace,prob))
}

checkgood = function(L,si,sg,id1)
{
    j = 1;
    found = 0
    if(length(sg) > 0)
    {  
       found = 1
    } else {
    if(length(si) + length(sg) == 0) { found = 0 } else {
    while(found == 0 & j <= length(si))
    {           
        parent = L[si[j] - id1,2]
        birth = L[si[j] - id1,3]
        while(parent > 1)
        {   
            if(L[parent - id1,4] > -1 & L[parent - id1,4] < birth)
            {
                parent = 0
                found = 1
            } else
            {
                parent = L[parent - id1,2]
                birth = L[parent - id1,3]
            }
        }
        j = j + 1
    }}}
    invisible(found)
}

#detphy = function(L,sall,age)
detphy = function(L,age)
{
   L = L[order(L[,1]),1:6]
   sall = which(L[,5] == -1)
   linlist = matrix(0,nrow = 1,ncol = 8)
   if(length(sall) == 1)
   {
      linlist[1,] = c(L[sall,],paste("S",paste(L[sall,6],L[sall,6],L[sall,1],sep = "_"),sep = ""),age)
   } else {
      linlist = cbind(L[sall,],paste("S",paste(L[sall,6],L[sall,6],L[sall,1],sep = "_"),sep = ""),age)
   }
   done = 0
   while(done == 0)
   {
      j = which.max(linlist[,3])      
      daughter = linlist[j,1]
      parent = linlist[j,2]
      parentj = which(linlist[,1] == parent)
      parentinlist = length(parentj)
      if(parentinlist == 1)
      {
          spec1 = paste(linlist[parentj,7],":",as.numeric(linlist[parentj,8]) - as.numeric(linlist[j,3]),sep = "")
          spec2 = paste(linlist[j,7],":",as.numeric(linlist[j,8]) - as.numeric(linlist[j,3]),sep = "")
          linlist[parentj,7] = paste("(",spec1,",",spec2,")",sep = "")
          linlist[parentj,8] = linlist[j,3]
          linlist = linlist[-j,]
      } else {
          if(as.numeric(parent) != 0)
          {
              linlist[j,1:5] = L[which(L[,1] == as.numeric(parent)),1:5]
          }
      }
      #print(linlist)
      if(is.null(nrow(linlist)))
      { 
          done = 1
          linlist[7] = paste(linlist[7],":",abs(as.numeric(linlist[3])),";",sep = "")
      } else {
          if(nrow(linlist) == 1)
          { 
              done = 1
              linlist[7] = paste("(",linlist[7],":",age,");",sep = "")
          }
      }
   }
   #linlist[7] = paste("(",linlist[7],":",abs(as.numeric(linlist[3])),",dummytip:200);",sep = "")
   return(linlist)
}

sampletree = function(L)
{
   lenL = length(L[,1])
   randomorder = sample2(1:lenL,replace = F)
   L2 = L[randomorder,]
   ss = NULL;
   for(i in 1:lenL)
   {
       if(L2[i,5] == -1)
       {
           if(is.element(L2[i,6],ss) == FALSE)
           {
              ss = c(ss,L2[i,6])
              #print(ss)
           } else {
              L2[i,5] = age #peudo extinction just before the present
           }
       }
   }
   L2 = L2[order(L2[,3]),]
   #print(L2)
   #flush.console()
   return(L2)
}

la1 = pars[1]
la2 = pars[2]
la3 = pars[3]
mu1 = pars[4]
mu2 = pars[5]

i = 1
while(i <= soc)
{
   t = 0
   if(i == 1)
   {
      id1 = 0
      id = id1 + 1
      Sid1 = 0
      Sid = Sid1 + 1
      sg = id
      si = NULL
      L = t(as.matrix(c(id,0,-1e-10,t,-1,1)))
   }
   if(i == 2)
   {
      id = id1 + 1
      Sid = Sid1 + 1
      sg = NULL
      si = id
      L = t(as.matrix(c(id,1,t,-1,-1,1)))
      #L = rbind(L1,t(as.matrix(c(id,1,t,-1,-1,1))))
   }

   Ng = length(sg)
   Ni = length(si)  
   probs = c(la1*Ng,mu1*Ng,la2*Ni,la3*Ni,mu2*Ni)   
   denom = sum(probs) 
   probs = probs/denom
   t = t - log(runif(1))/denom

   while(t <= age)
   {
      event = sample2(1:5,size = 1,prob = probs)
      if(event == 1)
      {
          parent = as.numeric(sample2(sg,1))
          id = id + 1
          L = rbind(L,c(id,parent,t,-1,-1,L[parent - id1,6]))
          si = c(si,id)
          Ni = Ni + 1
      }
      if(event == 2)
      {
          todie = as.numeric(sample2(sg,1))
          L[todie - id1,5] = t
          sg = sg[-which(sg == todie)]
          Ng = Ng - 1
      }
      if(event == 3)
      {
          tocomplete = as.numeric(sample2(si,1))
          L[tocomplete - id1,4] = t
          Sid = Sid + 1
          L[tocomplete - id1,6] = Sid      
          sg = c(sg,tocomplete)
          si = si[-which(si == tocomplete)]
          Ng = Ng + 1
          Ni = Ni - 1
      }
      if(event == 4)
      {
          parent = as.numeric(sample2(si,1))
          id = id + 1
          L = rbind(L,c(id,parent,t,-1,-1,L[parent - id1,6]))
          si = c(si,id)
          Ni = Ni + 1
      }
      if(event == 5)
      {
          todie = as.numeric(sample2(si,1))
          L[todie - id1,5] = t
          si = si[-which(si == todie)]
          Ni = Ni - 1
      }
      probs = c(la1*Ng,mu1*Ng,la2*Ni,la3*Ni,mu2*Ni)   
      denom = sum(probs) 
      probs = probs/denom
      t = t - log(runif(1))/denom
   }
   if(i == 1)
   {
       if((Ng + Ni) > 0)
       {
           i = i + 1
           L1 = L
           id1 = id
           Sid1 = Sid
           si1 = si
           sg1 = sg
       }       
   } else {
   if(i == 2)
   {
       if(checkgood(L,si,sg,id1) == 1)
       {
           i = i + 1
           L2 = L   
           si2 = si
           sg2 = sg                   
       }       
   }} 
}
L = L1
if(soc == 2)
{
    L = rbind(L1,L2)
}
#ff = detphy(L,sort(c(sg1,sg2,si1,si2)),age)
#L = cbind(L[,3],L[,1:2],L[,4:6])
#phy = newick2phylog(ff[7])
#print(L)    
tree = as.phylo(read.tree(text = detphy(L,age)))
stree = as.phylo(read.tree(text = detphy(sampletree(L),age)))
L[,3:5][which(L[,3:5] == -1)] = age + 1
L[,3:5] = age - L[,3:5]
out = list(tree,stree,L)
return(out)
}