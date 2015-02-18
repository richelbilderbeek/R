# (R) Assignment operator

From https://stat.ethz.ch/R-manual/R-devel/library/base/html/assignOps.html:
```
The operators <- and = assign into the environment in which they are evaluated. The operator <- can be used anywhere, whereas the operator = is only allowed at the top level (e.g., in the complete expression typed at the command prompt) or as one of the subexpressions in a braced list of expressions. 
```

Google's R style guide prohibits using `=`, use `<-` instead
https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml