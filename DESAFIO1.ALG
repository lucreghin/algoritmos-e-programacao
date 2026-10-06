Algoritmo "LogiFast_desafio1"
// Disciplina  : Algoritmo e Lógica de Programação 
// Professor   : André Olímpio 
// Descrição   : Um programa que administra pedidos de uma empresa, organiza
//               entregas, defini prioridades, acompanha cargas e auxilia na
//               tomada de decisoes.
// Autor(a)    : Lucas Reghin Santos
// Data atual  : 9/30/2026

//declaração constantes
const
MAX_ENTREGAS = 30
MAX_REGIOES = 5

URGENTE = 1
PRIORITARIA = 2
NORMAL = 3

AGUARDANDO = 1
EM_TRANSPORTE = 2
ENTREGUE = 3

VALOR_KM = 5/2
// declaração registros
tipo
entrega = registro
    codigo,status,destino,origem,prioridade: inteiro
    destinatario: caractere
    custo, valorMercadoria,peso,distancia: real
fimregistro
Var
// Seção de Declarações das variáveis
quantidadeEntregas,q_aguardando,q_em_transporte,q_entregue,posicao,opcao,codigoProcurado:inteiro

entregas: vetor[1..MAX_ENTREGAS] de entrega
fila: vetor[1..MAX_ENTREGAS] de inteiro

procedimento fila_despacho()
var
i,j,auxiliar: inteiro
inicio
para i de 1 ate quantidadeEntregas faca
fila[i] <- i
fimpara
//selection sort para definir a fila das entregas
para i de 1 ate quantidadeEntregas - 1 faca
   para j de i + 1 ate quantidadeEntregas faca
      se entregas[fila[j]].prioridade < entregas[fila[i]].prioridade entao
         auxiliar <- fila[i]
         fila[i] <- fila[j]
         fila[j] <- auxiliar
      senao
        se entregas[fila[j]].prioridade = entregas[fila[i]].prioridade entao
          se entregas[fila[j]].valorMercadoria > entregas[fila[i]].valorMercadoria entao
             auxiliar <- fila[i]
             fila[i] <- fila[j]
             fila[j] <- auxiliar
          senao
            se entregas[fila[j]].valorMercadoria = entregas[fila[i]].valorMercadoria entao
              se entregas[fila[j]].peso > entregas[fila[i]].peso entao
                 auxiliar <- fila[i]
                 fila[i] <- fila[j]
                 fila[j] <- auxiliar
              senao
                se entregas[fila[j]].peso = entregas[fila[i]].peso entao
                  se entregas[fila[j]].codigo < entregas[fila[i]].codigo entao
                     auxiliar <- fila[i]
                     fila[i] <- fila[j]
                     fila[j] <- auxiliar
                  fimse
                fimse
              fimse
            fimse
          fimse
        fimse
      fimse
   fimpara
fimpara
para i de 1 ate quantidadeEntregas faca
      escreval("----------------------------------------")
      escreval("Código: ", entregas[fila[i]].codigo)
      escreval("Destinatário: ", entregas[fila[i]].destinatario)
      escreval("Origem: ", nome_regiao(entregas[fila[i]].origem))
      escreval("Destino: ", nome_regiao(entregas[fila[i]].destino))
      escreval("Peso: ", entregas[fila[i]].peso)
      escreval("Valor da mercadoria: R$ ", entregas[fila[i]].valorMercadoria)
      escreval("Prioridade: ", nome_prioridade(entregas[fila[i]].prioridade))
      escreval("Distância: ", entregas[fila[i]].distancia)
      escreval("Status: ", nome_status(entregas[fila[i]].status))
      escreval("Custo: R$ ", entregas[fila[i]].custo)
fimpara
fimprocedimento

matrizRegioes: vetor[1..MAX_REGIOES, 1..MAX_REGIOES] de inteiro
procedimento inicializar_matriz()
inicio

   matrizRegioes[1,1] <- 0
   matrizRegioes[1,2] <- 12
   matrizRegioes[1,3] <- 15
   matrizRegioes[1,4] <- 10
   matrizRegioes[1,5] <- 14

   matrizRegioes[2,1] <- 12
   matrizRegioes[2,2] <- 0
   matrizRegioes[2,3] <- 25
   matrizRegioes[2,4] <- 18
   matrizRegioes[2,5] <- 20

   matrizRegioes[3,1] <- 15
   matrizRegioes[3,2] <- 25
   matrizRegioes[3,3] <- 0
   matrizRegioes[3,4] <- 16
   matrizRegioes[3,5] <- 19

   matrizRegioes[4,1] <- 10
   matrizRegioes[4,2] <- 18
   matrizRegioes[4,3] <- 16
   matrizRegioes[4,4] <- 0
   matrizRegioes[4,5] <- 22

   matrizRegioes[5,1] <- 14
   matrizRegioes[5,2] <- 20
   matrizRegioes[5,3] <- 19
   matrizRegioes[5,4] <- 22
   matrizRegioes[5,5] <- 0

fimprocedimento
funcao calcular_custo(distancia:real;peso:real;prioridade:inteiro):real
var
   custoBase,percentualPeso,percentualPrioridade: real
inicio
      percentualPeso <- 0
      percentualPrioridade <- 0
      custoBase <- distancia * (5/2)
      //calcular percentual do peso
       se peso > 50 entao
      percentualPeso <- custoBase * (35/100)
      senao
      se peso > 20 entao
         percentualPeso <- custoBase * (2/10)
      senao
         se peso > 5 entao
            percentualPeso <- custoBase * (1/10)
         fimse
      fimse
   fimse
      //calcular percentual da prioridade
      se prioridade = 1 entao
         percentualPrioridade <- custoBase * (3/10)
      senao
         se prioridade = 2 entao
            percentualPrioridade <- custoBase * (15/100)
         fimse
      fimse
      //acréscimos
      custoBase <- custoBase + percentualPeso + percentualPrioridade
      
      RETORNE custoBase
fimfuncao

funcao nome_regiao(codigo: inteiro): caractere
inicio
   se codigo = 1 entao
      retorne "Centro"
   senao
      se codigo = 2 entao
         retorne "Norte"
      senao
         se codigo = 3 entao
            retorne "Sul"
         senao
            se codigo = 4 entao
               retorne "Leste"
            senao
               retorne "Oeste"
            fimse
         fimse
      fimse
   fimse
fimfuncao

funcao nome_prioridade(codigo: inteiro): caractere
inicio
   se codigo = URGENTE entao
      retorne "Urgente"
   senao
      se codigo = PRIORITARIA entao
         retorne "Prioritaria"
      senao
         retorne "Normal"
      fimse
   fimse
fimfuncao

funcao nome_status(codigo: inteiro): caractere
inicio
   se codigo = AGUARDANDO entao
      retorne "Aguardando"
   senao
      se codigo = EM_TRANSPORTE entao
         retorne "Em transporte"
      senao
         retorne "Entregue"
      fimse
   fimse
fimfuncao

funcao consultar_entrega(codigo: inteiro): inteiro
var
   indice, resultado: inteiro
inicio
   resultado <- -1
   indice <- 1
   enquanto (indice <= quantidadeEntregas) e (resultado = -1) faca
      se entregas[indice].codigo = codigo entao
         resultado <- indice
      fimse
      indice <- indice + 1
   fimenquanto
   retorne resultado
fimfuncao

procedimento iniciar_transporte() //5
var
   codigo: inteiro
   posicao: inteiro
inicio
   escreva("Digite o código da entrega: ")
   leia(codigo)

   posicao <- consultar_entrega(codigo)
   se posicao = -1 entao
      escreval("Entrega não encontrada.")
   senao
      se entregas[posicao].status = AGUARDANDO entao
         entregas[posicao].status <- EM_TRANSPORTE
         escreval("Transporte iniciado com sucesso!")
      senao
         escreval("Não é possível iniciar o transporte.")
         escreval("A entrega já foi enviada ou finalizada.")
      fimse
   fimse
fimprocedimento

procedimento finalizar_entrega()
var
   codigo: inteiro
   posicao: inteiro
inicio
   escreva("Digite o código da entrega: ")
   leia(codigo)

   posicao <- consultar_entrega(codigo)
   se posicao = -1 entao
      escreval("Entrega não encontrada.")
   senao
      se entregas[posicao].status = AGUARDANDO entao
         escreval("Não é possível finalizar a entrega! Transporte ainda em aguardo")
      senao
         se entregas[posicao].status = EM_TRANSPORTE entao
         entregas[posicao].status <- ENTREGUE
         escreval("Entrega finalizada com sucesso!")
         SENAO
         escreval("Entraga já foi finalizada")
         fimse
      fimse
   fimse
fimprocedimento

procedimento exibir_matriz()
var
   i, j: inteiro
inicio
   escreval("=========== MATRIZ DE DISTÂNCIAS ===========")
   escreval("             Centro    Norte     Sul     Leste    Oeste")

   para i de 1 ate MAX_REGIOES faca
      escreva(nome_regiao(i))

      se i = 1 entao
         escreva("       ")
      senao
         se i = 2 entao
            escreva("        ")
         senao
            se i = 3 entao
               escreva("          ")
            senao
               se i = 4 entao
                  escreva("        ")
               senao
                  escreva("        ")
               fimse
            fimse
         fimse
      fimse

      para j de 1 ate MAX_REGIOES faca
         escreva(matrizRegioes[i,j], "       ")
      fimpara

      escreval("")
   fimpara
fimprocedimento

procedimento exibir_estatisticas()
var
i,q_aguardando,q_em_transporte,q_entregue,q_urgente,q_priori,q_normal: inteiro
inicio
q_aguardando <- 0
q_em_transporte <- 0
q_entregue <- 0
q_urgente <- 0
q_priori <- 0

//calculo das entregas por status
para i de 1 até quantidadeEntregas faca
     se entregas[i].status = AGUARDANDO entao
        q_aguardando <- q_aguardando + 1
     senao
          se entregas[i].status = EM_TRANSPORTE entao
          q_em_transporte <- q_em_transporte + 1
          senao
               q_entregue <- q_entregue + 1
          fimse
     fimse
fimpara
//calculo das entregas por prioridade
para i de 1 até quantidadeEntregas faca
     se entregas[i].prioridade = URGENTE entao
        q_urgente <- q_urgente + 1
     senao
          se entregas[i].prioridade = PRIORITARIA entao
          q_priori <- q_priori + 1
          senao
               q_entregue <- q_entregue + 1
          fimse
     fimse
fimpara

escreval("Total de entregas:",quantidadeEntregas)
escreval("Aguardando:",q_aguardando)
escreval("Em transporte:",q_em_transporte)
escreval("Entregue:",q_entregue)

fimprocedimento
Inicio
// Seção de Comandos, procedimento, funções, operadores, etc...
quantidadeEntregas <- 0
opcao <- 0
inicializar_matriz()
repita

//menu principal
   escreval("---------------LogiFast---------------")
   escreval("")
   escreval("1. Cadastrar entrega")
   escreval("2. Listar entregas")
   escreval("3. Consultar entregas")
   escreval("4. Exibir fila de despacho")
   escreval("5. Iniciar Transporte")
   escreval("6. Finalizar entrega")
   escreval("7. Exibir matriz de distâncias")
   escreval("8. Exibir Estatisticas")
   escreval("9. Calcular percurso recursivamente")
   escreval("10. Encerrar sistema")
   leia(opcao)
   limpatela
//opções do menu
   escolha opcao
      caso 1
      escreval("Dados da entrega")
      se quantidadeEntregas < MAX_ENTREGAS ENTAO

         repita
         escreval("Código da entrega: ")
         leia(codigoProcurado)

         posicao <- consultar_entrega(codigoProcurado)

         se posicao = -1 entao
               escreval("Código válido!")
         senao
               escreval("Código já existe! Insira outro código")
         fimse

         ate posicao = -1
         quantidadeEntregas <- quantidadeEntregas + 1
         entregas[quantidadeEntregas].codigo <- codigoProcurado
         entregas[quantidadeEntregas].status <- AGUARDANDO

         escreval("destinatário: ")
         leia(entregas[quantidadeEntregas].destinatario)
         //valida o destino
         repita
         escreval("origem: ")
         escreval("1. Centro")
         escreval("2. Norte")
         escreval("3. Sul")
         escreval("4. Leste")
         escreval("5. Oeste")
         leia(entregas[quantidadeEntregas].origem)
         se (entregas[quantidadeEntregas].origem > 5)ou(entregas[quantidadeEntregas].origem < 1) entao
          escreval("opção inválida!")
         fimse
         ate (entregas[quantidadeEntregas].origem <= 5) e (entregas[quantidadeEntregas].origem >= 1)
         //valida o destino
         Repita
            escreval("destino: ")
            escreval("1. Centro")
            escreval("2. Norte")
            escreval("3. Sul")
            escreval("4. Leste")
            escreval("5. Oeste")
            leia(entregas[quantidadeEntregas].destino)
            se (entregas[quantidadeEntregas].destino > 5) ou (entregas[quantidadeEntregas].destino < 1) entao
             escreval("opção inválida! Digite um valor de 1 a 5!")
            senao
             se (entregas[quantidadeEntregas].destino = entregas[quantidadeEntregas].origem) entao
               escreval("Destino não pode ser igual a origem!")
             fimse
            fimse
          ate (entregas[quantidadeEntregas].destino <= 5) e (entregas[quantidadeEntregas].destino >= 1) e (entregas[quantidadeEntregas].destino <> entregas[quantidadeEntregas].origem)

         entregas[quantidadeEntregas].distancia <- matrizRegioes[entregas[quantidadeEntregas].origem,entregas[quantidadeEntregas].destino]
         //lê peso e verifica se é maior que 0
         repita
         escreval("peso: ")
         leia(entregas[quantidadeEntregas].peso)
         se entregas[quantidadeEntregas].peso <= 0 entao
            escreval("peso deve ser maior que 0kg")
         fimse
         até entregas[quantidadeEntregas].peso > 0
         //valida valor da mercadoria
         repita
         escreval("Valor da mercadoria: ")
         leia(entregas[quantidadeEntregas].valorMercadoria)
          se (entregas[quantidadeEntregas].valorMercadoria) <= 0 entao
             escreval("Valor de mercadoria deve ser maior de R$0,00")
          fimse
         ate entregas[quantidadeEntregas].valorMercadoria > 0
         //valida a prioridade
         repita
         escreval("Prioridade: ")
         escreval("  1. Urgente")
         escreval("  2. Prioritária")
         escreval("  3. Normal")
         leia(entregas[quantidadeEntregas].prioridade)
          se (entregas[quantidadeEntregas].prioridade > 3) e (entregas[quantidadeEntregas].prioridade < 1) entao
             escreval("opção inválida!")
          fimse
         ate (entregas[quantidadeEntregas].prioridade < 4) e (entregas[quantidadeEntregas].prioridade > 0)
         entregas[quantidadeEntregas].custo <- calcular_custo(entregas[quantidadeEntregas].distancia,entregas[quantidadeEntregas].peso,entregas[quantidadeEntregas].prioridade)
         escreval("custo da entrega: ",entregas[quantidadeEntregas].custo)
         escreval("Cadastro concluído!")
         escreval("Quantidade de entregas: ", quantidadeEntregas)
         escreval("Pressione ENTER para continuar.")
         leia(opcao)
       SENAO
         escreval("não há espaço para mais entregas")
      fimse

         limpatela
      caso 2

      se quantidadeEntregas = 0 entao
         escreval("Não há entregas cadastradas.")
      senao
           escreval("========== ENTREGAS CADASTRADAS ==========")
         para i de 1 ate quantidadeEntregas faca
            escreval("----------------------------------------")
            escreval("Código: ", entregas[i].codigo)
            escreval("Destinatário: ", entregas[i].destinatario)
            escreval("Origem: ", entregas[i].origem)
            escreval("Destino: ", entregas[i].destino)
            escreval("Peso: ", entregas[i].peso, " kg")
            escreval("Valor da mercadoria: R$ ", entregas[i].valorMercadoria)
            escreval("Prioridade: ", entregas[i].prioridade)
            escreval("Distância: ", entregas[i].distancia, " km")
            escreval("Status: ", entregas[i].status)
            escreval("Custo da entrega: R$ ", entregas[i].custo:6:2)
         fimpara
         escreval("----------------------------------------")
      fimse
      caso 3
           escreva("digite o código do produto: ")
           leia(codigoProcurado)
           posicao <- consultar_entrega(codigoProcurado)
           se posicao = -1 entao
              escreval("Entrega não encontrada!")
           senao
                escreval("======= ENTREGA ========")
                escreval("Código: ", entregas[posicao].codigo)
                 escreval("Destinatário: ", entregas[posicao].destinatario)
                 escreval("Origem: ",  nome_regiao(entregas[posicao].origem))
                 escreval("Destino: ", nome_regiao(entregas[posicao].destino))
                 escreval("Peso: ", entregas[posicao].peso)
                 escreval("Valor da mercadoria: ", entregas[posicao].valorMercadoria)
                 escreval("Prioridade: ", nome_prioridade(entregas[posicao].prioridade))
                 escreval("Distância: ", entregas[posicao].distancia)
                 escreval("Status: ", nome_status(entregas[posicao].status))
                 escreval("Custo da entrega: R$", entregas[posicao].custo:6:2)
           fimse
      caso 4
           fila_despacho()
      caso 5
           iniciar_transporte()
      caso 6
           finalizar_entrega()
      caso 7
           exibir_matriz()
      caso 8
           exibir_estatisticas()
      caso 9
           //calculo_percurso
      caso 10
           escreval("Sistema encerrado.")
      outrocaso
           escreval("Opção inválida.")
   FimEscolha
ate opcao = 10
Fimalgoritmo
