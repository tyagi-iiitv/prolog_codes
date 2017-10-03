:- dynamic visited/2.

room(3, 3). 
booths(1). 
dimension(1, 1, 1). 
position(1, 0, 0). 
target(1, 2, 2). 

append([],X,X).
append([X|Y],Z,[X|W]) :- append(Y,Z,W).

% Move left
move(B, CURX, CURY, NEWX, NEWY, XLOW, YLOW, XHIGH, YHIGH) :-
	NEWX is CURX-1,
	NEWY is CURY, 
	NEWX >= XLOW,
	NEWY >= YLOW,
	\+ visited(B,NEWX-NEWY),
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
	\+ visited(B,NEWX-NEWY),
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
	\+ visited(B,NEWX-NEWY),
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
	\+ visited(B,NEWX-NEWY),
	dimension(B,X,Y),
	TEMPX is NEWX + X,
	TEMPY is NEWY + Y,
	TEMPX =< XHIGH,
	TEMPY =< YHIGH.
%	notoccupied(NEWX, NEWY).

movetotarget(B, [H|L], CURX, CURY, CURX, CURY, XLOW, YLOW, XHIGH, YHIGH, 0).
movetotarget(B, [H|L], CURX, CURY, TGTX, TGTY, XLOW, YLOW, XHIGH, YHIGH, STEPS) :-
	assert(visited(B, CURX-CURY)),
	findall(NEWX-NEWY,move(B, CURX, CURY, NEWX, NEWY, XLOW, YLOW, XHIGH, YHIGH),L),
	assert(visited(B,NEWX, NEWY)),
	movetotarget(B, NEWX, NEWY, TGTX, TGTY, XLOW, YLOW, XHIGH, YHIGH, S1),
	STEPS is S1+1.
	