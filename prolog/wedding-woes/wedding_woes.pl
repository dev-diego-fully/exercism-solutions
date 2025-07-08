% Predicate: chatty/1
% Description: Declares individuals who are considered "chatty".
% Arguments:
%   Person: An atom representing a person's name.
% Returns: True if the given Person is listed as chatty.
chatty(gustavo).
chatty(valeria).

% Predicate: likes/2
% Description: Declares mutual or one-way liking between two individuals.
% Arguments:
%   Person1: An atom representing the first person.
%   Person2: An atom representing the second person.
% Returns: True if Person1 likes Person2.
likes(esteban, malena).
likes(malena, esteban).
likes(gustavo, valeria).

% Predicate: pairing/2
% Description: Defines a "pairing" relationship between two individuals (A and B).
%              A pairing is established if:
%              1. A and B mutually like each other.
%              OR
%              2. At least one of them (A or B) is considered "chatty".
%              This predicate is deterministic and finds only the first valid pairing option.
% Arguments:
%   A: An atom representing the first individual.
%   B: An atom representing the second individual.
% Returns: True if A and B form a valid pairing based on the defined rules.
pairing(A, B) :-
    likes(A, B),
    likes(B, A),
    !.

pairing(A, B) :-
    (chatty(A); chatty(B)),
    !.

% Predicate: seating/5
% Description: Determines a valid circular seating arrangement for five individuals
%              (A, B, C, D, E) such that each adjacent pair forms a valid "pairing".
%              The arrangement is circular, meaning E must also pair with A.
%              This predicate is deterministic and finds only the first valid seating arrangement.
% Arguments:
%   A, B, C, D, E: Atoms representing the five individuals in sequential seating order.
% Returns: True if the given individuals can be seated in a valid circular pairing.
seating(A, B, C, D, E) :-
    pairing(A, B),
    pairing(B, C),
    pairing(C, D),
    pairing(D, E),
    pairing(E, A),
    !.