
list([]).
list([_|Xs]) :- list(Xs).

app([],B,B).
app([X|A],B,[X|C]) :- app(A,B,C).

memb(X,[X|_]).
memb(X,[_|Xs]) :- memb(X,Xs).

ispeano(o).
ispeano(s(N)) :- ispeano(N).

add(o,B, B).
add(s(A),B,s(C)) :- add(A,B,C).

insert( X , L , [X|L]).
insert(X , [L|Ls] , [L|X]) :- insert(X, Ls ,X).

insert1(X , Ls , Rs) :- app([X],Ls,Rs).
% Board game 

candidate(potter).
candidate(weasley).
candidate(malfoy).
candidate(granger).

distinctcand(board(A,B,C)) :- candidate(A), candidate(B), candidate(C), A\=B, B\=C, C\=A.

member(P, board(P,_,_)).
member(P, board(_,P,_)).
member(P, board(_,_,P)).

notMember(P, board(C,T,S)) :- P \= C, P\=T, P\=S.

potterAndMalfoy(board(C,T,S)) :- member(potter, board(C,T,S)), notMember(malfoy, board(C,T,S)).
potterAndMalfoy(board(C,T,S)) :- member(malfoy, board(C,T,S)), notMember(potter, board(C,T,S)).
potterAndMalfoy(board(C,T,S)) :- notMember(malfoy, board(C,T,S)), notMember(potter, board(C,T,S)).

malfoyAndGranger(board(granger,T,S)) :- member(malfoy, board(granger,T,S)).
malfoyAndGranger(board(C,T,S)) :- notMember(malfoy, board(C,T,S)).

weasleyAndPotter(board(C,T,S)) :- member(potter, board(C,T,S)), member(weasley, board(C,T,S)).
weasleyAndPotter(board(C,T,S)) :- notMember(weasley, board(C,T,S)).

potterAndGranger(board(C,T,granger)) :- notMember(potter,board(C,T,granger)).
potterAndGranger(board(_,_,S)) :- S\=granger.

grangerAndWeasley(board(weasley,T,S)) :- notMember(granger,board(weasley,T,S)).
grangerAndWeasley(board(C,_,_)) :- C\=weasley.


game(B) :- distinctcand(B),
			potterAndMalfoy(B),
			malfoyAndGranger(B),
			weasleyAndPotter(B),
			potterAndGranger(B),
			grangerAndWeasley(B).

% rider problem 
mult1(X,Y,Res) :- mult1(X,Y,o,Res).

mult(_, o , Z, Z).
mult(X, s(Y) , Z , Res) :- add(X, Z, T), mult(X, Y, T, Res).

rider(H,R,Head,Legs) :- add(H,R,Head),
						mult(H, s(s(s(s(o)))),o ,X),
						mult(R, s(s(o)), o, Y),
						add(X, Y, Legs).

delelem(_, [], []).
delelem(E , [E|Ls], Ls).
delelem(E , [L|Ls], [L|Rs]) :- delelem(E, Ls, Rs).


delelemm(E , [E|Ls], Ls).
delelemm(E , [L|Ls], Rs) :-  app([L],Rs1, Rs), delelemm(E, Ls, Rs1) .


maxList([H|[]] , H).
maxList( [X|Ps] , Max) :- maxList(Ps, Max1), max(X,Max1,Max). 

max(o , s(Y), s(Y)).
max(s(X), o, s(X)).
max(s(X), s(Y), s(Max)) :- max(X , Y , Max). 

min(o , s(Y), o).
min(s(X), o, o).
min(s(X), s(Y), s(Min)) :- min(X , Y , Min). 

drop(o, Ys, Ys).
drop(s(P) , [_|Xs] , Ys) :- drop(P, Xs, Ys).

take(o, _, []).
take(s(P),[X|Xs],[X|Ys]) :- take(P, Xs,Ys).

delete(L1,E,L2) :-app(Xs, [E|Ys], L1),
					app(Xs, Ys, L2).


gt(s(_),o).
gt(s(N),s(M)) :- gt(N,M). 


fromTo(N , N , [N]).
fromTo(N, M, [N|Xs]) :- gt(N,M), fromTo(s(N),M,Xs).
fromTo(_, _ , []).


multiply(o, _, o).
multiply(s(X), Y, Res) :- multiply( X , Y, Res1), add(Y, Res1, Res).


nodeup([X,Xs]) :- app(X , [X|_], Xs), nodeup(Xs).	