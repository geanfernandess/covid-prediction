install.packages("tidymodels")

#library(tidyverse)
library(tidymodels)

# Carregar o modelo
modelo <- readRDS("modelo_covid.rds")

# Receber a idade do paciente via argumento da linha de comando
#idade <- as.numeric(commandArgs(trailingOnly = TRUE))
idade <- 5

# Criar um data frame com os dados de entrada
dados_predicao <- data.frame(idade = idade)  # Use a idade recebida como entrada

# Fazer a previsão com o modelo
previsao <- predict(modelo, newdata = dados_predicao)

# Imprimir a previsão
cat("{\"prediction\":", previsao, "}")
