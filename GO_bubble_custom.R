#!/usr/bin/env Rscript
############################
# Usage : ./GO_BP_bubble.R <BP.txt> 
############################
# arguments in command line
options<-commandArgs(trailingOnly = T)
library(Hmisc)
library(stringr)
plot_heigh<-2.2
plot_width<-6

my_data<-read.table(file=options[1],sep="\t")
if(length(my_data[,1]) >= 10) {my_data<-my_data[1:10,]} else {
my_data<-my_data}
my_data$V1->Term
my_data$V3->PValue
my_data$V5->Fold.Enrichment
my_data$V11->Count

png_name<-unlist(strsplit(options[1],'.',fixed=T))[1]
png(file=paste(png_name,'png',sep='.'),height = plot_heigh, width = plot_width, res=600, units = "in", family="Arial")

ggplot(my_data, aes(x=-1*log10(PValue), y=Term)) + 
	geom_point(aes(size=Count, color=Fold.Enrichment))+
	scale_colour_gradient(low="steelblue", high="red")+
	labs(
		color=expression(Fold.Enrichment), 
		size="Gene number",
		x="-logP-value",
		# y="Pathway name",
		#title="Cellular Component"
		#title="MSigDBPathway"
		#title="PANTHER Pathway"
		title="Biological Process")+
	theme_bw()+
	theme(
		axis.text.y = element_text(size=rel(1.1)),
		axis.text.x = element_text(size=rel(1.0)),
		axis.title.x = element_text(size=rel(0.9)),
		axis.title.y = element_blank(),
		legend.key.size = unit(0.1,"inches"),
		legend.text = element_text(size=7),
		legend.title = element_text(size=8),
		legend.background = element_rect(fill="transparent"),
		plot.title = element_text(hjust = 0.5,size=12)
	)
	
dev.off()