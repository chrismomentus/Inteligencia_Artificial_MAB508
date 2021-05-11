/* Nome: Chris G. Chinedozie-114197959
* Gabriela Mendonça da Silva - 117154510
* 
* fonte:
* 1 - https://en.wikipedia.org/wiki/Prolog_syntax_and_semantics
* 2 - https://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/
*/

solucaopuzzle(BlankMoves) :- 
  Goal = '1'/'2'/'3'/'4'/'5'/'6'/'7'/'8'/'9'/'10'/'11'/'12'/'13'/'14'/'15'/0,
  State = '1'/'2'/'3'/'4'/'5'/'6'/'7'/'8'/'9'/'10'/'11'/'15'/'13'/'14'/'12'/0,
  fFunction(State,Goal,0,F),
  search([(State,0,F,[],[])],M,L,Goal), 
  reverse(M,BlankMoves),
  reverse(L,StatesList),
  printgrid(State),
  printSoln(StatesList),
  write(BlankMoves).

/*% Imprime a Solução */

printSoln([]):-nl.
printSoln([X|L]):-nl,printgrid(X),printSoln(L).

/* Utilizei A - P, para poder expressa-lo em singleton variaveis*/
printgrid(A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P):-write(A),tab(3),write(B),tab(3),write(C),tab(3),write(D),nl,write(E),tab(3),write(F),tab(3),write(G),tab(3),write(H),nl,write(I),tab(3),write(J),tab(2),write(K),tab(2),write(L),nl,write(M),tab(2),write(N),tab(2),write(O),tab(2),write(P),nl.


/* ********* algoritmo A* *******

%  Function de Busca*/

fFunction(State,Goal,Dn,Fn):- 
  hFunction(State,Goal,Hn),
  Fn is Dn + Hn.
  
search([(State,_,_,MovesList,List)|_],MovesList,List,Goal):- isequal(State,Goal).
search([N|Ns],MovesList,List,Goal):- 
  expand(N,Children,Goal),
  insertAll(Children,Ns,Open),
  search(Open,MovesList,List,Goal).

insertAll([C|Cs],Open1,Open3):- 
  insert(C,Open1,Open2),
  insertAll(Cs,Open2,Open3).
insertAll([],Open,Open).

/*insert(B,Open,Open):-sameNode(B,Open),!.*/
insert(B,[C|R],[B,C|R]):-checkCost(B,C),!.
insert(B,[B1|R],[B1|S]):-insert(B,R,S),!.
insert(B,[],[B]).

/*sameNode((State,_,_,_,_),[(State,_,_,_,_)|_]).

Verifica se o valor da busca entre os dois, qual é menor ( cheaper search value)*/
checkCost((_,_,F1,_,_) , (_,_,F2,_,_)) :- F1 < F2.

% Expand State to find its all possible children 
expand((State,Depth,_,M,L),All_My_Children,Goal) :-
  bagof((Child,D1,F,[Move|M],[Child|L]),
        (D1 is Depth+1,move(State,Child,Move),fFunction(Child,Goal,D1,F)),
        All_My_Children).

isequal(X,X).


/****** 15 Puzzle  Comeca aqui******

% o movimento do puzzle */

esqueda(State,Goal):-
  getList(State,L1),
  indexOf(L1,0,I1),
  isLeftValid(I1),
  NewSpace is I1 - 1,
  elementAt(Num,L1,NewSpace),
  delete(L1,0,L2),delete(L2,Num,L3),
  insertAt(0,L3,I1-1,L4),insertAt(Num,L4,I1,List),
  getState(List,Goal).

direita(State,Goal):-
  getList(State,L1),
  indexOf(L1,0,I1),
  isRightValid(I1),
  NewSpace is I1 + 1,
  elementAt(Num,L1,NewSpace),
  delete(L1,0,L2),delete(L2,Num,L3),
  insertAt(Num,L3,I1,L4),insertAt(0,L4,I1+1,List),
  getState(List,Goal).

cima(State,Goal):-
  getList(State,L1),
  indexOf(L1,0,I1),
  isUpValid(I1),
  NewSpace is I1 - 4,
  elementAt(Num,L1,NewSpace),
  delete(L1,0,L2),delete(L2,Num,L3),
  insertAt(0,L3,I1-4,L4),insertAt(Num,L4,I1,List),
  getState(List,Goal).

baixo(State,Goal):-
  getList(State,L1),
  indexOf(L1,0,I1),
  isDownValid(I1),
  NewSpace is I1 + 4,
  elementAt(Num,L1,NewSpace),
  delete(L1,0,L2),delete(L2,Num,L3),
  insertAt(Num,L3,I1,L4),insertAt(0,L4,I1+4,List),
  getState(List,Goal).

/* Here corner conditions are checked.
fazer check das condições e confirmação de valores de lado*/
isLeftValid(Space):-X is mod(Space,4), X \= 1.
isRightValid(Space):-X is mod(Space,4), X \= 0.
isUpValid(Space):-hrange(1,4,L),not(member(Space,L)).
isDownValid(Space):-X is (1+(4 * (4-1))),Y is (4 * 4),hrange(X,Y,L),not(member(Space,L)).

/*
O range horizontal entre o primeiro espaçõ e o ultimo espaço, preenchido pelo objeto*/
hrange(First,First,[First]).
hrange(First,Last,[First|L]) :- First < Last, Next is First + 1,hrange(Next,Last,L).

/* Retira o elemento em posição K */
removeAt(X,[X|Xs],1,Xs).
removeAt(X,[Y|Xs],K,[Y|Ys]) :- K > 1,
   K1 is K - 1, removeAt(X,Xs,K1,Ys).

/*% Insere o elemento na posição K */
insertAt(X,L,K,R) :- removeAt(X,R,K,L).

/* Obter o elemento X na posição K */
elementAt(X,[X|_],1).
elementAt(X,[_|L],K) :- K > 1, K1 is K - 1, elementAt(X,L,K1).

getState([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P],A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P).

/* Funçãos de Move */

move(State,Child,esqueda):-esqueda(State,Child).
move(State,Child,cima):-cima(State,Child).
move(State,Child,direita):-direita(State,Child).
move(State,Child,baixo):-baixo(State,Child).

/* Heuristic Function*/

hFunction(State,Goal,H):- 
  obterDistanciaHeuristic(State,Goal,D),     
  H is D.
                      
/* A função Heuristic distance */

obterDistanciaHeuristic(State,Goal,D):-getList(State,L1),getList(Goal,L2),md(L1,L1,L2,D).

getList(A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P,List):- List = [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P].

md([],_,_,0).
md([X|Xs],S,G,D):-(X\=0 -> indexOf(S,X,I1),indexOf(G,X,I2),manD(I1,I2,D1),md(Xs,S,G,D2),D is D1 + D2; D1 = 0,md(Xs,S,G,D2),D is D1 + D2).

indexOf([Element|_], Element,1):- !.
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1),
  !,
  Index is Index1+1.

mandist(X/Y,X1/Y1,D):-
  dif(X,X1,Dx),
  dif(Y,Y1,Dy),
  D is Dx + Dy,
  D>=0.

dif(A,B,D) :-
  D is A - B,
  D >= 0.
dif(A,B,D) :-
  D is B - A,
  D > 0.

manD(Space1,Space2,D):-
  getx(Space1,X1),
  gety(Space1,Y1),
  getx(Space2,X2),
  gety(Space2,Y2),
  mandist(X1/Y1,X2/Y2,D).

/* Obter o valor X do espaço*/
getx(P,X):- M is mod(P,4), M=0, X is 4,!.
getx(P,X):- X is mod(P,4).

/* Obter o valor Y do espaço*/
gety(P,Y):- M is mod(P,4), M=0, Y is P/4,!.
gety(P,Y):- Y is truncate(P/4+1).

/*---Configurações
- '1'/'2'/'3'/'4'/'5'/'6'/'7'/'8'/'9'/'10'/'11'/'12'/'13'/'14'/0/'15'
- '1'/'2'/'3'/'4'/'5'/'6'/'7'/'8'/'9'/'10'/'15'/'12'/'13'/'14'/'11'/0
- '1'/0/'3'/'4'/'5'/'6'/'7'/'8'/'9'/'10'/'11'/'12'/'13'/'14'/'15'/'2'
- '15'/'2'/'1'/'12'/'8'/'5'/'6'/'11'/'4'/'9'/'10'/'7'/'3'/'14'/'13'/0

%solucaopuzzle(X).
*/