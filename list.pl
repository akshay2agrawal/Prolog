date(date(_,_,_)).

year(date(_,_,Y),Y).
month(date(_,M,_),M).
day(date(D,_,_),D).

% data Tree where
%   Leaf :: Int -> Tree
%   Branch :: Tree -> Tree -> Tree

tree(leaf(_)).
tree(branch(TL,TR)) :- tree(TL), tree(TR).

list([]).
list([_|Xs]) :- list(Xs).

memb(E,[E|_]).
memb(E,[_|Xs]) :- memb(E,Xs).

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
sorted([X1,X2|Xs]) :- X1=< X2, sorted([X2|Xs]).

% solve the problem
%% sort(Xs,Ys) :- perm(Xs,Ys), % generate possible solutions
%%                sorted(Ys).  % test solution on correctness
 %% tree(branch(leaf(10), leaf(20)))


%% lookup(K, KVs, V) is fulfilled if the tuple (K, V) is included in the list KVs
lookup(K, [(K, V)| _ ], V). 
lookup(K, [ _ | Xs ], V) :- lookup(K, Xs, V).


%% member2(E, L) is fulfilled if E is included at least twice in the list L

%% member2(X, Xs) :- append(_, [X|Ys], Xs), append(_, [X|_], Ys).

%% app([]    ,Ys,Ys).
%% app([X|Xs],Ys,[X|Zs]) :- app(Xs,Ys,Zs

member2(X, Xs) :- append(_, [X|Ys], Xs), append(_, [X|_], Ys).
  

%% reverse(Xs, Ys) is fulfilled if the inversion of list Xs corresponds to list Ys. 
%% Implement both the naive and the efficient variant (accumulator technique using an 
%% additional argument).

reverse([], []). 
reverse([X|Xs], Ys) :- reverse(Xs, Zs), app(Zs, [X], Ys).

reverse1(X, Y) :- reverseAcc(X, [], Y).

reverseAcc([], Ys, Ys).
reverseAcc([X|Xs], Ys, Zs) :- reverseAcc(Xs, [X|Ys], Zs).

%% sublist(Xs, Ys) is fulfilled if Xs occurs as a sublist in Ys
sublist1(Xs, Ys) :- app(Zs, _ , Ys), app(_, Xs, Ys).

