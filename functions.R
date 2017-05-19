# functions.R

tableFormatFun <- function(x,Columns){
  DT::datatable(
    x
    ,colnames = Columns
    ,selection = list(mode = "single", target = "row")
    ,options = list(pageLength = 10,searching = FALSE,scrollX = TRUE,dom = 'tip'))
}

#string functions
insert_str <- function(target, insert, index) {
  insert <- insert[order(index)]
  index <- sort(index)
  paste(interleave(split_str_by_index(target, index), insert), collapse="")
}
interleave <- function(v1,v2)
{
  ord1 <- 2*(1:length(v1))-1
  ord2 <- 2*(1:length(v2))
  c(v1,v2)[order(c(ord1,ord2))]
}
split_str_by_index <- function(target, index) {
  index <- sort(index)
  substr(rep(target, length(index) + 1),
         start = c(1, index),
         stop = c(index -1, nchar(target)))
}