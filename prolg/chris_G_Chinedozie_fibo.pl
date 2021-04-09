/* A siquencia de fibonnaci implementado em ProLog
* nome: Chris G. Chinedozie
*/
/*
A sequência de Fibonacci é uma sequência de números inteiros começando por 0 e 1, na qual cada termo subsequente correspondente à soma dos dois anteriores: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, ...
Faça um programa Prolog que retorna o n-ésimo elemento da sequência de Fibonacci. Por exemplo:
?- fibo(1,N).
N = 0
?- fibo(5,N).
N=3
?- fibo(8,N).
N=13
*/
fib(1, 0) :- !.
fib(2, 1) :- !.
fib(N, Result) :- 
    N1 is N - 1, N2 is N - 2, 
    fib(N1, Result1), 
    fib(N2, Result2), 
    Result is Result1 + Result2.
