candidate(potter).
candidate(malfoy).
candidate(weasley).
candidate(granger).

playing(C) :- candidate(C).

board(C, T, S) :- candidate(C), 
                    candidate(T), 
                    candidate(S),
                    potterAndMalfoy(board(C,T,S)),
                    malfoyAndGranger(board(C,T,S)),
                    weasleyAndPotter(board(C,T,S)),
                    potterAndGranger(board(C,T,S)),
                    grangerAndWeasley(board(C,T,S)),
                    playing(C) \= playing(T), 
                    playing(C) \= playing(S),
                    playing(T) \= playing(S).


member(P, board(P,_,_)).
member(P, board(_,P,_)).
member(P, board(_,_,P)).

notMember(P, board(C, T, S)) :- P \= C, P \= T, P \= S.


%% 1- *Potter* and *Malfoy* do not want to join the board together.
potterAndMalfoy(board(C, T, S)) :- member(potter, board(C,T,S)), notMember(malfoy, board(C,T,S)).
potterAndMalfoy(board(C, T, S)) :- member(malfoy, board(C,T,S)), notMember(potter, board(C,T,S)).
potterAndMalfoy(board(C, T, S)) :- notMember(malfoy, board(C,T,S)), notMember(potter, board(C,T,S)).


%% 2-*Malfoy* is only available for the board if *Granger* becomes chairperson.
malfoyAndGranger(board(granger, T, S)) :- member(malfoy, board(granger, T, S)).
malfoyAndGranger(board(C, T, S)) :- notMember(malfoy, board(C, T, S)).

%% 3- *Weasley* will only join the board if *Potter* also belongs to it.
weasleyAndPotter(board(C,T,S)) :- member(potter, board(C,T,S)), member(weasley, board(C,T,S)) .
weasleyAndPotter(board(C,T,S)) :- notMember(weasley, board(C,T,S)) .

%% 4- *Potter* does not want to join the board if *Granger* becomes the secretary.
potterAndGranger(board(C,T,granger)) :- notMember(potter, board(C,T,granger)).
potterAndGranger(board(_,_,S)) :- granger \= S.

%% 5- *Granger* does not join the board if *Weasley* becomes chairperson.
grangerAndWeasley(board(weasley,T,S)) :- notMember(granger, board(weasley,T,S)).
grangerAndWeasley(board(C,_,_)) :- weasley \= C.
