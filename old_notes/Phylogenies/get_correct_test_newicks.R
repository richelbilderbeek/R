get_correct_test_newicks <- function()
{
  correct_test_newicks <- c(
    "(A:1,B:1);",
    "(A:1,B:1):0;",
    "(A:1,B:1):1;",
    "(C:2,(A:1,B:1):1);",
    "((A:1,B:1):1,C:1);",
    "((C:1,D:1):1,E:2);",
    "((F:2,G:2):1,H:3);",
    "((((A,B), C), (D,E)),F);",
    "((A:0.3,B:0.3):0.7,(C:0.6,D:0.6):0.4);"
  )
  return (correct_test_newicks)
}
