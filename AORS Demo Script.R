library(tidyverse)

hours=read_csv("aircraft_hours_maintenance_competitors_v2.csv")

#Declare lists of CAB and UICs.
cablist=hours %>% filter(!is.na(CAB) & CAB!="#N/A") %>% distinct(CAB)
uiclist=hours %>% filter(!is.na(CAB) & CAB!="#N/A" & !is.na(UIC)) %>% distinct(UIC) 

###PDF Documents

# for (i in 1:length(uiclist)) {
for (i in 1:10) {
  # i=1
  rmarkdown::render("AORS Demo Report.Rmd",params=list(uic=uiclist$UIC[i]))
  file.rename(from="AORS_Demo_Report.pdf", to =paste(uiclist$UIC[i],"Graph.pdf"))
  file.copy(from=paste0(getwd(),"/",uiclist$UIC[i]," Graph.pdf"), 
            to = paste0(getwd(),"/UIC Reports/",uiclist$UIC[i]," Graph.pdf"))
  file.remove(paste0(getwd(),"/",uiclist$UIC[i]," Graph.pdf"))
}

###HTML Documents

for (i in 1:10) {
  rmarkdown::render("AORS Demo Report2.Rmd",params=list(uic=uiclist$UIC[i]))
  file.rename(from="AORS_Demo_Report2.html", to =paste(uiclist$UIC[i],"Graph.html"))
  file.copy(from=paste0(getwd(),"/",uiclist$UIC[i]," Graph.html"), 
            to = paste0(getwd(),"/UIC Reports/",uiclist$UIC[i]," Graph.html"))
  file.remove(paste0(getwd(),"/",uiclist$UIC[i]," Graph.html"))
}


