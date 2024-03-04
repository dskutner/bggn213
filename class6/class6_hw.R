# Can you improve this analysis code? 
library(bio3d) 

s1 <- read.pdb("4AKE")  # kinase with drug 
s2 <- read.pdb("1AKE")  # kinase no drug 
s3 <- read.pdb("1E4Y")  # kinase with drug 

s1.chainA <- trim.pdb(s1, chain="A", elety="CA") 
s2.chainA <- trim.pdb(s2, chain="A", elety="CA") 
s3.chainA <- trim.pdb(s3, chain="A", elety="CA") 

s1.b <- s1.chainA$atom$b 
s2.b <- s2.chainA$atom$b 
s3.b <- s3.chainA$atom$b 

plotb3(s1.b, sse=s1.chainA, typ="l", ylab="Bfactor") 
plotb3(s2.b, sse=s2.chainA, typ="l", ylab="Bfactor") 
plotb3(s3.b, sse=s3.chainA, typ="l", ylab="Bfactor")

# 

protein <- function(code, chain = "A", elety="CA", typ="l", ylab="Bfactor") {
  pdb <- read.pdb(code)
  chain <- trim.pdb(pdb, chain=chain, elety=elety) 
  plotb3(chain$atom$b, sse=chain, typ=typ, ylab=ylab) # return the plot
  chain$atom$b                                        # return the vector
}

protein(code = "4AKE")

files <- c("4AKE", "1AKE", "1E4Y")

apply(as.matrix(files), 1, protein)

