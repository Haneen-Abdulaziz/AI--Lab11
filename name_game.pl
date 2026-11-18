% ============================================================
%  ARTI 401 - Lab 11: I/O and Database
%  Lab Activity: The "Name Game"
% ============================================================

:- dynamic letter/1.

% The starting set of letters
letter(a).
letter(b).
letter(c).

start :-
    write('Hi. This is the "Name Game".'), nl,
    write('You will be given a set of English letters in which you will add, delete or move to create your name.'), nl,
    menu.

menu :-
    nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice....'), nl,
    read(Choice),
    option(Choice).

% 1- Display the current set of letters
option(1) :- !,
    display_letters,
    menu.

% 2- Add a letter (assert adds it to the database)
option(2) :- !,
    write('Enter the letter you want to add: '), nl,
    read(X),
    assert(letter(X)),
    write('The letter has been added.'), nl,
    menu.

% 3- Add a letter at the top (asserta puts it first)
option(3) :- !,
    write('Enter the letter you want to add at the top: '), nl,
    read(X),
    asserta(letter(X)),
    write('The letter has been added at the top.'), nl,
    menu.

% 4- Add a letter at the bottom (assertz puts it last)
option(4) :- !,
    write('Enter the letter you want to add at the bottom: '), nl,
    read(X),
    assertz(letter(X)),
    write('The letter has been added at the bottom.'), nl,
    menu.

% 5- Delete a letter (retract removes the first match)
option(5) :- !,
    write('Enter the letter you want to delete: '), nl,
    read(X),
    (   retract(letter(X))
    ->  write('The letter has been deleted.'), nl
    ;   write('This letter is not in the set.'), nl
    ),
    menu.

% 6- Delete all letters
option(6) :- !,
    retractall(letter(_)),
    write('All letters have been deleted.'), nl,
    menu.

% 7- Exit
option(7) :- !,
    write('Goodbye!'), nl.

% Any other input
option(_) :-
    write('Invalid choice, please try again.'), nl,
    menu.

% Prints the letters in their current order, on one line.
display_letters :-
    findall(X, letter(X), Letters),
    (   Letters == []
    ->  write('The set is empty.'), nl
    ;   write('Current set of letters: '),
        print_letters(Letters), nl
    ).

print_letters([]).
print_letters([H|T]) :-
    write(H), write(' '),
    print_letters(T).
