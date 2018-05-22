n <- 3
while(n > 1){
  n <- readline("enter int:")
  n <- ifelse(grepl("\\D", n), -1, as.integer(n))
  if(is.na(n)) {break}
}




