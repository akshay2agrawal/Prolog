
date(date(_,_,_)).

year(date(_,_,Y),Y).
month(date(_,M,_),M).
day(date(D,_,_),D).

% data Tree where
%   Leaf :: Int -> Tree
%   Branch :: Tree -> Tree -> Tree

tree(leaf(_)).
tree(branch(TL,TR)) :- tree(TL),tree(TR).

list([]).
list([_|Xs]) :- list(Xs).

memb(E,[E|_]).
memb(E,[_|Xs]) :- memb(E,Xs).

lookup(K, [[K,V]|_], V).
lookup(K, [_|KVs], V) :- lookup(K, KVs , V).


% (++) :: [a] -> [a] -> [a]
% []     ++ ys = ys
% (x:xs) ++ ys = x : (xs ++ ys)
% app([a],[a],[a])
% the result of a function gets an additional argument
% (usually in the end).

app([]    ,Ys,Ys).
app([X|Xs],Ys,[X|Zs]) :- app(Xs,Ys,Zs).

prefix(Xs,Ys) :- app(Xs,_,Ys).

suffix(Xs,Ys) :- app(_,Xs,Ys).

sublist(Xs,Ys) :-  prefix(Zs,Ys), suffix(Xs,Zs).

mem(E,Xs) :- sublist([E],Xs).

isPeano(o).
isPeano(s(N)) :- isPeano(N).

add(o   ,M,M).
add(s(N),M,s(R)) :- add(N,M,R).

%add1(N,o,M).
%add1(N,s(M),s(R)) :- add1(N,M,R).

sub(N,M,R) :- add(M,R,N).

leq(o,_).
leq(s(N),s(M)) :- leq(N,M).

len([],o).
len([_|Xs],s(R)) :- len(Xs,R).

% programmin pattern: generate and test

% generator
perm([],[]).
perm([X|Xs],Ys) :- perm(Xs,Zs), insert(X,Zs,Ys).

insert(X,Ys    ,[X|Ys]).
insert(X,[Y|Ys],[Y|Zs]) :- insert(X,Ys,Zs). 

% test
sorted([]).
sorted([_]).
%sorted([X1,X2|Xs]) :- leq(X1,X2), sorted([X2|Xs]).
sorted([X1,X2|Xs]) :- X1 =< X2, sorted([X2|Xs]).

% solve the problem
sort(Xs,Ys) :- perm(Xs,Ys), % generate possible solutions
               sorted(Ys).  % test solution on correctness

%nodup([]).
%nodup([X|Xs]) :- nodup(Xs), \+ memb(X,Xs).

%neq(X,Y) :- \+ X=Y.


remove(_, [], []).
remove(X, [X|Xs], Ys) :- remove(X, Xs, Ys).
remove(X, [X1|Xs], [X1|Ys]) :- remove(X, Xs, Ys).

nub([], []).
nub([X|Xs], [X|Ys]) :- remove(X, Xs, Zs), nub(Zs, Ys).

