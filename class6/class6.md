# Class 6: R Functions
Deborah Sigaud Kutner (PID: A69027018)
2024-01-26

# First R function

All functions have three parts:

- Name;
- Input arguments (none, one or more);
- Body;

A function to add 1 to a number:

``` r
sillyadd <- function(x) {
  x + 1
}

sillyadd(10)
```

    [1] 11

A function to add two numbers:

``` r
sillyadd <- function(x, y=1) {   # Default value of y is 1 if the user doesn't specify
  x + y
}

sillyadd(10, 3)
```

    [1] 13

``` r
sillyadd(10)
```

    [1] 11

# Lab 6 questions

**Q1. Write a function grade() to determine an overall grade from a
vector of student homework assignment scores dropping the lowest single
score. If a student misses a homework (i.e. has an NA value) this can be
used as a score to be potentially dropped. Your final function should be
adequately explained with code comments and be able to work on an
example class gradebook such as this one in CSV format:
“https://tinyurl.com/gradeinput” \[3pts\]**

``` r
student1 <- c(100, 100, 100, 100, 100, 100, 100, 90)
student2 <- c(100, NA, 90, 90, 90, 90, 97, 80)
student3 <- c(100, NA, NA, NA, NA, NA, NA, NA)

grade <- function(x) {                 # x is a vector of grades
  
  x[is.na(x)] <- 0                     #transform all NAs in 0
  mean(x[-which.min(x)], na.rm = T)    #do the mean without the minimum value

}

grade(student1)
```

    [1] 100

``` r
grade(student2)
```

    [1] 91

``` r
grade(student3)
```

    [1] 14.28571

All students:

``` r
gradebook <- read.csv("https://tinyurl.com/gradeinput", row.names = 1)

apply(X = gradebook, MARGIN = 1, FUN = grade)
```

     student-1  student-2  student-3  student-4  student-5  student-6  student-7 
         91.75      82.50      84.25      84.25      88.25      89.00      94.00 
     student-8  student-9 student-10 student-11 student-12 student-13 student-14 
         93.75      87.75      79.00      86.00      91.75      92.25      87.75 
    student-15 student-16 student-17 student-18 student-19 student-20 
         78.75      89.50      88.00      94.50      82.75      82.75 

**Q2. Using your grade() function and the supplied gradebook, Who is the
top scoring student overall in the gradebook? \[3pts\]**

``` r
which.max(apply(X = gradebook, MARGIN = 1, FUN = grade))
```

    student-18 
            18 

The top scoring student was student 18.

**Q3. From your analysis of the gradebook, which homework was toughest
on students (i.e. obtained the lowest scores overall? \[2pts\]**

``` r
apply(gradebook, MARGIN = 2, FUN = mean, na.rm = T) # na.rm = T to calculate the mean without considering NA values
```

         hw1      hw2      hw3      hw4      hw5 
    89.00000 80.88889 80.80000 89.63158 83.42105 

``` r
which.min(apply(gradebook, MARGIN = 2, FUN = mean, na.rm = T)) 
```

    hw3 
      3 

The toughest homework was number 3, with the lowest mean of 80.8.

**Q4. Optional Extension: From your analysis of the gradebook, which
homework was most predictive of overall score (i.e. highest correlation
with average grade score)? \[1pt\]**

``` r
mask.gradebook <- gradebook
mask.gradebook[is.na(mask.gradebook)] <- 0
grades <- apply(X = gradebook, MARGIN = 1, FUN = grade)

apply(mask.gradebook, 2, FUN = cor, x=grades)
```

          hw1       hw2       hw3       hw4       hw5 
    0.4250204 0.1767780 0.3042561 0.3810884 0.6325982 

``` r
which.max(apply(mask.gradebook, 2, FUN = cor, x=grades))
```

    hw5 
      5 

Homework 5 was the most predictive of overall scores, with a correlation
of 0.63.
