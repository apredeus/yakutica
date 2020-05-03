stringsAsFactors = F

library(ggplot2)
library(reshape)
library(forcats)

## make bubble plot of identities

setwd("~")
tt <- read.table("distances_17_spp.tsv",header = F)
tt$Type <- factor(ifelse(tt$V3 >= 98.7,"Species, 98.7-100%",ifelse(tt$V3 < 94.5, "Family, 86.5-94.5%", "Genus,94.5-98.7%")),
                  levels = c("Species, 98.7-100%","Genus,94.5-98.7%","Family, 86.5-94.5%"))

tt$V1 <- factor(tt$V1,levels = c("Gortzia_yakutica_YA111-52_clone_21","Gortzia_yakutica_YA111-52_clone_6","HE797907.1_Gortzia_infectiva_TS-j",
                                   "HE797910.1_Gortzia_infectiva_TS-a_clone_50","LT549002.1_Gortzia_shaharazadis","HE797905.1_Holospora_obtusa", 
                                   "Holospora_obtusa_F1_contig000005","Holospora_undulata_HU1_contig000111","HE797906.1_Holospora_undulata_strain_StB",
                                   "Holospora_elegans_E1_contig039","LT616950.1_Holospora_caryophila_94AB1-5","LT616951.1_Holospora_caryophila_FGC3",
                                   "Holospora_curviuscula_NRB217_scaffold683","KC164378.1_Holospora_curviuscula_MC-3","KC164379.1_Holospora_acuminata_AC61",
                                   "KX669635.1_Holospora_parva_HpHSG1-11","MH319377.1_Hafkinia_simulans"))
tt$V2 <- factor(tt$V2,levels = c("Gortzia_yakutica_YA111-52_clone_21","Gortzia_yakutica_YA111-52_clone_6","HE797907.1_Gortzia_infectiva_TS-j",
                                   "HE797910.1_Gortzia_infectiva_TS-a_clone_50","LT549002.1_Gortzia_shaharazadis","HE797905.1_Holospora_obtusa", 
                                   "Holospora_obtusa_F1_contig000005","Holospora_undulata_HU1_contig000111","HE797906.1_Holospora_undulata_strain_StB",
                                   "Holospora_elegans_E1_contig039","LT616950.1_Holospora_caryophila_94AB1-5","LT616951.1_Holospora_caryophila_FGC3",
                                   "Holospora_curviuscula_NRB217_scaffold683","KC164378.1_Holospora_curviuscula_MC-3","KC164379.1_Holospora_acuminata_AC61",
                                   "KX669635.1_Holospora_parva_HpHSG1-11","MH319377.1_Hafkinia_simulans"))
tt$V2 <- fct_rev(tt$V2)
tt$V3 <- round(tt$V3,digits = 1)

ggplot(tt,aes(x = V1,y = V2)) + geom_point(aes(size = V3,color = Type)) + scale_size(range=c(3,12)) +
  geom_text(aes(label = V3)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))