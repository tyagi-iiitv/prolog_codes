:- dynamic visited/3.
:- dynamic count/4.

bet(N, M, K) :- N =< M, K = N.
bet(N, M, K) :- N < M, N1 is N+1, bet(N1, M, K).

append([],X,X).
append([X|Y],Z,[X|W]) :- append(Y,Z,W).	

member(X, [Y|T]) :- X = Y; member(X, T).

room(3, 3). 
booths(1). 
dimension(1, 1, 1). 
position(1, 0, 0). 
target(1, 2, 2). 


% Move left
move(B, CURX, CURY, NEWX, NEWY, XLOW, YLOW, XHIGH, YHIGH) :-
	NEWX is CURX-1,
	NEWY is CURY, 
	NEWX >= XLOW,
	NEWY >= YLOW,
	\+ visited(B,NEWX, NEWY),
	dimension(B,X,Y),
	TEMPX is NEWX + X,
	TEMPY is NEWY + Y,
	TEMPX =< XHIGH,
	TEMPY =< YHIGH.
%	notoccupied(NEWX, NEWY).


% Move right
move(B, CURX, CURY, NEWX, NEWY, XLOW, YLOW, XHIGH, YHIGH) :-
	NEWX is CURX+1,
	NEWY is CURY, 
	NEWX >= XLOW,
	NEWY >= YLOW,
	\+ visited(B,NEWX, NEWY),
	dimension(B,X,Y),
	TEMPX is NEWX + X,
	TEMPY is NEWY + Y,
	TEMPX =< XHIGH,
	TEMPY =< YHIGH.
%	notoccupied(NEWX, NEWY).

% Move up
move(B, CURX, CURY, NEWX, NEWY, XLOW, YLOW, XHIGH, YHIGH) :-
	NEWX is CURX,
	NEWY is CURY+1, 
	NEWX >= XLOW,
	NEWY >= YLOW,
	\+ visited(B,NEWX, NEWY),
	dimension(B,X,Y),
	TEMPX is NEWX + X,
	TEMPY is NEWY + Y,
	TEMPX =< XHIGH,
	TEMPY =< YHIGH.
%	notoccupied(NEWX, NEWY).

% Move down
move(B, CURX, CURY, NEWX, NEWY, XLOW, YLOW, XHIGH, YHIGH) :-
	NEWX is CURX,
	NEWY is CURY-1, 
	NEWX >= XLOW,
	NEWY >= YLOW,
	\+ visited(B,NEWX, NEWY),
	dimension(B,X,Y),
	TEMPX is NEWX + X,
	TEMPY is NEWY + Y,
	TEMPX =< XHIGH,
	TEMPY =< YHIGH.
%	notoccupied(NEWX, NEWY).

findadjacent(B,CURX,CURY, XLOW, YLOW, XHIGH, YHIGH,X,Y) :-
	X1 is CURX-1,
	X2 is CURX+1,
	Y1 is CURY-1,
	Y2 is CURY+1,
	bet(X1, X2, X),
	bet(Y1, Y2, Y),
	X =< XHIGH,
	X >= XLOW,
	Y =< YHIGH, 
	Y >= YLOW,
	\+ visited(B,X,Y).

getxy(X,Y,[X,Y|L]).

setcount(B, [], COUNT).	
setcount(B, [H|L], COUNT) :-
	getxy(X,Y,H),
	(\+ count(B,X,Y,K) ->
		asserta(count(B,X,Y,COUNT)),setcount(B,L,COUNT);
		setcount(B,L,COUNT)).

%notoccupied(X,Y):

%movetotarget(B, T, CURX, CURY, CURX, CURY, XLOW, YLOW, XHIGH, YHIGH, 0).
movetotarget(B, T, CURX, CURY, TGTX, TGTY, XLOW, YLOW, XHIGH, YHIGH) :-
	asserta(visited(B, CURX, CURY)),
	findall([NEWX,NEWY],move(B, CURX, CURY, NEWX, NEWY, XLOW, YLOW, XHIGH, YHIGH),L),
%	findadjacent(B,CURX, CURY, XLOW, YLOW, XHIGH, YHIGH, NEWX, NEWY),
	append(T,L,[H1|L1]),
	count(B, CURX, CURY, TEMP),
	CURCOUNT is TEMP + 1,
	setcount(B,[H1|L1], CURCOUNT), 
	getxy(NEWX,NEWY,H1),
	(\+ member([TGTX,TGTY], [H1|L1]) -> 
		movetotarget(B, L1, NEWX, NEWY, TGTX, TGTY, XLOW, YLOW, XHIGH, YHIGH);
		true).


run(B, T, CURX, CURY, TGTX, TGTY, XLOW, YLOW, XHIGH, YHIGH, STEPS) :-
	asserta(count(B, CURX, CURY, 0)),
	movetotarget(B, T, CURX, CURY, TGTX, TGTY, XLOW, YLOW, XHIGH, YHIGH),
	count(B, TGTX, TGTY, STEPS).