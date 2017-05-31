%This is for reading arduino

:-dynamic currentvalue/1.


start:-
        process_create(path(cat),['/dev/ttyACM0'],[stdout(pipe(Out))]),
            read_lines(Out,Lines),
        close(Out).

read_lines(Out, Lines) :-
        read_line_to_codes(Out, Line1),
        read_lines(Line1, Out, Lines).

read_lines(end_of_file, _, []) :- !.
read_lines(Codes, Out, [Line|Lines]) :-
        atom_codes(Line, Codes),
        catch(save_term(Line),E,print_message(error,E)),
        %writeln(Line),
        read_line_to_codes(Out, Line2),
        read_lines(Line2, Out, Lines).

save_term(Line):-
	term_to_atom(Term,Line),
	with_mutex(synch, (retractall(currentvalue(_)),
			   assertz(currentvalue(Term)))).



begin(Id):-thread_create(start, Id, [alias(serial_mon)]).

get_value(X):-
        with_mutex(synch, currentvalue(X)).


stop(Status) :- thread_signal(serial_mon, abort),
        thread_join(serial_mon, Status).
