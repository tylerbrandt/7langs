instrument(jagger, guitar).
instrument(armstrong, trumpet).
instrument(dylan, guitar).
instrument(grohl, drums).

genre(jagger, rock).
genre(armstrong, jazz).
genre(dylan, folk).
genre(grohl, rock).

guitar_players(M) :- instrument(M, guitar).
rock_instruments(I) :- instrument(M, I), genre(M, rock).