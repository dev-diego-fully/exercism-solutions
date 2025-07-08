% Predicate: is_div/2
% Description: Checks if a number N is divisible by a divisor D.
%              This predicate explicitly handles the case where the divisor D is zero,
%              causing the predicate to fail safely instead of raising an error.
% Arguments:
%   N: The number to be divided (integer).
%   D: The divisor (integer).
% Returns: True if N is perfectly divisible by D; fails if D is zero or if N is not divisible by D.
is_div(N, D) :-
    D =\= 0,
    N mod D =:= 0.

% Predicate: leap/1
% Description: Determines if a given Year is a leap year according to common rules.
%              A year is a leap year if it is divisible by 4,
%              UNLESS it is divisible by 100 but NOT by 400.
% Arguments:
%   Year: The year to be checked (integer).
% Returns: True if the Year is a leap year, otherwise false.
leap(Year) :-
    is_div(Year, 4),
    \+ is_div(Year, 100),
    !.

leap(Year) :-
    is_div(Year, 400).