/*
Defina uma regra Prolog para relação irmaos(X,Y) que representa que "X é irmão/irmã de Y". 
Caso seja necessário, você pode definir outros predicados para auxiliar na tarefa. 
Considere que os irmãos tem o mesmo pai e a mesma mãe.
Nome: Chris G. Chinedozie
*/
parent(pam,bob).
parent(tom,bob).
parent(tom,liz).
parent(bob,ann).
parent(bob,pat).
parent(pat,jim).
female(pam).
female(liz).
female(ann).
female(pat).
male(tom).
male(bob).
male(jim).

father(X,Y) :- 
    male(X),
    parent(X,Y).

mother(X,Y) :- 
    female(X),
    parent(X,Y).

%X e Y tem mesmo pai e mae
irmaos(X,Y) :- 
    father(X,Y),
    mother(X,Y),
    not(X = Y).
%X é irma para Y
irma(X, Y) :-
      irmaos(X, Y),
      female(X),
      not(X = Y).
%X é irmao para Y
irmao(X, Y) :-
      irmaos(X, Y),
      male(X),
      not(X = Y).