people(2). 
locations(4). 
preferences(4).  
order(1, 1, 2). 
order(1, 2, 4). 
order(2, 1, 3). 
order(2, 3, 4). 


delete([X|Ys], X, Ys).
delete([Y|Ys], X, [Y|Zs]) :-
	delete(Ys, X, Zs).


permute([],[]).
permute([X|Xs], Ys) :-
	permute(Xs, Zs),
	delete(Ys, X, Zs).


indexOf([Element|_], Element, 0). % We found the element
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1), % Check in the tail of the list
  Index is Index1+1.  % and increment the resulting index


generatelist(0, L1, L1).
generatelist(Range, L1, L) :-  
	R is Range-1,
	generatelist(R, [Range|L1], L).

listdiff([],L,0).
listdiff(L,[],0).
listdiff([],[],0).
listdiff([H1|L1], [H2|L2], D) :-
	listdiff(L1, L2, D1),
	(H1 =:= H2 -> D is D1; D is D1+1).

% L1 is the permuted list of all sources, L2 and L3 are the demanded list of people
getalldif(L1,L2,L3,D) :-
	permute(L1, LPER),
	listdiff(LPER, L2).

getdiff(L, D) :-
	permute(L, L1),
	% sum_all_the_outputs_from_getdiffallorders

getdiffallorders(D,L) :-
	order(X,Y,Z),
	indexOf(L, Y, I1),
	indexOf(L, Z, I2),
	(I1 < I2 -> D is 0; D is 1).

% Generate a list of all outputs from getdiff and print the minimum difference.