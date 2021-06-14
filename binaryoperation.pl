
and(true, true, true).
and(false, false, false).
and(true, false, false).
and(false, true, false).

not(true, false).
not(false, true).

or(true, _, true).
or(false, true, true).

%% (X AND Y) OR Z
ex1(X, Y, Z, Res) :- and(X, Y, A), or(A, Z, Res).

%% (X AND Y) OR ((Y AND Z) AND Z) 
ex2(X, Y, Z, Res) :- and(X, Y, A), 
                    or(Y, Z, B), 
                    and(B, Z, C),
                    or(A,C, Res).

%% (x AND (NOT y) AND z) OR ((z AND y) OR z)
ex3(X, Y, Z, Res) :- not(Y, A), 
                  and(X, A, B),
                  and(B, Z, C),
                  and(Z, Y, D),
                  or(D, Z, E),
                  or(E, C, Res).