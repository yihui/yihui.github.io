# r-intro-econ

!SLIDE middle

# An Introduction to R

* * * * *

![R](http://www.r-project.org/Rlogo.jpg)

## [Yihui Xie](http://yihui.name)

Department of Statistics, Iowa State University  
Econ workshops on R

Nov 8, 2011


!SLIDE bulleted

# Outline

- What is R
- Computing
  - grammar
  - data manipulation
  - simulation
  - modelling
- Graphics
  - base graphics
  - ggplot2
- Other useful stuff
  - debugging
  - 3D plots, animations, interactive graphics

!SLIDE dark middle

# Ready?

}}} images/dragon.jpg

!SLIDE middle

# PART I: Basics and computation

Nov 8, 2011

!SLIDE middle

# R is the language for statistical computing and graphics (and more)

!SLIDE bulleted

# Examples of using R for statistics

- I write homework solutions with R: <https://github.com/yihui/stat579/downloads>
- [I write my own homework with R](http://gitorious.org/xie/homework/blobs/raw/f674bfe3bc498e81b9b54fa24b5ec2fba48e3291/Stat503/Assign3/Stat503-Assignment3-Yihui-Xie.pdf)
- I play with distributions in R: <http://yihui.name/en/2010/04/demonstrating-the-power-of-f-test-with-gwidgets/>
- I grab datasets from webpages using R: <http://yihui.name/en/2010/10/grabbing-tables-in-webpages-using-the-xml-package/>

!SLIDE bulleted

# More examples

- I set fireworks with R: <http://yihui.name/en/2011/01/happy-new-year-with-r-2011-fireworks/>
- I play mine sweeper with R: <http://yihui.name/en/2011/08/the-fun-package-use-r-for-fun/>
- ...

!SLIDE bulleted

# Comparison with other languages

- oriented to statistics (`mean()`, `var()`, `lm()`, `glm()`, `rnorm()`, `boxplot()`, ...)
- heavily vectorized (very important! can avoid loops in many, many cases)
- object-oriented, but in different forms (no `obj.method()`, but often `method(obj)`)
- unbeatable number of packages (~3400 now)
- free (in both senses of beer and freedom)

!SLIDE bulleted

# Setting up

- Download: <http://cran.r-project.org> (you may choose the Iowa State mirror)
  - three major platforms (Win, Linux, Mac)
- Editor? RStudio may be a good choice (alternatives: Notepad++/NppToR, Emacs/ESS, Eclipse/StatET, ...)
  - anything but Notepad under Windows

!SLIDE

}}} images/rstudio-web.png

!SLIDE middle

# Getting help

## use the question mark `?` to read documentation

e.g. try `?lm` for help on linear models

## or `help.start()` for a view on the whole package

!SLIDE

# Install add-on packages

``` ruby
## use install.packages(), e.g.
install.packages('animation')
```

You will be asked to choose a mirror.

Too many packages?? Use the task view: <http://cran.r-project.org/web/views/> (e.g. Econometrics)

!SLIDE middle

# R is still being actively updated

## no easy way to update R with a menu or command; have to uninstall old version and install new version manually

## easy to update packages: `update.packages()`

!SLIDE bulleted

# Grammar: simple calculations

- assignment by `<-` or `=` (experts recommend the former but I do not believe them)
- `?Arithmetic` (e.g. `x+y`, `x %% y`)
- indexing by `[]`

``` ruby
x <- 10
y <- 15:3

1 + 2
11 %% 2
11 %/% 2
3^4
log(10)

y[4]
y[-1]  # what do negative indices mean?
```

!SLIDE bulleted

# Grammar: functions

- `function_name(arguments)`

``` ruby
z = rnorm(100)
fivenum  # what are the arguments of this function?

fivenum(z)

fivenum(x = z, na.rm = TRUE)

fivenum(z, TRUE)
```

!SLIDE

# Grammar: conditions and loops

``` ruby
## the if-else statement
if (TRUE) {
  print(1)
} else {
  print(2)
}

## a for-loop (the other type is while-loop)
s = 0; x = c(4, 2, 6)
for (i in 1:3) {
  s = s + x[i]
}
s
## the above loop is the most stupid thing to do in R
```

!SLIDE bulleted

# Work with data

- a series of functions like `read.table()`, `read.csv()`, ...
- can work with databases too (need add-on packages like RODBC, RMySQL, ...)

``` ruby
## the tips data
tips = read.csv('http://dicook.public.iastate.edu/Army/tips.csv')

str(tips)  # structure of an object; one of the most useful function in R

summary(tips)
mean(tips$bill)  # index by $name
var(tips[, 'tip'])  # index by character name
table(tips[, 4])  # index by column number

hist(tips$bill)
boxplot(tip~sex, data=tips)
plot(tip~bill, data=tips, col=as.integer(tips$sex))
```

!SLIDE bulleted

# Other types of data objects

- vector
- matrix, array
- list (very flexible; perhaps second most widely used)
- ...

!SLIDE

# Simulation

## you know the process, but the input is random

A family of functions for distributions: `dfun()`, `pfun()`, `qfun()` and `rfun()`

For example, `rnorm()`

!SLIDE

# A simulation of fire flames

``` ruby
    library(animation)
    demo('fire', ask = FALSE)  # an application of image()
```

<p align="center"><img src="images/fire.gif" /></p>

!SLIDE

# Another example with more scientific flavor

Q: How many times do we need to flip the coin until we get a sequence of HTH and HTT respectively? (For example, for the sequence H*HTH*, the number for HTH to appear is 4, and in THT*HTT*, the number for HTT is 6.)

A: <http://yihui.name/en/2009/08/counterintuitive-results-in-flipping-coins/>

!SLIDE

# Modelling: linear regression

Take the tips data for example

``` ruby
fit1 = lm(tip ~ bill, data = tips)
summary(fit1)
```

You get

``` ruby
Call:
lm(formula = tip ~ bill, data = tips)

Residuals:
    Min      1Q  Median      3Q     Max 
-3.1982 -0.5652 -0.0974  0.4863  3.7434 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 0.920270   0.159735   5.761 2.53e-08 ***
bill        0.105025   0.007365  14.260  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 

Residual standard error: 1.022 on 242 degrees of freedom
Multiple R-squared: 0.4566,	Adjusted R-squared: 0.4544 
F-statistic: 203.4 on 1 and 242 DF,  p-value: < 2.2e-16 
```

!SLIDE

# Modelling: the formula

The formula is an important component of many R functions for modelling.

``` ruby
fit2 = lm(tip ~ bill + sex, data = tips)  # two variables

fit3 = lm(tip ~ bill + 0, data = tips)  # without intercept

## you try summary() on them
```

!SLIDE middle

# PART II: Graphics and more

Nov 15, 2011

!SLIDE

Before we get started, let's see if you can install the `gWidgetsRGtk2` package:

``` ruby
install.packages('gWidgetsRGtk2')
library(gWidgetsRGtk2)
## follow instructions in case of errors
```

!SLIDE bulleted

# Two graphics systems in R

- base graphics
  - the `graphics` package
  - once drawn, no way to modify it again (have to redraw everything)
  - functions to draw points, lines, polygons, ... like other languages
  - many built-in types of plots (histogram, boxplot, bar chart, ...)
- grid graphics
  - the `grid` package
  - more object-oriented: graphical elements are objects
  - can be modified without explicitly redraw the whole plot
  - more like an infrastructure package (no built-in plot types)

!SLIDE bulleted

# Add-on packages for graphics

There are many add-on packages based on the two systems; see the Graphics task view on CRAN for an overview: <http://cran.r-project.org/web/views/Graphics.html>

- `lattice`: Trellis plots
  - sub-plots conditional on categorical variables
  - shipped with R (no need to install; just `library(lattice)`)
- `ggplot2`: Grammar of Graphics
  - a truly masterpiece
  - amazing abstraction
  - <http://had.co.nz/ggplot2>
  - have to install: `install.packages('ggplot2')`

!SLIDE

# Examples of base graphics

Last week we mentioned the tips data.

``` ruby
tips = read.csv('http://dicook.public.iastate.edu/Army/tips.csv')
str(tips)

## scatter plot: positive correlation with a 'constraint'
plot(tip ~ bill, data = tips)
## what is the problem with R's default choice of point shapes?

## plot() is a very 'tricky' function in R; details later

hist(tips$tip, main = 'histogram of tips')
## you see nothing except a right-skewed distribution

hist(tips$tip, breaks = 30)  # more bins

hist(tips$tip, breaks = 100) # what do you see now?
```

20-30 years ago, the research on choosing the histogram binwidth was extremely hot in statistics, but... who cares?

!SLIDE

# A trivial example of interactive graphics

We can change the binwidth interactively in R via many tools; one possibility is to build a GUI

``` ruby
## I prefer gWidgetsRGtk2, but I do not know if you can install it
## gWidgetstcltk is easier to install
if (!require('gWidgetstcltk')) install.packages('gWidgetstcltk')
library(gWidgetstcltk)  # or library(gWidgetsRGtk2)
options(guiToolkit = 'tcltk')  # or options(guiToolkit = 'RGtk2')

x = tips$tip
gslider(from = 1, to = 100, by = 1,
        container = gwindow('Change the number of bins'),
        handler = function(h, ...) {
            hist(x, breaks = seq(min(x), max(x),
                    length = svalue(h$obj)))
        })

## many many other GUI elements to use
```

!SLIDE

# Play with colors

There are many color models in R, like `rgb()`, `hsv()`, ... And there are built-in color names, e.g. `'red'`, `'purple'`. Here is an example of `rgb()`

``` ruby
rgb(1, 0, 0)  # red (hexidecimal representation)
rgb(1, 1, 0)  # yellow

## an interactive example
g = ggroup(horizontal = FALSE, container = gwindow('Color Mixer'))
x = c(0,0,0)  # red, green, blue
for(i in 1:3) {
    gslider(from = 0, to = 1, by = 0.05, action = i,
            handler = function(h, ...) {
                x[h$action] <<- svalue(h$obj)
                par(bg = rgb(x[1], x[2], x[3]), mar = rep(0, 4))
                plot.new()
            }, container = g)
}

colors()  # all names you can use
plot(rnorm(30), pch = 19, col = sample(colors(), 30), cex = 2)
```

!SLIDE bulleted

# Other plots in base graphics system

Old-fashioned but many goodies...

- open `help.start()` and take a look at the `graphics` package
- all you need to learn about base graphics is there
- many types of plots of interest: `contour()`, `filled.contour()`, `fourfoldplot()`, `mosaicplot()`, `pairs()`, `smoothScatter()`, `stripchart()`, `sunflowerplot()`, `symbols()`

!SLIDE bulleted

# Some comments

Graphics are not as easy as you might have imagined

- avoid pie charts (why?)
- avoid 3D plots (what?!)
  - unless they are interactive (e.g. the `rgl` package)
  - an alternative is the contour plot
- consider color-blind people
- The Elements of Graphing Data (William S Cleveland)
  - order of precision (length good; angle bad; ...)

!SLIDE middle

# trend of vertical difference between two curves

}}} images/vertical-difference.png

!SLIDE

# Luke, use the source!

Only the source code is real.

``` ruby
x = seq(.1, 10, .1)
plot(x, 1/x, type = 'l', lwd = 2)
lines(x, 1/x + 2, col = 'red', lwd = 2)
```

<http://youtu.be/2LTsvOHq3xc>

!SLIDE middle dark

# Life is short, use ggplot2!

}}} images/inferno.jpg

!SLIDE bulleted

# Why ggplot2?

- you have to wrestle with gory details in base graphics
  - yes, it is flexible
  - but you have to take care of everything
  - point symbols, colors, line types, line width, legend, ...
- common tasks in graphics
  - color the points according to the `sex` variable
  - different point symbols denote the `smoker` variable
  - darker points denote larger parties (the `size` variable)
  - add a smoothing/regression line on a scatter plot
  - ...

!SLIDE

# Simple ggplot2 examples

We still use the `tips` data here.

``` ruby
library(ggplot2)
## different colors denote the sex variable
qplot(bill, tip, data = tips, color = sex)

## point symbols
qplot(bill, tip, data = tips, shape = smoker)

## you can manipulate ggplot2 objects
p = qplot(bill, tip, data = tips, color = size)
p

## do not like the color scheme? change it
p + scale_colour_gradient2(low="white", high="blue")

## faceting
qplot(tip, data = tips, facets = time ~ day)

p + geom_smooth() # smoothing line
```

!SLIDE bulleted

# More examples in ggplot2 website

Unlike most of R packages, ggplot2 has its own website of documentation, which is a rich source of examples.

- boxplots: <http://had.co.nz/ggplot2/geom_boxplot.html>
- contours: <http://had.co.nz/ggplot2/stat_contour.html>
- hexagons: <http://had.co.nz/ggplot2/stat_binhex.html>
- Pac man chart: <http://had.co.nz/ggplot2/coord_polar.html>

!SLIDE bulleted

# Other packages on graphics

As mentioned before, there are many other packages based on the two graphics systems.

- `animation`: a gallery of statistical animations and tools to export animations
- `rgl`: interactive 3D plots
- `iplots`: interactive statistical graphics
- `rggobi`: connect R with GGobi (a standalone software package for interactive stat graphics)

``` ruby
## be prepared
install.packages(c('animation', 'rgl', 'iplots'))
```

!SLIDE

# The animation package

The idea is simple:

``` ruby
    ## rotate the word 'Animation'
    for (i in 1:360) {
      plot(1, ann = FALSE, type = "n", axes = FALSE)
      text(1, 1, "Animation", 
        srt = i, col = rainbow(360)[i], cex = 7 * i/360)
      Sys.sleep(0.01)
    } 
```

<p align="center"><img src="images/animation-rotation.gif" width=300 /></p>

!SLIDE

# animation examples

``` ruby
library(animation)

?brownian.motion

?quincunx

?grad.desc

## export to an HTML page
?saveHTML

## want more hilarious examples? try
demo('busybees')

demo('CLEvsLAL')
```

!SLIDE

# rgl and iplots

Play with statistical graphics.

``` ruby
## use your mouse (drag or wheel up/down)
library(rgl)
demo('rgl')

## an artificial dataset
library(animation)
demo('pollen')

## linked plots
library(iplots)
ibar(tips$sex)
ihist(tips$tip)
```

!SLIDE middle

<object width="600" height="619"><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=30173477&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=00adef&amp;fullscreen=1&amp;autoplay=0&amp;loop=0" /><embed src="http://vimeo.com/moogaloop.swf?clip_id=30173477&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=00adef&amp;fullscreen=1&amp;autoplay=0&amp;loop=0" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="600" height="619"></embed></object>
<http://vimeo.com/30173477>

!SLIDE bulleted

# formatR: Computing on the Code

- R can compute on its own code: `parse()` and `deparse()`
- the [**formatR**](http://github.com/yihui/formatR/wiki) package uses the side effect of them to reformat R code
- you give me `1+1` and I return you `1 + 1` (what the heck is the difference?)

well, compare

``` ruby
for(k in 1:10){j=cos(sin(k)*k^2)+3;print(j-5)}
```

to

``` ruby
for (k in 1:10) {
    j = cos(sin(k) * k^2) + 3
    print(j - 5)
} 
```

!SLIDE

# Debugging

The function `debug` can be used to debug a function.

``` ruby
f = function(x) {
    m = length(x)
    x[is.na(x)] = mean(x, na.rm = TRUE)  # impute by mean
    s = sum(x^2)  # sum of squares
    s
}
f(c(1, NA, 2))

## begin to debug the function now
debug(f)

f(c(1, NA, 2))

undebug(f)
```

!SLIDE

# Thanks!

- <https://github.com/yihui>

}}} images/constructocat.jpg