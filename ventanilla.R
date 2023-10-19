# Inicializando -----------------------------------------

rm(list = ls())# Para limpiar el workspace
graphics.off() # Para limpiar el area de graficos
cat("\014") # Limpiar la consola pero no elimina los paquetes ya cargados
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # Cambiar el directorio de trabajo al que tengo abierto
getwd()
options(scipen = 999) #Para anular la notacion cientifica

library(pacman)
p_load(ggplot2,plotly,magrittr,dplyr,skimr,tidyverse,gganimate,RColorBrewer)


# Lectura de datos -----------------------------------------
d = read.csv2("Ventanilla.csv")
View(d)
skimr::skim(d)
attach(d)

table(d$TIPOCASO)

# Manipulacion de datos ------------------------------------

d %>% filter(ZONA != "NULL" & ZONA != "", TIPOCASO == "DISPERSADOS") -> d2

View(d2)

table(TIPOCASO)

# Grafico -------------------------------------------------

ggplot(d2) + aes(SUBTIPOCASO, fill=SUBTIPOCASO) + geom_bar() +
  #  coord_flip() +
  theme(plot.title = element_text(color = "#003c30",
                                  hjust = 0.5, # Para centrarlo en  la horizontal 
                                  vjust = 2),
        axis.text.x  = element_blank(),
        panel.background  = element_rect(fill = "gray97"),
        legend.position = "bottom",
        legend.title = element_blank()) +
  facet_wrap(~ZONA)+
  scale_fill_manual(values=c("#543005","#8c540c",
                             "#dfc27d","#f6e8c3","wheat3","tan3",
                             "#80cdc1","#35978f",
                             "#01665e","#003c30",
                             "aquamarine4"))  +
  labs(title = "Grupos de personas dispersados en cada zona de Ventanilla", 
       x = "Grupos de personas dispersados",
       y = "Cantidad",
       caption="Fuente: Datos Abiertos")


ggplotly()

