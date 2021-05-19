from random import randint
import sys
from random import uniform
from math import exp

#criar tabuleiro de uma lista de tamanho N (N = numero de rainhas)
#cada elemento da lista poderá ir de zero a N
def criar_Tabuleiro(num_de_Rainhas):
  tabuleiro = []
  for i in range(0, num_de_Rainhas):
    tabuleiro.append(randint(1, num_de_Rainhas))
  print("O tabuleiro foi criado:")
  print(tabuleiro)
  return tabuleiro

# Para cada rainha no tabuleiro, busca quantos ataques são possíveis na horizontal
def buscarNumeroDeAtaquesNaHorizontal(tabuleiro):
    numeroDeAtaques = 0
    for posicaoRainha in range (0,len(tabuleiro)):
        for possivelAtaqueNaDireita in range (posicaoRainha,len(tabuleiro)):
            if possivelAtaqueNaDireita == posicaoRainha:
                continue 

            elif tabuleiro[posicaoRainha] == tabuleiro[possivelAtaqueNaDireita]:
                numeroDeAtaques += 1 
                break           
    return numeroDeAtaques

# Analisa o tabuleiro no sentido nordeste de cada rainha, contando o número de ataques possíveis no diagonal
def buscarNumeroDeAtaquesNoNordeste(tabuleiro):
    numeroDeAtaques = 0

    for posicaoRainha in range (0,len(tabuleiro)):
        mapeiaDiagonal = tabuleiro[posicaoRainha]
        for posicaoHorizontal in range (posicaoRainha + 1, len(tabuleiro)):
            mapeiaDiagonal -= 1

            if tabuleiro[posicaoHorizontal] == mapeiaDiagonal:
                numeroDeAtaques += 1
                break
    return numeroDeAtaques

# Analisa o tabuleiro no sentido sudeste de cada rainha, contando o número de ataques possíveis nos diagonal
def buscarNumeroDeAtaquesNoSudeste(tabuleiro):
    numeroDeAtaques = 0

    for posicaoRainha in range (0,len(tabuleiro)):
        mapeiaDiagonal = tabuleiro[posicaoRainha]
        for posicaoHorizontal in range (posicaoRainha + 1, len(tabuleiro)):
            mapeiaDiagonal += 1

            if tabuleiro[posicaoHorizontal] == mapeiaDiagonal:
                numeroDeAtaques += 1
                break
    return numeroDeAtaques
  
def buscarNumeroDeAtaquesNaVertical(tabuleiro):
  #TO-DO
  ataque_vertical = buscarNumeroDeAtaquesNoNordeste(tabuleiro) + buscarNumeroDeAtaquesNoSudeste(tabuleiro)
  return ataque_vertical

# Como a heurística é baseada em números de ataques. Esta função retorna quantos ataques são possíveis no tabuleiro
def num_Ataques_No_Tabuleiro(tabuleiro):
  num_de_ataques = buscarNumeroDeAtaquesNaHorizontal(tabuleiro) + buscarNumeroDeAtaquesNaVertical(tabuleiro)
  print(num_de_ataques)
  return num_de_ataques

#8,16,32,64
#criar_Tabuleiro(8) 

#Entre um conjunto de tabuleiro, retorna o tabuleiro com o melhor heuristica
def busca_primeiro_melhorVizinho(tabuleiro, vizinhos):
  melhor_Vizinho = tabuleiro
  #uma busca de ataques
  melhor_Heuristica = num_Ataques_No_Tabuleiro(tabuleiro)

  for vizinho in vizinhos:
    heuristica_Vizinho = num_Ataques_No_Tabuleiro(vizinho)
    if heuristica_Vizinho < melhor_Heuristica:
      melhor_Heuristica = heuristica_Vizinho
      melhor_Vizinho = vizinho
      break
  
  print("O primeiro melhor vizinho encontrado foi:")
  print(melhor_Vizinho)
  print("Com o heuristica de valor: ")
  print(melhor_Heuristica)
  return [melhor_Vizinho, melhor_Heuristica, len(vizinhos)]

# Busca e retornar todos os vizinhos do tabuleiro em questão
def recuperaVizinhosDeTabulero(tabuleiro):
    vizinhos_De_Tabuleiro = [] 
    
    for identificadorDaRainha in range (0, len(tabuleiro)):
        for posicaoDaRainha in range (1, len(tabuleiro)+1):
            
            if posicaoDaRainha == tabuleiro[identificadorDaRainha] : 
                continue
    
            vizinho = tabuleiro.copy()
            vizinho[identificadorDaRainha] = posicaoDaRainha
            vizinhos_De_Tabuleiro.append(vizinho)

    return vizinhos_De_Tabuleiro



 #Simula o problema Usando Hillclimbing
def problema_N_Rainha_com_HillClimbing(num_de_Rainhas):
  tabuleiro = criar_Tabuleiro(num_de_Rainhas)

  tabuleiro_Atual = tabuleiro
  heuristicaAtual = sys.maxsize
  cont_heuristica_Repetida = 0
  cont_Tabuleiro_Gerados = 0

  print("----------------------------------------------------")

  while(True):
    
    melhor_vizinho_comHeuristica = busca_primeiro_melhorVizinho(tabuleiro_Atual, recuperaVizinhosDeTabulero(tabuleiro_Atual))
    #print("melhor_vizinho_comHeuristica")
    #print(melhor_vizinho_comHeuristica)
    cont_Tabuleiro_Gerados +=  melhor_vizinho_comHeuristica[2]

    if heuristicaAtual == melhor_vizinho_comHeuristica[1]:
      cont_heuristica_Repetida += 1
    
    if heuristicaAtual > melhor_vizinho_comHeuristica[1]:
      cont_heuristica_Repetida = 0
      tabuleiro_Atual = melhor_vizinho_comHeuristica[0]
      heuristicaAtual = melhor_vizinho_comHeuristica[1]

    if cont_heuristica_Repetida > 3:
      print("foi encontrado um ombro, terminamos a execução...")
      break
    
    if heuristicaAtual == 0:
      print("Solução Encontrada!!")
      print("A solução do problema será:")
      print(tabuleiro_Atual)
      break

  print("==================================================")
  return [tabuleiro_Atual, heuristicaAtual, cont_Tabuleiro_Gerados]

problema_N_Rainha_com_HillClimbing(4)
#problema_N_Rainha_com_HillClimbing(8)
#problema_N_Rainha_com_HillClimbing(16)
#problema_N_Rainha_com_HillClimbing(32)

#Retorna um vizinho alearório dado um tabuleiro
def busca_Vizinho_Aleatorio(tabuleiro):
  #TO-DO: (done)
  vizinhos = recuperaVizinhosDeTabulero(tabuleiro)
  vizinhoAleatorio = vizinhos[randint(0,len(tabuleiro))]
  print("O vizinho aleatório retornado será:")
  print(vizinhoAleatorio)
  return [vizinhoAleatorio, len(vizinhos)]

#Simula o problema usando Simulated Annealing
def problema_N_Rainha_com_Simulted_Annealing(num_de_Rainhas, iter_Max, temp_Inicial, alpha):
  tabuleiro = criar_Tabuleiro(num_de_Rainhas)

  tabuleiro_Atual = tabuleiro
  solucao = tabuleiro_Atual

  temp_Atual = temp_Inicial
  cont_vizinho_gerados = 0

  for i in range(1, iter_Max):
    if(temp_Atual <= 0):
      break
    
    vizinho_Aleatorio = busca_Vizinho_Aleatorio(solucao)
    heuristica_Vizinho_Aleatorio = num_Ataques_No_Tabuleiro(vizinho_Aleatorio[0])

    diferenca_Custo = heuristica_Vizinho_Aleatorio - num_Ataques_No_Tabuleiro(tabuleiro_Atual)

    cont_vizinho_gerados += vizinho_Aleatorio[1]

    if(diferenca_Custo < 0):
      tabuleiro_Atual = vizinho_Aleatorio[0]
      if(num_Ataques_No_Tabuleiro(vizinho_Aleatorio[0]) <= num_Ataques_No_Tabuleiro(solucao)):
        solucao = vizinho_Aleatorio[0]
        if(heuristica_Vizinho_Aleatorio == 0):
          break
    else:
      if(uniform(0,1) < exp(-(diferenca_Custo / temp_Atual))):
        tabuleiro_Atual = vizinho_Aleatorio[0]
    
    temp_Atual = temp_Atual * alpha
  print("-------------------------------------------------")
  print("A soluçao encontrada foi:")
  print(solucao)
  print("Com a heuristica: ")
  print(num_Ataques_No_Tabuleiro(solucao))
  print("=================================================")
  return [solucao, cont_vizinho_gerados]


#problema_N_Rainha_com_Simulted_Annealing(4, 20, 100, 0.1)
#problema_N_Rainha_com_Simulted_Annealing(8, 10, 50, 0.5)
#problema_N_Rainha_com_Simulted_Annealing(16, 10, 50, 0.1)


