Algoritmo "LogiFast_desafio3"
// 
//  
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

VALOR_KM = 2.50
// declaração registros
tipo
entrega = registro
    codigo, distancia: inteiro
    destinatario, destino, status, prioridade, origem: caractere
    custo, valorMercadoria, peso: real
fimregistro
Var
// Seção de Declarações das variáveis 
repete: logico
entregas: vetor[1..MAX_ENTREGAS] de entrega
i,j:inteiro
procedimento calcular_custo
  var
     contador: inteiro
  inicio
  para contador de 1 ate
fimprocedimento
matrizRegioes: vetor[1..MAX_REGIOES, 1..MAX_REGIOES] de inteiro
procedimento cadastrar_entrega
var
i: inteiro
inicio
para i de 1 ate MAX_ENTREGAS faca
   escreval("Dados da entrega")
Inicio
// Seção de Comandos, procedimento, funções, operadores, etc... 
repita
   repete <- verdadeiro
   escreval("1. Cadastrar entrega")
   escreval("2. Listar entregas")
   escreval("3. Consultar entregas")
   escreval("4. Exibir fila de despacho")
   escreval("5. Iniciar Transporte")
   escreval("6. Finalizar entrega")
   escreval("7. Exibir matriz de distancias")
   escreval("8.Exibir Estatisticas")
   escreval("9. Calcular percurso recursivamente")
   escreval("10. Encerrar sistema")
   leia(opcao)
   escolha opcao
      caso 1
           cadastrar_entrega
      caso 2
           listar_entrega
      caso 3
           consultar_entrega
      caso 4
           fila_despacho
      caso 5
           transporte
      caso 6
           finalizar_entrega
      caso 7
           matriz_distancia
      caso 8
           estatisticas
      caso 9
           calculo_percurso
      caso 10
           repete <- falso
   FimEscolha
ate (repete = falso)
Fimalgoritmo
