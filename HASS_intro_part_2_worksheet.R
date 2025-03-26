# setting up
rm(list = ls())
setwd()

# today we'll be using a couple of libraries - if the below library calls don't work, install these with
# install.packages("tidyverse")
# install.packages("gutenbergr")
library(tidyverse)
library(gutenbergr)
# dataframes

# load data from packages

works <- gutenberg_works() # a dataframe of information about project gutenberg books - part of the gutenbergr package

# load data from the web more generally

trump <- read_csv("https://go.unimelb.edu.au/tt3r") # trump's tweeting habits circa late 2019 - early 2020 - stored as as .csv file on google drive
imdb <- read_csv("https://go.unimelb.edu.au/p8is") # data from the internet movie database (IMDb) - another .csv on a google drive.


# accessing data in dataframes
# can use subsetting like vectors, but need two indexes

# df[row, column] to get a specific row number and column number


#can also access data in specific columns with df$name

# finding key words

# str_detect() tells us if a character cell contains a pattern

####
# Challenge 1: Getting started with dataframes

#   a) Find the gutenberg ID for "Paradise Lost" from the gutenberg works dataframe, and download a copy of it using the gutenberg_download() function


#   b) How many of the trump tweets contain the term "MAGA"? What percentage of the entire dataset is this?



# dataframe manipulations with dplyr

# select


# filter


####
# Challenge 2: filter and select

#  a) Create a subset of the imdb dataframe that contains only comedy movies that made money (gross > 0)

#  b) Create a subset of the trump dataframe that contains those tweets with the phrase "MAGA" in them, then remove the id_str and source columns from this.



####

# mutate



####
# Challenge 3: mutate

#  a) Convert the text column of paradise lost to be all lowercase.


#  b) Create a new column of the trump dataframe that contains character counts of his tweets, the str_count() function from last week will be useful to use

####


# summarise

#group_by


####
# Challenge 4: group_by and summarise

#  a) Have a look at some summary statistics for the IMDb database on a genre by genre basis. Which genres do the general public and critics tend to view favourably?

#  b) Find the most frequently occurring words in paradise lost

####

# removing stop words

stop_words


# the TF_IDF metric
# term_frequency(word) = n(word)/n(total words in text)
# inverse_document_frequency = log(n(documents)/n(documents containing word))
# tf_idf = the two multiplied together, a good measure of word importance!


# First, we'll need some documents to draw from

# so let's collect a corpus of text from the gutenberg library
# something odd seems to be going on with some of the sites hosting the gutenberg data, so let's use this one
good_mirror <- "http://mirror.csclub.uwaterloo.ca/gutenberg"



# pre-bottled tf-idf visualisation using ggplot (come to Mar's visualisation session to learn more!)


for_visualisation <- tf_idf %>%
  group_by(title) %>%
  slice_max(tf_idf, n = 15) # grab the 15 highest values for each book

ggplot(data = for_visualisation, # choosing our dataset
       aes(x = tf_idf, y =  reorder(word, tf_idf), fill = title)) + # setting the attribute of our data to plot
geom_col(show.legend = FALSE) + # the actual shape that will show up on our plot
facet_wrap(~title, scales = "free") + # creating sub-plots for each individual book, rather than one big plot for everything - scales makes it so that all our axes on subplots are independant of each other
labs(x = "tf-idf", y = NULL, title = "Top 15 TF-IDF words across a corpus of books") + # adding labels
theme(plot.title = element_text(hjust = 0.5)) # centering the title over the plots


####
# Challenge 6: Stop-words and TF-IDF

#  a) Using the example code above, calculate and plot TF-IDF scores for works in the physics bookshelf of the gutenberg collection.
#     To get you started physics <- filter(works, gutenberg_bookshelf == "Physics")$gutenberg_id will get you a vector of IDs to pass to gutenberg_download()
#     make sure to use the mirror from above too, as it seems to be the most reliable

#  b) Compare this visualisation to the most common words found using the stop-word removal technique we used on the war of the world and paradise lost. How different are the two sets of words?

####

# sentiment analysis
# getting the idea of the "sentiment" of a body of text

# let's grab some sentiments
nrc <- get_sentiments("nrc")
bing <- get_sentiments("bing")
afinn <- get_sentiments("afinn")

# again, let's grab some text


# and turn it into a tidy format


# counting sentiment words


# finding narrative arcs


# comparing sentiment databases?


# Challenge 7: Sentiment analysis

#  a) Using the example code above, calculate and plot sentiment scores over text sections for 4 of your favourite books in the gutenberg collection.

####

