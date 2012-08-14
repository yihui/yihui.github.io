## Focus session: read code!

###----------------HISTORY-------------###
## R does support interactivity!!
library(fun)
set.seed(123)
x11(type = "Xlib"); mine_sweeper()

## (1) the old good synthetic pollen data
library(cranvas)
library(animation)
data(pollen, package = "animation")
qpollen = qdata(pollen, size = 2)
qscatter(RIDGE, NUB, data = qpollen)
## ggplot2 style; mouse wheel interaction

## (2) speed: 3 million points
n=3e6; r=40
df = data.frame(x=rnorm(n,300,60), y=rnorm(n,300,40))

library(SearchTrees)
tree = createTree(df)
idx = NULL; pos = NULL
library(qtpaint); library(qtbase)

# ready? draw!
s = qscene()
root = qlayer(s)
mouse_move = function(layer, event) {
  pos <<- as.numeric(event$pos())
  # message('Looking for points in rect...')
  idx <<- rectLookup(tree, pos, pos + r)
  qupdate(layer.brush)
}
lims = qrect(apply(df, 2, range))
layer.main = qlayer(paintFun = function(layer, painter) {
  qdrawGlyph(painter, qglyphCircle(1), df$x, df$y, fill = "black", stroke = "black")
}, clip = TRUE, cache = TRUE, mouseMoveFun = mouse_move, mousePressFun = mouse_move, 
                    limits = lims)
layer.brush = qlayer(paintFun = function(layer, painter) {
  qdrawRect(painter, pos[1] + r, pos[2] + r, pos[1], pos[2], stroke = "red", fill = NA)
  if (!length(idx)) return()
  qdrawGlyph(painter, qglyphCircle(5), df$x[idx], df$y[idx], fill = "yellow", stroke = "yellow")
}, limits = lims)
root[0, 0] = layer.main
root[0, 0] = layer.brush
v = qplotView(s)
v$resize(500, 500)
v 


## (3) cartograms
vote.res = c("red", "red", "red", "blue", "blue", "blue", "blue",
  "blue", "blue", "red", "red", "blue", "blue", "blue", "red", "red",
  "red", "blue", "blue", "blue", "blue", "blue", "blue", "blue",
  "blue", "red", "red", "red", "red", "blue", "blue", "blue", "blue",
  "blue", "blue", "blue", "blue", "blue", "blue", "blue", "red",
  "blue", "red", "blue", "blue", "blue", "red", "red", "red", "red",
  "red", "blue", "blue", "blue", "blue", "blue", "blue", "blue",
  "blue", "blue", "red", "blue", "red")
qstate = map_qdata('state', color = vote.res)
qmap(qstate, main = 'A normal map')

## cartogram based on population
vote.num = c(9, 10, 6, 55, 9, 7, 3, 3, 27, 15, 4, 21, 11, 7, 6, 8, 9,
  2, 10, 12, 12, 12, 17, 17, 10, 6, 11, 3, 2, 5, 4, 15, 5, 31, 31, 31,
  31, 15, 15, 15, 3, 20, 7, 7, 21, 4, 8, 3, 11, 34, 5, 3, 13, 13, 13,
  11, 11, 11, 11, 11, 5, 10, 3)
qstate2 = map_qdata('state', color = vote.res, size = vote.num, cartogram = TRUE, nrow = 50, ncol = 50)
qmap(qstate2, main = 'Cartogram')

link_cat(qstate, 'labels', qstate2, 'labels')



## 2012 election
vote.num = c(9, 11, 6, 55, 9, 7, 3, 3, 29, 16, 4, 20, 11,
             6, 6, 8, 8, 4, 10, 11, 11, 11, 16, 16, 10, 6, 
             10, 3, 5, 6, 4, 14, 5, 29, 29, 29, 29, 15, 15,
             15, 3, 18, 7, 7, 20, 4, 9, 3, 11, 38, 6, 3,
             13, 13, 13, 12, 12, 12, 12, 12, 5, 10, 3)
votes = read.csv('election-2012-all.csv')
votes$State = tolower(votes$State)
votes$State[votes$State == 'dc'] = 'district of columbia'

votes$Margin = votes$Obama - votes$Romney

x = tapply(votes$Margin, votes$State, mean)[qstate$labels]
votes.col = gradient_n_pal(c('red', 'white', 'blue'))((x+21)/(42))
range(x)

qstate = map_qdata('state', color = votes.col)
qmap(qstate, main = 'A normal map')

library(scales)
qstate2 = map_qdata('state', color = votes.col, size = vote.num, cartogram = TRUE, nrow = 50, ncol = 50)
qmap(qstate2, main = 'Cartogram')

qvotes = qdata(votes, color = Winner)
qscatter(Obama, Romney, data = qvotes)
qhist(Margin, data = qvotes)

link_cat(qvotes, 'State', qstate2, 'labels')

## (4) NRC rankings: other types of plots
## questions to be addressed: (1) consistency of ranking methods (2) who is that point/line?
data(nrcstat)
qnrc <- qdata(nrcstat)
library(RColorBrewer)
cranvaspalette<-brewer.pal(8,"Paired")
qnrc = qdata(nrcstat, color=cranvaspalette[7])
brush(qnrc, 'style')$color = cranvaspalette[8]
brush(qnrc, 'color') = cranvaspalette[8]
qnrc$.color <- cranvaspalette[4]
qnrc$.border <- cranvaspalette[4]

qscatter(RRankings5th, SRankings5th, data = qnrc)
qparallel(c(20,21,22,26,34,36), data = qnrc, main = "Faculty and Students",
          horizontal = TRUE, boxplot = TRUE)
record_selector(Institution, data = qnrc)
## two depts really love their phd students


###-------------------SHOWCASES-------------------------###
## histogram: change binwidth
data(flea, package = 'tourr')
qflea = qdata(flea, color = species)
qhist(tars1, data = qflea)


## density plot
data(tennis)
qtennis <- qdata(tennis)
qdensity(first.serve.pct, data = qtennis)


## boxplots
## continuous vs categorical variable
qflea <- qdata(flea)
qboxplot(tars1 ~ species, data = qflea)
qparallel(~ ., data = qflea)


## different types of linking: categorical
qflea = qdata(flea, color = species)
qscatter(tars1, tars2, data = qflea)
qparallel(~., data = qflea)

link_cat(qflea, 'species')  # allows to see whole category

remove_link(qflea)
