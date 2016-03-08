library(ggplot2)
library(gridExtra)

set.seed(1410)
head(diamonds)
dsmall <- diamonds[sample(nrow(diamonds), 100), ]
qplot(carat, price, data = diamonds)
qplot(log(carat), log(price), data = diamonds)
qplot(carat, x * y * z, data = diamonds)
qplot(carat, price, data = dsmall, colour = color)
qplot(carat, price, data = dsmall, shape = cut)
qplot(carat, price, data = dsmall, colour = color, shape = cut)
qplot(carat, x * y * z, data = diamonds, colour = color, shape = cut)
qplot(clarity, price / carat, data = dsmall, geom = "boxplot")

qplot(carat, price, data = diamonds, alpha = I(1/10))
qplot(carat, price, data = diamonds, alpha = I(1/100))
qplot(carat, price, data = diamonds, alpha = I(1/200))
qplot(price, data = dsmall, geom = "histogram")
qplot(price, data = diamonds, geom = "freqpoly")
qplot(price, data = diamonds, geom = "density")

qplot(carat, price, data = dsmall, geom = c("point","smooth"))
qplot(carat, price, data = diamonds, geom = c("point","smooth"))

library(mgcv)

qplot(carat, price, data = dsmall, geom = c("point")) + stat_smooth(method = "lm", formula = y ~ x + I(x ^ 2), size = 1)
qplot(carat, price, data = dsmall, geom = c("point")) + stat_smooth(method = "gam", formula = y ~ s(x))

qplot(carat, price, data = dsmall, geom = c("point")) +
  stat_smooth(method = "lm", formula = y ~ x + I(x ^ 2), size = 1) +
  stat_smooth(method = "gam", formula = y ~ s(x))
qplot(carat, price, data = dsmall, geom = c("point")) +
  stat_smooth(method = "gam", formula = y ~ s(x), span = 0.01) +
  stat_smooth(method = "gam", formula = y ~ s(x), span = 1.0)
?stat_smooth

qplot(color, price, data = diamonds, geom = "jitter", alpha = I(1/5))
qplot(color, price, data = diamonds, geom = "jitter", alpha = I(1/50))
qplot(color, price, data = diamonds, geom = "jitter", alpha = I(1/200))
qplot(color, price, data = diamonds, geom = "boxplot")

qplot(price, data = diamonds, geom = "density")
qplot(price, data = diamonds, geom = "freqpoly")
qplot(price, data = diamonds, geom = "histogram")
qplot(price, data = diamonds, geom = "histogram", binwidth = 100) # Ha, there is a price that is rare at around 1000
qplot(price, data = diamonds, geom = "histogram", binwidth = 100, fill = color) # Ha, there is a price that is rare at around 1000
qplot(price, data = diamonds, geom = "histogram", binwidth = 100, fill = cut) # Ha, there is a price that is rare at around 1000

qplot(date, unemploy / pop, data = economics, geom = "line")
qplot(date, uempmed, data = economics, geom = "line")
year <- function(x) { as.POSIXlt(x)$year + 1900 }
qplot(unemploy / pop, uempmed, data = economics, geom = c("point", "path"))
qplot(unemploy / pop, uempmed, data = economics, geom = c("point", "path"), color = year(date))
#qplot(unemploy / pop, uempmed, data = economics, geom = c("point", "path"), color = year(date)) + scale_area()


qplot(carat, data = diamonds, facets = color ~ ., geom = "histogram", binwidth = 0.1, xlim = c(0,3))
qplot(carat, ..density.., data = diamonds, facets = color ~ ., geom = "histogram", binwidth = 0.1, xlim = c(0,3))



library(plyr)

# Select the smallest diamond for each color
ddply(diamonds, .(color), subset, carat == min(carat))

ddply(diamonds, .(color), subset, carat == max(carat))

ddply(diamonds, .(cut), subset, price == max(price))

# Select the two smallest diamonds per color
ddply(diamonds, .(color), subset, order(carat) <= 2)
ddply(diamonds, .(color), subset, order(carat) < 3)

# Select the 1% largest diamonds per color
ddply(diamonds, .(color), subset, carat > quantile(carat, 0.99))

ddply(diamonds, .(cut), subset, price > quantile(price, 0.999))

# Select all diamonds bigger than the group average per color
ddply(diamonds, .(color), subset, price > mean(price))


str(msleep)


qplot(color, carat, data = dsmall, geom = "boxplot", ylim = c(0,3), fill = color)

qplot(carat, price, data = dsmall, geom = "point", color = color) + stat_summary()
?


d <- ggplot(mtcars, aes(cyl, mpg)) + geom_point()
#d + geom_linerange()
library(Hmisc)
d + stat_summary(fun.data = "mean_cl_boot", colour = "red", size = 2)
d + stat_summary(fun.data = "mean_se", colour = "red", size = 2)
d + stat_summary(fun.data = "mean_se", colour = "red", size = 2, geom = "point")
?stat_summary


ggplot(mtcars, aes(cyl, mpg)) + geom_point()




df <- data.frame(
  trt = factor(c(1, 1, 2, 2)),
  resp = c(1, 5, 3, 4),
  group = factor(c(1, 2, 1, 2)),
  upper = c(1.1, 5.3, 3.3, 4.2),
  lower = c(0.8, 4.6, 2.4, 3.6)
)
df
ggplot(df, aes(trt, resp, colour = group))


ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth()





df <- data.frame(
  t = rep(seq(0.0,1.0,0.2), times = 2),
  N = c(c(0.3,0.5, 0.5, 0.7,1.0,1.0),c(0.2,0.6, 0.7, 0.8,1.0,1.0))
)
df
qplot(t, N, data = df, geom = c("point","smooth"))
