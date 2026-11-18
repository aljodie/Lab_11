
:- dynamic letter/1.

letter(a).
letter(b).
letter(c).

start :-
    nl,
    write('Hi. This is the "Name Game"'), nl,
    write('You will be given a set of English letters in which you will add, delete or move to create your name.'), nl,
    menu.

% Display the menu and process the user's choice
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
    write('Enter your choice: '),
    read(Choice),
    process_choice(Choice).

% Menu options
process_choice(1) :-
    display_letters,
    menu.

process_choice(2) :-
    write('Enter a letter (a, b, or c): '),
    read(Letter),
    valid_letter(Letter),
    assertz(letter(Letter)),
    write('Letter added.'), nl,
    menu.

process_choice(3) :-
    write('Enter a letter (a, b, or c): '),
    read(Letter),
    valid_letter(Letter),
    asserta(letter(Letter)),
    write('Letter added at the top.'), nl,
    menu.

process_choice(4) :-
    write('Enter a letter (a, b, or c): '),
    read(Letter),
    valid_letter(Letter),
    assertz(letter(Letter)),
    write('Letter added at the bottom.'), nl,
    menu.

process_choice(5) :-
    write('Enter the letter to delete (a, b, or c): '),
    read(Letter),
    (   valid_letter(Letter)
    ->  (   retract(letter(Letter))
        ->  write('Letter deleted.'), nl
        ;   write('That letter is not in the current set.'), nl
        )
    ;   true
    ),
    menu.

process_choice(6) :-
    retractall(letter(_)),
    write('All letters have been deleted.'), nl,
    menu.

process_choice(7) :-
    write('Goodbye!'), nl.

process_choice(_) :-
    write('Invalid choice. Please enter a number from 1 to 7.'), nl,
    menu.

% Check that the entered letter is one of the allowed letters
valid_letter(Letter) :-
    member(Letter, [a, b, c]),
    !.
valid_letter(_) :-
    write('Invalid letter. Please enter a, b, or c.'), nl,
    fail.

% Display the current letters in their database order
display_letters :-
    findall(Letter, letter(Letter), Letters),
    (   Letters = []
    ->  write('The set is empty.'), nl
    ;   write('Current set of letters: '),
        write(Letters), nl
    ).
