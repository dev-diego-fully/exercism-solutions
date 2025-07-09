% Predicate: triangle/4
% Description: Determines the type of a triangle given its three side lengths.
%              It first validates the side lengths to ensure they are positive
%              and obey the triangle inequality theorem.
% Arguments:
%   Side1: The length of the first side (number).
%   Side2: The length of the second side (number).
%   Side3: The length of the third side (number).
%   Type:  An atom representing the triangle's type (e.g., "equilateral", "isosceles", "scalene").
% Returns: True if the sides form a valid triangle of the specified type, otherwise false.
%          The predicate is deterministic, returning only the first matching type.

triangle(Side1, Side2, Side3, _) :-
    (Side1 =< 0; Side2 =< 0; Side3 =< 0),
    !,
    fail.

triangle(Side1, Side2, Side3, _) :-
    (Side1 + Side2 =< Side3; Side1 + Side3 =< Side2; Side2 + Side3 =< Side1),
    !,
    fail.

triangle(Side1, Side2, Side3, "equilateral") :-
    Side1 =:= Side2,
    Side1 =:= Side3,
    !.

triangle(Side1, Side2, Side3, "isosceles") :-
    (Side1 =:= Side2; Side1 =:= Side3; Side2 =:= Side3),
    !.

triangle(Side1, Side2, Side3, "scalene") :-
    Side1 =\= Side2,
    Side1 =\= Side3,
    Side2 =\= Side3,
    !.