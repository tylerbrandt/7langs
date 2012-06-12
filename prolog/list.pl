% reverse

rev([],[]).                                   
rev([Head|Tail],List) :- rev(Tail,L1), append(L1,[Head],List).

% min

% minimum of a single element list is the head
min([Head|[]],Head).
% 2 cases: head is min, or min in tail
min([Head|Tail],Head) :- min(Tail,TailMin), Head =< TailMin.
min([Head|Tail],TailMin) :- min(Tail,TailMin), TailMin < Head.

% sorted
% from http://kti.mff.cuni.cz/~bartak/prolog/sorting.html

sorted(List,Sorted) :- insert_sort(List,[],Sorted).

% once the input list is empty return accumulator
insert_sort([],Accumulator,Accumulator).
insert_sort([Head|Tail],Accumulator,Sorted) :-
	insert(Head,Accumulator,NewAccumulator), % insert head into accumulator in appropriate position
	insert_sort(Tail,NewAccumulator,Sorted). % sort tail

% insert X in correct position
insert(X,[Y|Tail],[Y|NewTail]) :- X > Y, insert(X,Tail,NewTail).
insert(X,[Y|Tail],[X,Y|Tail]) :- X =< Y.
insert(X,[],[X]).