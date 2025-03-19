# R for HASS


# setting up
rm(list = ls())
setwd()
library(tidyverse) # if you don't have this package, you'll need to install it too with install.packages("tidyverse")


# the console

# scripts


# comparisons




#####
# Challenge 1: Basic Driving

#   a) Basic calculator time! Run the following in the CONSOLE:
#   32*19 + 123,
#   what do you get?

#   b) Run the following in a SCRIPT: 11 + (34 * 10

#   What happens? Do you get a value? Error? Warning?
#   Can you fix it?
#   c) Which one is larger, 34^4 or 25^5? Can you write an
#   expression to solve this?
#####

# text in r

# functions and help

#####
# Challenge 2: Functions and Help

#   a) What does the str_dup function do? Access help.



#   b) How many letters in total are in the words "cabbage", "oblique", and "walrus"


#   c) As usual, Bart Simpson is in trouble at school and writing lines, give him a hand by printing "I will not cut corners. " 1000 times to the console.

#####



# objects and storing data



# names can contain
# letters
# numbers
# underscores
# periods

#names can't
# contain spaces
# start with a number or underscore

# names are (very annoyingly) case sensitive

#####
# Challenge 3: Objects and Storing Data

#   a) Try assigning some data to these names. Which of the following work as names? Think of ways you could fix the ones that don't.
1st_name <-
last_name <-
.age <-
_height <-
FavColour <-
favColour <-
likes_brussels_sprouts <-

#   b) What will be the value of each object below after each step?
width <- 181.2
length <- 85
area <- width * length
width <- 55
too_many_ducks <- "duck "
too_many_ducks <- str_dup(too_many_ducks, 3)
too_many_ducks <- str_dup(too_many_ducks, 3)
#####

# managing your environment

# vectors


#####
## Challenge 4: Vectors

#   a) Create a vector with these numbers:
#      1, 11, 111, 1111


#   b) What is the square root of each of the numbers the vector created in 4a?
#      Store these as another vector.


#   c) Create a vector with the details about first and last name, age, height , favourite colour and spropts preference from challenge 3a. What is the type of this vector?


# more on vectors

# other ways of making vectors


# vector subsetting

#####
# Challenge 5: More vector wrangling

#   a) Using str_split_1, turn our too_many_ducks value into a vector of ducks

#   b) replace the last duck in our vector with a goose instead.

#####

# dataframes

# accesible from within R

# install.packages("gutenbergr")
library(gutenbergr)

works <- gutenberg_works()

# extrinsic files

trump <- read_csv("https://go.unimelb.edu.au/tt3r", stringsAsFactors=FALSE)


# accessing data in dataframes


####
# Challenge 6: Getting started with dataframes

#   a) Find the gutenberg ID for "Paradise Lost" from the gutenberg works dataframe, and download a copy of it using gutenberg_download()

#   b) How many of the trump tweets contain the term "MAGA"? What proportion of the entire dataset is this?

####

