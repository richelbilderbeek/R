library(ape)
library(geiger)

newick <- "((((A,B), C), (D,E)),F);"
phylogeny <- read.tree(text = newick)

svg(filename="CreateTreeFromNewick.svg")
plot(phylogeny)
dev.off()

# Note: must have a semicolon at the end
newick <- "((((0:1.9731487278617976,(2:0.02385862495086483,5:0.02385862495086483)12:1.9492901029109329)17:0.5602600580639896,(1:0.15558418773033483,6:0.15558418773033483)10:2.377824598195452)13:3.54396556997399,(3:0.8046576734483606,9:0.8046576734483606)16:5.272716682451416)11:6.921407992888125,((4:0.6362512899069979,8:0.6362512899069979)14:2.317725193372067,7:2.9539764832790647)15:10.044805865508838)18:0.0;"
phylogeny <- read.tree(text = newick)
print(phylogeny)
svg(filename="CreateTreeFromNewick2.svg")
plot(phylogeny)
dev.off()


# These are tests
newick <- "(A):0;" # OK, but not plottable
phylogeny <- read.tree(text = newick)
print(phylogeny)
plot(phylogeny)

newick <- "(A:0);" # OK, but not plottable
newick <- "(A);" # OK, but not plottable

newick <- "A;" # FAILS
phylogeny <- read.tree(text = newick)
print(phylogeny)
plot(phylogeny)

newick <- "(A:1);" # OK, but not plottable
phylogeny <- read.tree(text = newick)
print(phylogeny)
plot(phylogeny)

newick <- "(A:1,B:1);" # OK
phylogeny <- read.tree(text = newick)
plot(phylogeny)

newick <- "(A:1,B:1):0;" # OK
phylogeny <- read.tree(text = newick)
plot(phylogeny)


newick <- "(A:1,B:1):1;" # OK
phylogeny <- read.tree(text = newick)
plot(phylogeny)

newick <- "(A:1,B:1):1,C:1;" # FAILS
newick <- "(A:1,B:1):1,C;" # FAILS
newick <- "(A:1,B:1):1,C:1;" # FAILS

newick <- "(C:2,(A:1,B:1):1);" # OK

newick <- "((A:1,B:1):1,C:1);" # OK

newick <- "((C:1,D:1):1,E:2);" # OK

newick <- "((F:2,G:2):1,H:3);" # OK

phylogeny <- read.tree(text = newick)
plot(phylogeny)


phylogeny <- read.tree(text = "((A:0.3,B:0.3):0.7,(C:0.6,D:0.6):0.4);"); plot(phylogeny) 
