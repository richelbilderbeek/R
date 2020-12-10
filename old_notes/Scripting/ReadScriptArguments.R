print("commandArgs()")
print(commandArgs())
# [1] "/usr/lib/R/bin/exec/R"        "--slave"                     
# [3] "--no-restore"                 "--file=ReadScriptArguments.R"
# [5] "--args"                       "my_first_argument"           
# [7] "my_second_argument"          

print("commandArgs(TRUE)")
print(commandArgs(TRUE))
#  [1] "my_first_argument"  "my_second_argument"

print("commandArgs(TRUE)[1]")
print(commandArgs(TRUE)[1])
#  [1] "my_first_argument"

print("commandArgs(TRUE)[2]")
print(commandArgs(TRUE)[2])
# [1] "my_second_argument"
