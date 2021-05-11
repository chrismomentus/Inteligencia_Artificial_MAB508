/*Name: Chris G. Chinedozie
*DRE: 114197959
*
*/

%Recebeu vazio retorna vazio
elementoComum([],[],[]).

%L1 vazio e L2 nao-vazio, retorna L2
elementoComum([],[H2|T2],[H2|T2]).

%L1 nao vazio e L2 vazio, retorna L1
elementoComum([H1|T1],[],[H1|T1]).

/*ambos são nao-vazio, nesse caso os 2 primeiros elementos do resultado são a cabeça da lista, em seguida recursão do tail da lista*/
elementoComum([H1|T1],[H2|T2],[H1,H2|TT]) :-
    elementoComum(T1,T2,TT).


inter([], [], []).

inter([], [H2|L2], [H2|L2]).

inter([H1|L1], L2, [H1|Res]) :-
    member(H1, L2),
    inter(L1, L2, Res).
    
inter([_|L1], L2, Res) :-
    inter(L1, L2, Res).
    

