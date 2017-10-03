:- import bagCount/2 from aggregs.

vessels(4).
source(1).
people(3). 
capacity(1, 12). 
capacity(2, 4). 
capacity(3, 3). 
capacity(4, 1). 
horizon(10).   


subsetsum(SET, SUM, ANSWER) :-
    % Find a subset
    subset(SET, ANSWER),
    % Check elements of the subset add up to SUM
    sum(ANSWER, SUM).

% sum(LIST, SUM) - sums all numbers in the list
sum([], 0).
sum([X | T], SUM) :-
    sum(T, TAILSUM),
    SUM is TAILSUM + X.

% subset - finds subsets
subset([], []).
subset([E|Tail], [E|NTail]) :-
    subset(Tail, NTail).
subset([_|Tail], NTail) :-
    subset(Tail, NTail).

## Pending is how to pass the variables into the split function and
## How to count the number of solutions to subsetsum
## How to create a list of capacities other than the source	
