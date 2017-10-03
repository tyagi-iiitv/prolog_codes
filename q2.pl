dishes(3). 
separation(1). 
hot(1). 
table_width(4).  
dish_width(1, 1). 
dish_width(2, 1). 
dish_width(3, 2). 
demand(1, 1). 
demand(2, 1). 
demand(3, 1). 


% Collect all the widths in a list
% findall(W, dish_width(_,W), WIDTHLIST).

% Collect all the demands in a list
% findall(D, demand(_,D), DEMANDLIST).

listproduct([],[],0).

listproduct([H1|L1], [H2|L2], SUM) :- 
	listproduct(L1, L2, TAILSUM), 
	SUM is H1*H2 + TAILSUM.

## How to use findall command in the script to store the variables and use them in listproduct.




