%! create(+DimTuple)
%
% The create/1 predicate succeeds if the DimTuple contains valid chessboard
% dimensions (0-indexed, 8x8 board), e.g., (0,0) or (7,7).
% Arguments:
%   DimTuple: A tuple `(DimX, DimY)` representing the X and Y coordinates.
% Returns: True if both DimX and DimY are valid board dimensions (0 to 7),
%          otherwise false. The predicate is deterministic.
create((DimX, DimY)) :-
    in_board(DimX),
    in_board(DimY),
    !.

%! attack(+FromTuple, +ToTuple)
%
% The attack/2 predicate succeeds if a queen positioned on ToTuple is
% vulnerable to an attack by another queen positioned on FromTuple.
% A queen attacks horizontally, vertically, or diagonally.
% This predicate is deterministic and finds only the first applicable attack condition.
% Arguments:
%   FromTuple: A tuple `(FromX, FromY)` representing the queen's starting position.
%   ToTuple: A tuple `(ToX, ToY)` representing the queen's target position.
% Returns: True if the queen at FromTuple can attack the queen at ToTuple,
%          otherwise false.
attack((FromX, _), (ToX, _)) :-
    FromX =:= ToX,
    !.

attack((_, FromY), (_, ToY)) :-
    FromY =:= ToY,
    !.

attack((FromX, FromY), (ToX, ToY)) :-
    abs(FromX - ToX) =:= abs(FromY - ToY),
    !.

%! in_board(+Dim)
%
% The in_board/1 predicate succeeds if a given dimension (coordinate)
% is within the valid range for a standard 8x8 chessboard.
% Arguments:
%   Dim: An integer representing a single dimension (X or Y coordinate).
% Returns: True if Dim is between 0 (inclusive) and 8 (exclusive),
%          otherwise false. This means valid values are 0, 1, ..., 7.
in_board(Dim) :-
	between(0, 7, Dim).