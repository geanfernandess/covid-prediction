library(shiny)

# Carregar o modelo treinado
modelo_treinado <- readRDS("modelo_covid.rds")

# Definir a interface do aplicativo
ui <- fluidPage(
  titlePanel("Predição da Evolução de Pacientes com Covid-19"),
  sidebarLayout(
    sidebarPanel(
      # Inserir campos de entrada para atributos do paciente aqui
      numericInput("idade", "Idade:", value = 90)
      # Adicione outros campos de entrada conforme necessário
    ),
    mainPanel(
      # Exibir resultados da previsão aqui
      textOutput("resultado")
    )
  )
)

# Definir a lógica do aplicativo
server <- function(input, output) {
  # Função para realizar a previsão
  realizarPredicao <- function(idade) {
    # Criar um data frame com os dados de entrada
    dados_predicao <- data.frame(idade = idade)

    # Fazer a previsão com o modelo
    previsao <- predict(modelo_treinado, dados_predicao)

    return(previsao)
  }

  # Atualizar o resultado da previsão
  output$resultado <- renderText({
    idade <- input$idade
    previsao <- realizarPredicao(idade)
    print(previsao$.pred_class[1])
    return(paste("Evolução Prevista:", previsao$.pred_class[1]))
  })
}

# Rodar o aplicativo Shiny
shinyApp(ui, server)

shiny::runApp()

