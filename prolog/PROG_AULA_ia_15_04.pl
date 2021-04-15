%%%%%%% 3.20
soma([],0,[]).
% Elemento X está na sublista
soma([X|L],N,[X|L1]):-
    			N1 is N - X,
    			N1 >= 0,
    			soma(L,N1,L1).
  
% Elemento X não está na sublista
soma([_|L],N,L1):-
    			soma(L,N,L1).


%%%%%%% 3.11
flatten([], []).

flatten([Head | Tail], FlatList):-
	flatten(Head, FlatHead),
	flatten(Tail, FlatTail),!,
	append(FlatHead, FlatTail, FlatList).

flatten(X, [X]).

% Consulta: flatten([a,b,[c,d],[],[[[e]]],f],L).


%%%%%%% 5.5
dif1(L1,L2,L3):-
    	dif(L1,L2,L),
    	permutation(L,L3).
dif([],_,[]).

%Primeiro Caso: elemento de L1 está em L2
dif([X|L1],L2,L3):- 
			member(X,L2),!,
			dif(L1,L2,L3).

%Segundo Caso: elemento de L1 não está em L2
dif([X|L1],L2,[X|L3]):-
    		dif(L1,L2,L3).