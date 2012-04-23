## @knitr desc-page
library(XML)
res = readHTMLTable('http://www.ucm.es/info/cliwoc/content/CLIWOC15all.htm', 
                    stringsAsFactors = FALSE)
head(res[[1]][, -5])

## @knitr variable-widths
res[[1]] = res[[1]][-1, ] # remove header
# start and stop positions are in the 1st table
s1 = as.integer(res[[1]][, 2])
s2 = as.integer(res[[1]][, 3])
# field widths
s2-s1+1

## @knitr variable-names
# all variable names
nms = tolower(c(res[[1]][, 1], res[[2]][-1,1]))
head(nms, 30)

## @knitr read-data
df = read.table('CLIWOC15pipe', sep = '|', fill=TRUE)

## @knitr read-csv
system.time(df <- read.csv('CLIWOC15.csv.bz2'))
print(object.size(df), unit='Mb')

## @knitr subset-data
summary(df$Lat3)
table(df$Lat3 < -90) # records lower than -90
df = subset(df, Lat3 >= -90 & Year > 1700)

## @knitr map-all
library(maps)
par(mar=rep(0,4))
map(col='darkgray', xlim=c(-170,170), ylim=c(-75,80))
with(df, points(Lon3, Lat3, pch = '.', col=rgb(.18,.55,.34,.1)))

## @knitr ggplot2-all
library(ggplot2)
wd = map_data('world')
b = ggplot(wd, aes(long, lat)) + geom_path(aes(group=group),color=I('#333333'), size=I(.3))
# too slow...
b + geom_point(data = df, aes(Lon3, Lat3), alpha=0.01,size=1)

## @knitr year-changes
df$Date = with(df, as.Date(sprintf('%s-%s-%s', Year, Month, Day)))
# d0 = min(df$Date, na.rm = TRUE)
d0 = as.Date('1749-01-01')
d1 = max(df$Date, na.rm = TRUE)
# d1 = d0 + 1000
library(scales)
df$Nationality = factor(gsub('^ *| *$', '', df$Nationality))
nat = levels(df$Nationality)
cols = brewer_pal('qual')(length(nat))
colvec = alpha(dscale(df$Nationality, brewer_pal('qual')), .7)
# x11(width = 10, height = 6); dev.control('inhibit')
n = 14 # traces of 2 weeks
par(mar=rep(0,4))
with(df, while(d0 + n <= d1) {
    dev.hold()
    map(col='darkgray',xlim=c(-170,170),ylim=c(-75,80))
    idx = Date >= d0 & Date < d0 + n
    points(Lon3[idx], Lat3[idx], pch = 20, col=colvec[idx])
    text(120,-56,d0+n,cex=2, col='darkgray')
    legend('bottomleft', nat, fill = cols, bty = 'n', ncol=2, cex=.8, text.col='darkgray')
    dev.flush()
    d0 = d0 + 1
})
