mother(susanne,monika).
mother(norbert,monika).
mother(monika,ulrike).
mother(herbert,christine).
mother(andreas,angelika).
mother(angelika,christine).
mother(hubert,maria).

female(susanne).
female(P) :- mother(_,P).

husband(monika,herbert).
husband(angelika,hubert).
husband(christine,heinz).
husband(maria,fritz).

father(C,F) :- mother(C,M), husband(M,F).

grandmother(C,GM) :- mother(C,M), mother(M,GM).
grandmother(C,GM) :- father(C,F), mother(F,GM).

grandfather(C,GF) :- mother(C,X) , father(X,GF).
grandfather(C,GF) :- father(C,X) , father(X,GF).

sibling(P1,P2) :- mother(P1,M), mother(P2,M), P1\=P2.

sister(P,S) :- sibling(P,S), female(S). 
brother(X,B) :- sibling(X,B), male(B).

date(_,_,_).

year(date(_,_,Y),Y).
month(date(_,M,_),M).
day(date(D,_,_),D).

% Excercise
male(norbert).
male(andreas).
male(M) :- husband(_,M).

son(S,P) :- mother(S,P), male(S).
son(S,P) :- father(S,P), male(S).

son1(S,P) :- mother(S,P), male(S); father(S,P), male(S).

cousin(C, P) :- mother(C,M1), mother(P,M2), M1\=M2, sibling(M1,M2) .
cousin(C, P) :- father(C,F1), mother(P,M2), sibling(F1,M2).
cousin(C, P) :- mother(C,M1), father(P,F2), sibling(M1,F2).
cousin(C, P) :- father(C,F1), father(P,F2), F1\=F2, sibling(F1,F2).
% is fulfilled if C is a cousin (male or female) of P.

brother_in_law(B, P) :- husband(X,P), brother(X,B).
%is fulfilled if B is a brother in law of P.

ancestor(A, P) :- mother(P,A).
ancestor(A, P) :- father(P,A).
ancestor(A, P) :- grandmother(P,A).
ancestor(A, P) :- grandfather(P,A).

% is fulfilled if A is an ancestor of P.













