source("Librerias.R")
colnames(IGV)<- c("Fecha","Amazonas","Ancash","Apurimac","Arequipa","Ayacucho",
                 "Cajamarca","Cusco","Huancavelica","Huanuco","Ica","Junin",
                 "La Libertad","Lambayeque","Lima","Loreto","Madre de Dios",
                 "Moquegua","Pasco","Piura","Puno","San Martin","Tacna",
                 "Tumbes","Ucayali")
IGV<-IGV %>% gather(Departamento, IGV, Amazonas:Ucayali)
colnames(TribInt)<- c("Fecha","Amazonas","Ancash","Apurimac","Arequipa","Ayacucho",
                      "Cajamarca","Cusco","Huancavelica","Huanuco","Ica","Junin",
                      "La Libertad","Lambayeque","Lima","Loreto","Madre de Dios",
                      "Moquegua","Pasco","Piura","Puno","San Martin","Tacna",
                      "Tumbes","Ucayali")
TribInt<-TribInt %>% gather(Departamento, TributoInterno, Amazonas:Ucayali)
 ## para el final 
colnames(IR)<- c("Fecha","Amazonas","Ancash","Apurimac","Arequipa","Ayacucho",
                 "Cajamarca","Cusco","Huancavelica","Huanuco","Ica","Junin",
                 "La Libertad","Lambayeque","Lima","Loreto","Madre de Dios",
                 "Moquegua","Pasco","Piura","Puno","San Martin","Tacna",
                 "Tumbes","Ucayali")
IR<-IR %>% gather(Departamento, ImpuestoRenta, Amazonas:Ucayali)
colnames(ADUANAS)<- c("Fecha","Amazonas","Ancash","Apurimac","Arequipa","Ayacucho",
                      "Cajamarca","Cusco","Huancavelica","Huanuco","Ica","Junin",
                      "La Libertad","Lambayeque","Lima","Loreto","Madre de Dios",
                      "Moquegua","Pasco","Piura","Puno","San Martin","Tacna",
                      "Tumbes","Ucayali")
ADUANAS<-ADUANAS %>% gather(Departamento, TributoAduanero, Amazonas:Ucayali)
## para el final 
dataset<-merge (IGV, TribInt, by = c("Fecha","Departamento"))
dataset1<-merge (IR, ADUANAS, by = c("Fecha","Departamento"))
data<-merge (dataset, dataset1, by = c("Fecha","Departamento"))
rm(dataset)
rm(dataset1)
# Consultas 
## 1.-Consultar si existen data Nulos, Vacios, o cualquier otro valor q represente este contenido
data%>%select(IGV) %>% filter(IGV == 'n.d.')
data%>%select(TributoInterno) %>% filter(TributoInterno =='n.d.')
data%>%select(TributoAduanero) %>% filter(TributoAduanero =='n.d.')
data%>%select(ImpuestoRenta) %>% filter(ImpuestoRenta =='n.d.')
### Existen valores de tipo 'N.D' hay q imputarlos
## 1.2.- Cambiar los valores encontrados en la consulta anterior por '0'
data$TributoInterno<-gsub("n.*","0", data$TributoInterno)
data$TributoAduanero<-gsub("n.*","0", data$TributoAduanero)
data$TributoAduanero<-gsub("n.*","0", data$TributoAduanero)
data$IGV<-gsub("n.*","0", data$IGV)
data$TributoAduanero[is.na(data$TributoAduanero)] <- "0"
data$TributoInterno[is.na(data$TributoInterno)] <- "0"
data$ImpuestoRenta[is.na(data$ImpuestoRenta)] <- "0"
data$IGV[is.na(data$IGV)] <- "0"
View(data%>%group_by(IGV)%>% filter(is.na(IGV)))
View(data%>%group_by(IGV)%>% filter(is.na(ImpuestoRenta)))
data$ImpuestoRenta[is.na(data$ImpuestoRenta)] <- "0"
## 2.-Departamento con mayor taza de IGV cobrados por Sunat
IGVDEP <- data %>% group_by(Departamento,IGV) %>%  arrange(desc(IGV))%>%head(10)
## 3.- En que departamento se genero el mayor tributo aduanero en el mes de 'ENERO'
##3.1.- Se deben crear la variable 'NombreMes' a partir de la 'Fecha' 
meses <- c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Setiembre", "Octubre", "Noviembre", "Diciembre")
data <- data %>% mutate(NombreMes= factor(meses[month(Fecha)],levels = meses ) )
data %>% select(Departamento,TributoAduanero,NombreMes) %>% filter(NombreMes == 'Enero') %>% arrange(desc(TributoAduanero))%>%head(1)
##Crear trimestres por a?o 
dataset<-data %>%  mutate(
  Trimestre = case_when(
    NombreMes ==  "Enero"  ~ "T1",
    NombreMes ==  "Febrero"  ~ "T1",
    NombreMes ==  "Marzo"  ~ "T1",
    NombreMes ==  "Abril"  ~ "T2",
    NombreMes ==  "Mayo"  ~ "T2",
    NombreMes ==  "Junio"  ~ "T2",
    NombreMes ==  "Julio"  ~ "T3",
    NombreMes ==  "Agosto"  ~ "T3",
    NombreMes ==  "Setiembre"  ~ "T3",
    NombreMes ==  "Octubre"  ~ "T4",
    NombreMes ==  "Noviembre"  ~ "T4",
    NombreMes ==  "Diciembre"  ~ "T4"
  )
)
dataset<-separate(dataset, Fecha, c("Fecha","Año"),5)
dataset<-separate(dataset, Fecha, c("Dia","Mes"),1)
dataset$Mes<-gsub("/","",dataset$Mes)
## 1 .- Consultar Impuesto a la renta del 1 Trimestre 
View(dataset %>% select(Departamento,ImpuestoRenta,NombreMes,Trimestre)%>%filter(Trimestre =="T1"))
## 5 Calcular el total de ingresos por IGV, Aduanas , Impuesto a la renta
str(data)
data[,3:6]<-lapply(data[,3:6],as.numeric) ## cambiamos la estructura de los datos de "CHAR" a "INT"
sum(data$IGV)             #Solo para comprobar la sentencia de abajo    
sum(data$TributoInterno)  #Solo para comprobar la sentencia de abajo   
sum(data$TributoAduanero) #Solo para comprobar la sentencia de abajo    
sum(data$ImpuestoRenta)   #Solo para comprobar la sentencia de abajo    
Total<-data%>% mutate(IGV = sum(data$IGV), TributoInterno=sum(data$TributoInterno),TributoAduanero = sum(data$TributoAduanero), ImpuestoRenta = sum(data$ImpuestoRenta))%>%distinct(IGV,TributoAduanero,TributoInterno,ImpuestoRenta)
