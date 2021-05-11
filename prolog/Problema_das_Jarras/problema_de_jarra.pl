/*Nome : Chris G. Chinedozie
*DRE: 114197959
*
*/
objetivo((2,_)).



acao((X,Y),encher1,(4,Y)):- X < 4.
acao((X,Y),encher2,(X,3)):- Y < 3.
acao((X,Y), esvaziar1, (0, Y)) :- X > 0.
acao((X,Y), esvaziar2, (X, 0)) :- Y > 0.


acao((X, Y), passar12, (X1, Y1)) :- Z is 3 - Y, Y < 3, X > 0, 
                                   Z < X, X1 is X - Z,Y1 is Y + Z.


acao((X, Y), passar12, (X1, Y1)) :- 3-Y >= X, X > 0,Y < 3,  X1 is 0, Y1 is Y + X.


acao((X, Y), passar21, (X1, Y1)) :- X < 4, Y > 0, Z is 4 - X, Z < Y, X1 is X + Z,
   									 Y1 is Y - Z.

acao((X, Y), passar21, (X1, Y1)) :- 4 - X >= Y, X < 4, Y > 0,  Y1 is 0, X1 is X + Y.


vizinho(N,FilhosN):- findall(Nf,acao(N,_,Nf),FilhosN).



add_to_frontier(NN,F1,F2):- append(F1,NN,F2).




busca_largura([No|L]):- objetivo(No),! ; vizinho(No,FilhosN),
   					add_to_frontier(FilhosN,L,Lf)
   					,busca_largura(Lf).






busca_largura([No|L],[No|L1]):- objetivo(No),! ; vizinho(No,FilhosN),
     							add_to_frontier(FilhosN,L,Lf),
	   						    busca_largura(Lf,L1).




retirar_todas(_,[],[]).
retirar_todas(Elem,[Elem|Cauda],L):- retirar_todas(Elem,Cauda,L).
retirar_todas(Elem,[Elem1|Cauda],[Elem1|Cauda1]):- Elem \== Elem1, retirar_todas(Elem,Cauda,Cauda1).




retirar_rep([],[]).
retirar_rep([Elem|Cauda],[Elem|Cauda1]):- retirar_todas(Elem,Cauda,Lista).
    									
add_to_frontier(FilhosN,L,Lf):- append(L,FilhosN,Lf).
    
   
    
busca_largura([No|L],[No|L1]):- objetivo(No),! ; vizinho(No,FilhosN),
	   							add_to_frontier(FilhosN,L,Lf),
	   							append([No],Lf,K),
   							    retirar_rep(K,Lf2),
	   						    busca_largura(Lf2,L1).







add_to_frontier(NN,F1,F2):- append(NN,F1,F2).




busca_largura([No|L]):- objetivo(No),! ; vizinho(No,FilhosN),
  					add_to_frontier(FilhosN,L,Lf)
  					,busca_largura(Lf).




busca_largura([No|L],[No|L1]):- objetivo(No),! ; vizinho(No,FilhosN),
     							add_to_frontier(FilhosN,L,Lf),
	   						    busca_largura(Lf,L1).




% Questão g da f)
retirar_todas(_,[],[]).
retirar_todas(Elem,[Elem|Cauda],L):- retirar_todas(Elem,Cauda,L).
retirar_todas(Elem,[Elem1|Cauda],[Elem1|Cauda1]):- Elem \== Elem1, retirar_todas(Elem,Cauda,Cauda1).




retirar_rep([],[]).
retirar_rep([Elem|Cauda],[Elem|Cauda1]):- retirar_todas(Elem,Cauda,Lista),
    										retirar_rep(Lista,Cauda1).
add_to_frontier(FilhosN,L,Lf):- append(FilhosN,L,Lf).
    
   
    
busca_profundidade([No|L],[No|L1]):- objetivo(No),! ; vizinho(No,FilhosN),
	   							add_to_frontier(FilhosN,L,Lf),
	   							append([No],Lf,K),
    							retirar_rep(K,Lf2),
	   						    busca_profundidade(Lf2,L1).
















