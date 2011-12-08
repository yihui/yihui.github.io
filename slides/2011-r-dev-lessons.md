# r-dev-lessons

!SLIDE middle

# Lessons Learned in Developing R Packages

* * * * *

<img src="images/sleepy.png" width=350 />

## [Yihui Xie](http://yihui.name)

Department of Statistics, Iowa State University  
Computational Statistics working group 

Nov 2, 2011 (i.e. 20111102)

!NOTE

<span style="font-size: 50%">(image from <http://interns.experience.com/>)</span>

!SLIDE dark middle

# Outline

Nothing here; move on!

}}} images/scattered-leaves.jpg

!SLIDE middle

# Do we have to suffer from software?

!SLIDE dark middle

# How difficult is it to use the Linux servers in our department?

}}} images/terminal.png

!SLIDE middle

# Why not RStudio?

say goodbye to the command `nohup` since we can use the web interface

!SLIDE

}}} images/rstudio-web.png

!SLIDE dark middle

# On Design

}}} images/steve-jobs.jpg

!SLIDE dark middle

# Humanity?

}}} images/bicycle-route.jpg

!SLIDE

# What Should I Say...

}}} images/error-message.png

!SLIDE middle

# Q: How to Make Developers Happier?

## A: You do not have to buy me beer, but please just do not let me see you use an R version released 2 years ago

!SLIDE

# animation: Start with Naive Ideas

the best time to write a package was 5 years ago, and...

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

# animation: Demos and Examples

do not expect beginners to read source code, and do not expect experts to read documentation, either!

``` ruby
    library(animation)
    demo('fire')  # an application of image()
```

<p align="center"><img src="images/fire.gif" /></p>

!SLIDE bulleted

# animation: Demos and Examples (cont'd)

examples are fast guides to usage

``` ruby
    library(animation)
    ?animation
    ## this gives you an overview of the package
```

- images are supported in documentation in R 2.14 (use `\figure{}`)
- should be possible to create figures dynamically with Sweave in future
- honestly, I do not like the old style of R documentation at all

!SLIDE bulleted

# animation: Interfaces

- why `ani.start()` and `ani.stop()` became `saveHTML()`
- use modern CSS elements (round corners and shadow, etc) rather than the old clunky styles
- make it appealing enough that the user cannot wait clicking the button!

!SLIDE

}}} images/interface-old.png

!SLIDE

}}} images/interface-new.png

!SLIDE middle

# animation: Automatic Configurations

![automatic](images/automatic.gif)

!SLIDE bulleted

# animation: Automatic Configurations (cont'd)

- `saveGIF()` uses ImageMagick or GraphicsMagick to convert images to GIF animations; need to know where they are installed
- automatically search for ImageMagick in Windows Registry Hive using `readRegistry()` (very likely to succeed)
- instead of teaching what is the environmental variable `PATH` (very frustrating thanks to &ldquo;the system that is just _this_ tall&rdquo;)

!SLIDE bulleted

# animation: What Do I Regret Today?

- function names: now I'm more in favor of `foo_bar` than `foo.bar` (why? S3 generic functions) or `fooBar` (why? `_` is a clearer separator than capital letters)
- built a Wiki site too early and it is too big to maintain (<http://animation.yihui.name>); I should have used tools like Sweave to build it dynamically (my new package [**knitr**](http://yihui.github.com/knitr) was partly motivated from here)

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

!SLIDE bulleted

# formatR: Motivation

- it is not the fault of people to create &ldquo;long chunks of ill-formatted R code piled beside the Snedecor-Grad-Copier printer&rdquo;
- why cannot a workman blame his tools?
- Stat579 students motivated the `tidy.eval()` function

I frown on this in homeworks (score: 99.5):

``` ruby
> 1+1
[1] 2
```

`tidy.eval()` does this (score: 100):

``` ruby
1 + 1
## [1] 2
```

!SLIDE middle dark

# Rd2roxygen: Escaping the Rd Inferno

}}} images/inferno.jpg

!SLIDE bulleted

# Rd2roxygen: How I Regained Enthusiasm from roxygen

- I was once extremely frustrated at maintaining the animation package due to documentation
- idea of roxygen: source code and documentation are in the same file

``` ruby
##' This is title
##' @param a documentation for argument a
##' @param b documentation for argument b
f = function(a, b) {
    ...
}
```

- no longer needs to switch back and forth between `R/f.R` and `man/f.Rd`
- documentation is generated dynamically

!SLIDE bulleted

# Rd2roxygen: How to Escape the Inferno

- roxygen translates comments to Rd
- Rd2roxygen translates Rd back to roxygen comments, e.g.

from

``` tex
\arguments{
  \item{a}{documentation for argument a}
}
```

to

``` ruby
##' @param a documentation for argument a
```

- you maintain a *single* source from now on

!SLIDE dark

# GitHub: One Command to Fork em All

}}} images/grim-repo.jpg

!NOTE

from http://octodex.github.com/

!SLIDE

}}} images/poptocat.jpg

!SLIDE

}}} images/bear-cavalry.jpg

!SLIDE bulleted

# Why Version Control?

- keep track of what you have been doing (accumulatively)
- a proof of hard work to your advisor
- save tears when your system crashes
- much much easier [collaboration](https://github.com/hadley/evaluate/pull/9) with others
- ...
- why GitHub? community, easy collaboration, ... (compare to R-Forge)

!SLIDE bulleted

# Why do I use `=` instead of `<-`?

- it is simpler to type (although Emacs/ESS binds `<-` to `_`)
- almost all other languages use `=`
- it does *not* confuse me at all (main reason why some people are against recommend `=`)

!SLIDE bulleted

# Names: Important!

- can you remember the name `CvM2SL2Test` or `HumMeth27QCReport`
- if people cannot even remember your name, how are you supposed to be famous/popular?
- Hadley's principle: Google-able
- an unbeatable name: lubridate

!SLIDE bulleted

# Have Fun

- the [fun](http://cran.r-project.org/package=fun) package: games and fun
- animation: started from fun
- cranvas: [interactive graphics](http://vimeo.com/30173477) is fun
- knitr (an alternative to Sweave): dynamic report is fun
- ...

!SLIDE middle

<object width="600" height="619"><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=30173477&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=00adef&amp;fullscreen=1&amp;autoplay=0&amp;loop=0" /><embed src="http://vimeo.com/moogaloop.swf?clip_id=30173477&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=00adef&amp;fullscreen=1&amp;autoplay=0&amp;loop=0" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="600" height="619"></embed></object>

!SLIDE dark middle

# Aim at Problems, Instead of Killing the Dragon

朱泙漫学屠龙于支离益，单千金之家，三年技成而无所用其巧。 

《庄子·列御寇》

}}} images/dragon.jpg

!SLIDE

# Thanks!

- <https://github.com/yihui>

}}} images/constructocat.jpg
