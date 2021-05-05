
woman(vincent).
woman(mia).
man(jules).
son(chris, cletus).
son(alpha, cletus).
son(cletus, chibuzo).
son(chibuzo, emeka).

person(X):- 
    man(X); woman(X).

loves(X,Y):- 
    father(X,Y).

father(Y,Z):- 
    man(Y), 
    son(Z,Y),
    daughter(Z,Y).

%RecursaoBegin
%1Eating

is_digesting(X,Y) :- just_ate(X,Y).
is_digesting(X,Y) :-
        just_ate(X,Z),
        is_digesting(Z,Y).

just_ate(mosquito,blood(john)).
just_ate(frog,mosquito).
just_ate(stork,frog).

%2descendant
child(anne,bridget).
child(bridget,caroline).
child(caroline,donna).
child(donna,emily).

%try1-non descent recursive function
/*descend(X,Y) :- child(X,Z_1),
                 child(Z_1,Z_2),
                 child(Z_2,Y).

descend(X,Y) :- child(X,Z_1),
                 child(Z_1,Z_2),
                 child(Z_2,Z_3),
                 child(Z_3,Y). */

%try2-descent recursive functions
descend(X,Y) :- child(X,Y).

descend(X,Y) :- child(X,Z),
                 descend(Z,Y).

%Successor
/*
0 is a numeral.
If X is a numeral, then so is succ(X) .
*/
numeral(0).
numeral(succ(X)) :- 
    numeral(X).

%Addition
add(0,Y,Y).
add(succ(X),Y,succ(Z)) :-
        add(X,Y,Z).


%RecursaoEnd

answer([1 2 3 4 5 6 7 8 9 10 11 12 13 0 14 15], L).