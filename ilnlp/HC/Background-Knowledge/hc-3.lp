       :- in(U,V),in(U,W),V != W.
       :- in(V,U),in(W,U),V != W.
       %reach(X):-edge(U,X),in(U,X), reach(U).
       %reach(Y):-in(X,Y),initial(X).
       %:- node(X),not reach(X).
       0{in(X,Y)}1:-edge(X,Y). 
       edge(X,Y) :- edge(Y,X).
       initial(1).