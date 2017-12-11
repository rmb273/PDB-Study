# R Script for DTF and TFIDF Analyses with Words of Estimative Probability

# CLEAN SLATE
# Specify working directory 
setwd("~/Desktop/PDBSALTStudy")
# Clear variables
rm(list=ls())
# Clear plots
graphics.off()
# Clear command line screen
cat("\014")


# INSTALL AND CHECK REQUIRED PACKAGES
# install.packages("cluster")
require(cluster)
# install.packages("tm") # tm = text mining
require(tm)
# install.packages("NLP") # nlp = natural language processing infrastructure
require(NLP)
# install.packages("lsa") # lsa = latent semantic analysis
# require (lsa)
# install.packages("tokenizers")
# require(tokenizers)
# install.packages("tau") # tau = text analysis utilities
# require(tau)


# ESTABLISH AND CLEAN CORPUS OF TEXT FILES
# Specify directory where .txt file(s) for analysis exist and establish corpus
corpus <- Corpus(DirSource("~/Desktop/PDBSALTStudy"), readerControl = list(language="lat"))
corpus <- sapply(corpus, function(row) iconv(row, "latin1", "ASCII", sub=""))
corpus <- Corpus(VectorSource(corpus))
# Clean corpus
remove_dash <- function(x) gsub("-", " ",x)
corpus <- tm_map(corpus, content_transformer(remove_dash))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stripWhitespace)


# ESTABLISH LIST OF TERMS TO PARSE
wepList <- c("possible", "perhaps", "probable", "likely", "improbable", "unlikely", "undoubtedly", "might", "could", "may", "50-50", "certain", "certainly", "possible", "possibility", "uncertain", "impossible", "likely", "unlikely", "conceivable", "improbable", "might", "probable", "probably", "doubtless", "undoubtedly", "could", "may", "perhaps", "maybe", "reportedly", "is conceivable", "almost certain", "virtually certain", "all but certain", "highly probable", "highly likely", "odds overwhelming", "chances overwhelming", "we believe", "we estimate", "highly unlikely", "we doubt", "virtually impossible", "almost impossible", "most likely", "almost certainly", "is doubtful", "highly doubtful", "is obviously", "probably not", "almost certain", "almost certainly", "probably not", "may well", "virtually certain", "virtual certainty", "highly probable", "highly likely", "odds overwhelming", "chances overwhelming", "we believe", "we estimate", "we predict", "we think", "we assume", "we guess", "we suspect", "we judge", "we doubt", "highly doubtful", "significant uncertainty", "signifcantly uncertain", "exceptionally unlikely", "very unlikely", "very likely", "exceptionally likely", "moderate risk", "chances about even", "the possibility exists", "probably will not", "probably is not", "almost certainly not", "we believe that", "we estimate that", "we expect that", "some slight chance", "do not indicate", "there are signs", "is not unlikely", "chances about even", "almost certainly not", "all but certain", "odds are overwhelming", "chances are overwhelming", "we are doubtful", "some slight chance", "reasonable to assume", "indicate patterns of", "indicates patterns of", "we cannot dismiss", "we cannot rule out", "we cannot discount", "is expected to be", "chances are about even", "it is our judgment", "it is our belief", "it is our estimate", "it is our suspicion", "it is our assumption", "about as likely as not", "we are of the belief", "chances slightly better than even", "chances slightly worse than even", "chances slightly greater than even", "chances slightly less than even", "chances a little better than even", "chances a little worse than even", "chances a little better than even", "chances a little worse than even", "chances a little greater than even", "chances a little less than even", "chances only slightly better than even", "chances only slightly worse than even", "chances only slightly greater than even", "chances only slightly less than even", "chances are slightly better than even", "chances are slightly worse than even", "chances are slightly greater than even", "chances are slightly less than even", "chances only a little better than even", "chances only a little worse than even", "chances only a little greater than even", "chances only a little less than even", "chances are a little better than even", "chances are a little worse than even", "chances are a little greater than even", "chances are a little less than even", "chances are only slightly better than even", "chances are only slightly worse than even", "chances are only slightly greater than even", "chances are only slightly less than even", "chances are only a little better than even", "chances are only a little worse than even", "chances are only a little greater than even", "chances are only a little less than even")


# CREATE DTM AND INSPECT
 myDTM <- DocumentTermMatrix(corpus)
# inspect(DocumentTermMatrix(corpus, list(dictionary=wepList)))
 myTFIDF <- DocumentTermMatrix(corpus, control = list(weighting = weightTfIdf))
# inspect(myTFIDF, list(dictionary=wepList))

# WRITE PLAIN DTM/TFIDF
# Write files: Document Term Frequency (DTM)
write.csv(as.matrix(myDTM),"Analysis_DTM.csv")
# Write files: Term Frequency/Inverse Document Frequency (TFIDF)
write.csv(as.matrix(myTFIDF),"Analysis_TFIDF.csv")

# WRITE PARSED DTM/TFIDF
# Write files: Document Term Frequency (DTM)
write.csv(as.matrix(DocumentTermMatrix(corpus, list(dictionary=wepList))),"Analysis_DTM_Parsed.csv")
# Write files: Term Frequency/Inverse Document Frequency (TFIDF)
write.csv(as.matrix(DocumentTermMatrix(corpus, control = list(weighting = weightTfIdf))),"Analysis_TFIDF)_Parsed.csv")