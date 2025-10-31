


 :- row(R), not queen(R, _).
 :- queen(R1, C), queen(R2, C), column(C), R1 != R2.
 :- queen(R, C1), queen(R, C2), row(R), C1 != C2.
 :- row(R1), row(R2), column(C1), column(C2), R1 != R2, queen(R1, C1), queen(R2, C2), R1-R2 = C1-C2.
 :- row(R1), row(R2), column(C1), column(C2), R1 != R2, queen(R1, C1), queen(R2, C2), R1-R2 = C2-C1.
#pos({column(1),column(2),column(3),column(4),row(1),row(2),row(3),row(4),queen(2, 1),queen(4, 2),queen(1, 3),queen(3, 4)  },{ column(5),row(5),queen(3, 1),queen(1, 2),queen(4, 3),queen(2, 4)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#pos({column(1),column(2),column(3),column(4),row(1),row(2),row(3),row(4),queen(3, 1),queen(1, 2),queen(4, 3),queen(2, 4)  },{ column(5),row(5),queen(2, 1),queen(4, 2),queen(1, 3),queen(3, 4)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(1, 3),queen(1, 2)  },{ queen(2, 1),queen(4, 2),queen(3, 1)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(1, 3),queen(2, 4)  },{ queen(2, 1),queen(4, 2),queen(3, 1),queen(1, 2),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(1, 3),queen(3, 1)  },{ queen(2, 1),queen(4, 2),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(1, 3),queen(3, 1)  },{ queen(2, 1),queen(4, 2),queen(2, 4)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(1, 3),queen(3, 1)  },{ queen(2, 1),queen(4, 2),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(1, 3),queen(4, 3)  },{ queen(2, 1),queen(4, 2),queen(3, 1),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(1, 2)  },{ queen(1, 3),queen(3, 1)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(1, 2)  },{ queen(3, 4),queen(3, 1)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(1, 2)  },{ queen(4, 2),queen(3, 1)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(2, 4)  },{ queen(1, 3),queen(3, 1),queen(1, 2),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(2, 4)  },{ queen(3, 4),queen(3, 1),queen(1, 2),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(2, 4)  },{ queen(4, 2),queen(3, 1),queen(1, 2),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(3, 1)  },{ queen(1, 3),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(3, 1)  },{ queen(1, 3),queen(2, 4)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(3, 1)  },{ queen(1, 3),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(3, 1)  },{ queen(3, 4),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(3, 1)  },{ queen(3, 4),queen(2, 4)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(3, 1)  },{ queen(3, 4),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(3, 1)  },{ queen(4, 2),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(3, 1)  },{ queen(4, 2),queen(2, 4)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(3, 1)  },{ queen(4, 2),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(4, 3)  },{ queen(1, 3),queen(3, 1),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(4, 3)  },{ queen(3, 4),queen(3, 1),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(2, 1),queen(4, 3)  },{ queen(4, 2),queen(3, 1),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(3, 4),queen(1, 2)  },{ queen(2, 1),queen(4, 2),queen(1, 3),queen(3, 1)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(3, 4),queen(2, 4)  },{ queen(2, 1),queen(4, 2),queen(1, 3),queen(3, 1),queen(1, 2),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(3, 4),queen(3, 1)  },{ queen(2, 1),queen(4, 2),queen(1, 3),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(3, 4),queen(3, 1)  },{ queen(2, 1),queen(4, 2),queen(1, 3),queen(2, 4)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(3, 4),queen(3, 1)  },{ queen(2, 1),queen(4, 2),queen(1, 3),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(3, 4),queen(4, 3)  },{ queen(2, 1),queen(4, 2),queen(1, 3),queen(3, 1),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(4, 2),queen(1, 2)  },{ queen(2, 1),queen(3, 1)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(4, 2),queen(2, 4)  },{ queen(2, 1),queen(3, 1),queen(1, 2),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(4, 2),queen(3, 1)  },{ queen(2, 1),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(4, 2),queen(3, 1)  },{ queen(2, 1),queen(2, 4)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(4, 2),queen(3, 1)  },{ queen(2, 1),queen(4, 3)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(1),column(2),column(3),column(4),column(5),row(1),row(2),row(3),row(4),row(5),queen(4, 2),queen(4, 3)  },{ queen(2, 1),queen(3, 1),queen(1, 2)  },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({column(5)  },{   },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).
#neg({row(5)  },{   },{ column(1). column(2). column(3). column(4). column(5). row(1). row(2). row(3). row(4). row(5).  }).#modeha(1, queen(var(row),var(col))).
#modeb( queen(var(row), var(col))).
#modeb( var(row) != var(row), (positive)).
#modeb( var(col) != var(col), (positive)).
#modeb( var(row) - var(row) = var(col) - var(col), (positive)).
#modeb( row(var(row)), (positive)).
#modeb( column(var(col))).

