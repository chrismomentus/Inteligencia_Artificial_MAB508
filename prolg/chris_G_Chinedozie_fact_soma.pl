/*
1) Faça um programa recursivo que dado um número n, retorna a soma dos números de 0 a n. Por exemplo:?-soma(5,S).S = 15
2) Faça um programa recursivo que dado um número n, retorna o fatorial de n. Por exemplo:?- fatorial(5,S).S = 120
Nome: Chris G Chinedozie
*/

factorial(0,1). 

factorial(N,F) :-  
   N>0, 
   N1 is N-1, 
   factorial(N1,F1), 
   F is N * F1.

soma(0,0).

soma(N,R) :-
    N > 0 ,
    N1 is N-1 ,
    sum(N1,R1) ,
    R is R1+N.