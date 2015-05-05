library(ape)
data(woodmouse)

png(filename="ShowAlignment1.png")
image(woodmouse)
dev.off()


x <- structure(c("1", "2", "3", "4", "ACGTA", "ACGTC", "ACGTG", "ACGTT"), .Dim = c(4L, 2L))
y <- t(sapply(strsplit(x[,2],""), tolower))
rownames(y) <- x[,1]
alignments <- as.DNAbin(y)
png(filename="ShowAlignment2.png")
image(alignments)
dev.off()


