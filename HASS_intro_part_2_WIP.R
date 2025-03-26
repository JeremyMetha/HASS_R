# setting up
rm(list = ls())
setwd("~/Documents/HASS_R")

# today we'll be using a couple of libraries - if the below library calls don't work, install these with
# install.packages("tidyverse")
# install.packages("gutenbergr")
library(tidyverse)
library(gutenbergr)
# dataframes

# load data from packages

works <- gutenberg_works() # a dataframe of information about project gutenberg books - part of the gutenbergr package

# load data from the web more generally

trump %>%  <- read_csv("https://go.unimelb.edu.au/tt3r") # trump's tweeting habits circa late 2019 - early 2020 - stored as as .csv file on google drive
imdb <- read_csv("https://go.unimelb.edu.au/p8is") # data from the internet movie database (IMDb) - another .csv on a google drive.


# accessing data in dataframes
# can use subsetting like vectors, but need two indexes

# df[row, column] to get a specific row number and column number

works[24,2]
works[24,]
works[,2]

waroftheworlds <- gutenberg_download(36)

#can also access data in specific columns with df$name

trump %>% $text

# finding key words

# str_detect() tells us if a character cell contains a pattern

sum(str_detect(trump %>% $text, pattern = "America"))

####
# Challenge 1: Getting started with dataframes

#   a) Find the gutenberg ID for "Paradise Lost" from the gutenberg works dataframe, and download a copy of it using the gutenberg_download() function

paradise_lost <- gutenberg_download(26)

#   b) How many of the trump tweets contain the term "MAGA"? What percentage of the entire dataset is this?

sum(str_detect(trump$text, pattern = "MAGA"))/598*100


# dataframe manipulations with dplyr

# select

title_author <- select(works, title, author)
useful_bits <- select(works, -language, -rights, -has_text)


# filter

johnmilton <- filter(works, author == "Milton, John")
pre_2010 <- filter(imdb, year < 2010)
america <- filter(trump, str_detect(text, pattern = "America"))


####
# Challenge 2: Filter and Select

#  a) Create a subset of the imdb dataframe that contains only comedy movies that made money (gross > 0)

comedy_money <- imdb %>%
  filter(genre == "Comedy" & gross > 0)

#  b) Create a subset of the trump dataframe that contains those tweets with the phrase "MAGA" in them, then remove the id_str and source columns from this.

MAGA <- trump %>%
  filter(str_detect(text, pattern = "MAGA")) %>%
  select(-source, -id_str)

####

# mutate

imdb <- imdb %>%
  mutate(length_hours = length*60)

imdb <- imdb %>%
  mutate(audience = audience * 10)

waroftheworlds <- waroftheworlds %>%
  mutate(text <- tolower(text))


####
# Challenge 3: Mutate

#  a) Convert the text column of paradise lost to be all lowercase.

paradise_lost <- paradise_lost %>%
  mutate(text_lower = tolower(text))

#  b) Create a new column of the trump dataframe that contains character counts of his tweets, the str_count() function from last week will be useful to use inside mutate here!
trump <- trump %>%
  mutate(count = str_count(text))

####


# summarise

moviesummary <- imdb %>%
  summarise(meanLength = mean(length),
            meanAudience = mean(audience),
            sdAudience = sd(audience),
            meanCritic = mean(critic),
            sdCritic = sd(critic))

#group_by

moviesummary <- imdb %>%
  group_by(genre) %>%
  summarise(meanLength = mean(length),
            meanAudience = mean(audience),
            sdAudience = sd(audience),
            meanCritic = mean(critic),
            sdCritic = sd(critic),
            count = n())

library(tidytext)
war2 <- waroftheworlds %>%
  unnest_tokens(word, text)

paradise_summary <- paradise2 %>%
  group_by(word) %>%
  summarise(count = n())
####
# Challenge 4: Group_by and Summary

#  a) Have a look at some summary statistics for the IMDb database on a genre by genre basis. Which genres do the general public and critics tend to view favourably?

#  b) Find the most frequently occurring words in paradise lost

####

# removing stop words

stop_words


war_trimmed <- war2 %>%
  anti_join(stop_words) %>%
  group_by(word) %>%
  summarise(count = n())

# the TF_IDF metric
# term_frequency(word) = n(word)/n(total words in text)
# inverse_document_frequency = log(n(documents)/n(documents containing word))
# tf_idf = the two multiplied together, a good measure of word importance!


# First, we'll need some documents to draw from

# so let's collect a corpus of text from the gutenberg library
# something odd seems to be going on with some of the sites hosting the gutenberg data, so let's use this one
good_mirror <- "http://mirror.csclub.uwaterloo.ca/gutenberg"


corpus <- gutenberg_download(c(28885, 36, 26, 21, 7999, 70), meta_fields = c("title", "author"), mirror = good_mirror)

tidy_corpus <- corpus %>%
  group_by(title, author) %>%
  unnest_tokens(word, text) %>%
  mutate(word = str_extract(word, "[a-z']+")) %>%
  na.omit()


tf_idf <- tidy_corpus %>%
  group_by(word, title, author) %>%
  summarise(count = n()) %>%
  bind_tf_idf(word, title, count)


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

# let's grab some sentiments

nrc <- get_sentiments("nrc")
bing <- get_sentiments("bing")
afinn <- get_sentiments("afinn")

# again, let's grab some text

works %>%
  filter(author == "Austen, Jane")

austen_books <- gutenberg_download(c(105, 121, 141, 158, 946, 1212, 1342, 21839), meta_fields = "title",
                   mirror = "http://mirror.csclub.uwaterloo.ca/gutenberg")

# and turn it into a tidy format

tidy_austen <- austen_books %>%
  group_by(title) %>%
  mutate(line_number = row_number()) %>%
  ungroup() %>%
  unnest_tokens(word, text)

# counting sentiment words

joy_words <- nrc %>%
  filter(sentiment == "joy")


pride_prejudice <- tidy_austen %>%
  filter(title == "Pride and Prejudice") %>%
  inner_join(joy_words) %>%
  group_by(word) %>%
  summarise(count = n())

# finding narrative arcs

austen_sentiments <- tidy_austen %>%
  inner_join(bing) %>%
  mutate(index = floor(line_number/50)) %>%
  group_by(title, index) %>%
  summarise(positive = sum(sentiment == "positive"),
            negative = sum(sentiment == "negative"),
            net = positive - negative)

ggplot(austen_sentiments, aes(x = index, y = net, fill = title)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~title, scales = "free_x")

# comparing databases?

northangerabbey <- tidy_austen %>%
  filter(title == "Northanger Abbey")

abbey_bing <- northangerabbey %>%
  inner_join(bing) %>%
  mutate(index = floor(line_number/50)) %>%
  group_by(title, index) %>%
  summarise(positive = sum(sentiment == "positive"),
            negative = sum(sentiment == "negative"),
            net = positive - negative) %>%
  mutate(method = "bing")

abbey_nrc <- northangerabbey %>%
  inner_join(nrc) %>%
  mutate(index = floor(line_number/50)) %>%
  group_by(title, index) %>%
  summarise(positive = sum(sentiment == "positive"),
            negative = sum(sentiment == "negative"),
            net = positive - negative) %>%
  mutate(method = "nrc")

abbey_afinn <- northangerabbey %>%
  inner_join(afinn) %>%
  mutate(index = floor(line_number/50)) %>%
  group_by(title, index) %>%
  summarise(net = sum(value)) %>%
  mutate(method = "afinn")


abbey_all <- rbind(abbey_afinn, abbey_bing, abbey_nrc)

ggplot(abbey_all, aes(x = index, y = net, fill = method)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~method, ncol = 1, scales = "free_x")


####
# Challenge 7: Sentiment analysis

#  a) Using the example code above, calculate and plot sentiment scores over text sections for 4 of your favourite books in the gutenberg collection.

####

