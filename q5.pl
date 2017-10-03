people(2). 
locations(3). 
preferences(4). 
location(1, 1, 9, 11). 
location(2, 1, 9, 11). 
location(3, 1, 9, 11). 
prefer(1, 1). 
prefer(2, 1). 
prefer(2, 2). 
prefer(2, 3). 


permute([],[]).
permute([X|Xs], Ys) :-
	permute(Xs, Zs),
	delete(Ys, X, Zs),
	verify(Ys,0).

verify([], TIME).
verify([H|L], TIME) :-
	location(H,D,O,C),
	(TIME > O -> TSTART is TIME; TSTART is O),
	TEND is TSTART + D,
	(TEND =< C -> verify(L, TEND)).
	
subset([], []).
subset([E|Tail], [E|NTail]) :-
    subset(Tail, NTail).
subset([_|Tail], NTail) :-
    subset(Tail, NTail).

% This method gives you all possible places you can visit with the given contraints. Now this question is same as question 4.
solutions(L, X) :-
	subset(L,X),
	verify(X, 0).