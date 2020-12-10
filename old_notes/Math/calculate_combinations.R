library(testit)

#            (5)    5!     120
# Calculate  ( ) = ---- = ----- = 10
#            (3)   2!3!   2 * 6


result_factorials <- factorial(5) / (factorial(2) * factorial(3))
result_choose <- choose(5,2)

assert("Both calculations should be identical",result_factorials == result_choose)