#Definir funcao de avaliacao, minimizar o numero de conflitos que ocorrem no tabuleiro.

#Funcao e otima quando avaliacao e 0 , dada uma configuracao de tabuleiro.

#inicializacao
matriz = [[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
count = []
valorU = 0

from random import randint
import collections

for init in range(0,9):
    count.append([0,0,0,0,0,0,0,0,0])

#Atribui valores randomicamente
for x in range(0,9):
    for y in range(0,9):
        matriz[x][y]= randint(0,9)

#funcao de avaliacao conta repetidos numa mesma coluna:
matriz[0][3] = 7
matriz[1][0] = 1
matriz[2][3] = 4
matriz[2][4] = 3
matriz[2][6] = 2
matriz[3][8] = 6
matriz[4][3] = 5
matriz[4][5] = 9
matriz[5][6] = 4
matriz[5][7] = 1
matriz[5][8] = 8
matriz[6][4] = 8
matriz[6][5] = 1
matriz[7][2] = 2
matriz[7][7] = 5
matriz[8][1] = 4
matriz[8][6] = 3

def conta():
#funcao de avaliacao conta repetidos numa mesma linha:
    for i in range (0,9):
        for j in range(0,9):
            for k in range(0,9):
               if(matriz[i][j] == matriz[i][k] and k!=j):
                    count[i][j] += 1
#funcao de avaliacao conta repetidos numa mesma coluna:
    for i in range (0,9):
        for j in range(0,9):
            for k in range(0,9):
               if(matriz[i][j] == matriz[k][j] and k!=i):
                    count[i][j] += 1
   
    return 0


def zera():
    for x in range (0,9):
        for y in range (0,9):
           count[x][y] = 0
    return 0

def imprime():
    print('=' * 30)
    for x in range(0,9):
        for y in range(0,9):
            print(f'[{matriz[x][y]:^5}]', end='')
        print()

def contaTodos():
    contando = 0
    for x in range (0,9):
        for y in range (0,9):
            contando += count[x][y]
    return contando

def metodoVerifica(i,j):
    
    vetorVerificador = []
      
    
    for t in range (0,9):
        matriz[i][j] = t+1

        PrimeiroQuadrante = []
        SegundoQuadrante = []
        TerceiroQuadrante = []
        QuartoQuadrante = []
        QuintoQuadrante = []
        SextoQuadrante = []
        SetimoQuadrante = []
        OitavoQuadrante = []
        NonoQuadrante = []
        
        for x in range (0,3):
            for y in range (0,3):
                PrimeiroQuadrante.append(matriz[x][y])
        for x in range (3,6):
            for y in range (0,3):
                SegundoQuadrante.append(matriz[x][y])
        for x in range (6,9):
            for y in range (0,3):
                TerceiroQuadrante.append(matriz[x][y])
        for x in range (0,3):
            for y in range (3,6):
                QuartoQuadrante.append(matriz[x][y])
        for x in range (3,6):
            for y in range (3,6):
                QuintoQuadrante.append(matriz[x][y])
        for x in range (6,9):
            for y in range (3,6):
                SextoQuadrante.append(matriz[x][y])
        for x in range (0,3):
            for y in range (6,9):
                SetimoQuadrante.append(matriz[x][y])
        for x in range (3,6):
            for y in range (6,9):
                OitavoQuadrante.append(matriz[x][y])
        for x in range (6,9):
            for y in range (6,9):
                NonoQuadrante.append(matriz[x][y])
        

        repetidosPrimeiro = collections.Counter(PrimeiroQuadrante)
        repetidosSegundo = collections.Counter(SegundoQuadrante)
        repetidosTerceiro = collections.Counter(TerceiroQuadrante)
        repetidosQuarto = collections.Counter(QuartoQuadrante)
        repetidosQuinto = collections.Counter(QuintoQuadrante)
        repetidosSexto = collections.Counter(SextoQuadrante)
        repetidosSetimo = collections.Counter(SetimoQuadrante)
        repetidosOitavo = collections.Counter(OitavoQuadrante)
        repetidosNono = collections.Counter(NonoQuadrante)

        pontosPrimeiro = 0
        pontosSegundo = 0
        pontosTerceiro = 0
        pontosQuarto = 0
        pontosQuinto = 0
        pontosSexto = 0
        pontosSetimo = 0
        pontosOitavo = 0
        pontosNono = 0
        for e in range(1,10):
            if(repetidosPrimeiro[e] > 1):
              pontosPrimeiro += (repetidosPrimeiro[e]-1)
        for e in range(1,10):
            if(repetidosSegundo[e] > 1):
             pontosSegundo += (repetidosSegundo[e]-1)
        for e in range(1,10):
            if(repetidosTerceiro[e] > 1):
                 pontosTerceiro += (repetidosTerceiro[e]-1)
        for e in range(1,10):
             if(repetidosQuarto[e] > 1):
                    pontosQuarto += (repetidosQuarto[e]-1)
        for e in range(1,10):
             if(repetidosQuinto[e] > 1):
                 pontosQuinto += (repetidosQuinto[e]-1)
        for e in range(1,10):
            if(repetidosSexto[e] > 1):
                 pontosSexto += (repetidosSexto[e]-1)
            if(repetidosSetimo[e] > 1):
                pontosSetimo += (repetidosSetimo[e]-1)
        for e in range(1,10):
            if(repetidosOitavo[e] > 1):
                pontosOitavo += (repetidosOitavo[e]-1)
        for e in range(1,10):
            if(repetidosNono[e] > 1):
                pontosNono += (repetidosNono[e]-1)
        
        
        if(1):
            zera()
            conta()
            contando = contaTodos()
            zera()
            novo = contando + pontosPrimeiro + pontosSegundo + pontosTerceiro + pontosQuarto + pontosQuinto + pontosSexto
            + pontosSetimo + pontosOitavo + pontosNono
            vetorVerificador.append(novo)
            
        if( t == 8):
            matriz[i][j] = vetorVerificador.index(min(vetorVerificador)) + 1  


imprime()
conta()
print(contaTodos())
zera()

#Realiza a execução de melhoramento da configuração 15x, chamando novamente.
for k in range (0,15):
    imprime()
    conta()
    contando = contaTodos()
    print(contando)
    zera()
    for x in range (0,9):
        for y in range (0,9):
            if((x==0 and y == 3) or
                (x==1 and y == 0) or
                (x==2 and y == 3) or
                (x==2 and y == 4) or
                (x==2 and y == 6) or
                (x==3 and y == 8) or
                (x==4 and y == 3) or
                (x==4 and y == 5) or
                (x==5 and y == 6) or
                (x==5 and y == 7) or
                (x==5 and y == 8) or
                (x==6 and y == 4) or
                (x==6 and y == 5) or
                (x==7 and y == 2) or
                (x==7 and y == 7) or
                (x==8 and y == 2) or
                (x==8 and y == 6)):
                  valorU += 1
            else:
               metodoVerifica(x,y)   


