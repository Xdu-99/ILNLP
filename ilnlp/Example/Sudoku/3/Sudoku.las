


has_number(R, C) :- cell(R, C, _).
 :- row(R), col(C), not has_number(R, C).
 :- cell(R, C1, N), cell(R, C2, N), C1 != C2.
 :- cell(R1, C, N), cell(R2, C, N), R1 != R2.
 :- cell(R1, C1, N), cell(R2, C2, N), R1 != R2, block(B, R1, C1), block(B, R2, C2), num(N).
#pos({num(1),num(2),num(3),col(1),col(2),col(3),row(1),row(2),row(3),block(1, 1, 1),block(1, 1, 2),block(1, 1, 3),block(2, 2, 1),block(2, 2, 2),block(2, 2, 3),block(3, 3, 1),block(3, 3, 2),block(3, 3, 3),cell(1, 1, 1),cell(1, 2, 2),cell(2, 2, 3),cell(2, 3, 1),cell(3, 1, 3),cell(3, 3, 2),has_number(1, 1),has_number(1, 2),has_number(2, 2),has_number(2, 3),has_number(3, 1),has_number(3, 3),no_cell(2, 1, 1),no_cell(3, 1, 1),no_cell(1, 2, 1),no_cell(2, 2, 1),cell(3, 2, 1),no_cell(1, 3, 1),no_cell(3, 3, 1),no_cell(1, 1, 2),cell(2, 1, 2),no_cell(3, 1, 2),no_cell(2, 2, 2),no_cell(3, 2, 2),no_cell(1, 3, 2),no_cell(2, 3, 2),no_cell(1, 1, 3),no_cell(2, 1, 3),no_cell(1, 2, 3),no_cell(3, 2, 3),cell(1, 3, 3),no_cell(2, 3, 3),no_cell(3, 3, 3),has_number(2, 1),has_number(3, 2),has_number(1, 3)  },{   },{ num(1). num(2). num(3). col(1). col(2). col(3). row(1). row(2). row(3). block(1, 1, 1). block(1, 1, 2). block(1, 1, 3). block(2, 2, 1). block(2, 2, 2). block(2, 2, 3). block(3, 3, 1). block(3, 3, 2). block(3, 3, 3). cell(1, 1, 1). cell(1, 2, 2). cell(2, 2, 3). cell(2, 3, 1). cell(3, 1, 3). cell(3, 3, 2).  }).#modeh(1, cell(var(row),var(col),var(num))).
#modeh(1, no_cell(var(row),var(col),var(num))).
#modeb( cell(var(row),var(col),var(num))).
#modeb( no_cell(var(row),var(col),var(num))).
#modeb( row(var(row)),(positive)).
#modeb( col(var(col)),(positive)).
#modeb( num(var(num)),(positive)).
#modeb( block(var(bloc), var(row), var(col)), (positive)).
#modeb( var(row) != var(row), (positive)).
#modeb( var(col) != var(col), (positive)).
#modeh( has_number(var(row), var(col))).
#modeb( has_number(var(row), var(col))).

