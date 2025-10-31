


 :- match(X, Y1), match(X, Y2), Y1 != Y2.
 :- match(X1, Y), match(X2, Y), X1 != X2.
 :- edge(X, Y), not match(X, _), not match(_, Y).
#pos({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(1, b),match(2, b),not_match(2, c),match(3, c)  },{ not_match(2, b),match(2, c),not_match(3, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#pos({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(1, b),not_match(2, b),match(2, c),not_match(3, c)  },{ match(2, b),not_match(2, c),match(3, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#pos({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(2, b),match(2, c),not_match(3, c),not_match(1, a),match(1, b)  },{ match(1, a),not_match(1, b),match(2, b),not_match(2, c),match(3, c)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#pos({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(2, c),match(3, c),not_match(2, b),not_match(1, a),match(1, b)  },{ match(1, a),not_match(1, b),match(2, b),match(2, c),not_match(3, c)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),match(1, b)  },{ not_match(1, b),not_match(1, a)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),match(3, c),not_match(2, b)  },{ match(2, b),not_match(2, c),match(2, c),not_match(3, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(1, a)  },{ match(2, b),not_match(2, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(1, a)  },{ match(3, c),match(2, c)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(1, a)  },{ match(3, c),not_match(2, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(1, a)  },{ match(3, c),not_match(3, c)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(1, a)  },{ not_match(1, b),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(1, a)  },{ not_match(1, b),not_match(2, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(1, a)  },{ not_match(2, c),match(2, c)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(1, a)  },{ not_match(2, c),not_match(2, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(1, a)  },{ not_match(2, c),not_match(3, c)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(1, a),not_match(2, c),not_match(2, b)  },{ match(2, b),match(2, c),not_match(3, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(2, b),match(1, b)  },{ match(1, a),not_match(1, b),not_match(2, b),match(2, c),not_match(3, c),not_match(1, a)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(2, b),match(2, c)  },{ match(1, a),not_match(1, b),not_match(2, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(2, b),not_match(1, a)  },{ match(1, a),not_match(1, b),not_match(2, b),match(2, c),not_match(3, c)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(2, b),not_match(2, b)  },{ match(1, a),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(2, b),not_match(2, b)  },{ match(1, a),not_match(1, b),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(2, b),not_match(2, b)  },{ match(1, a),not_match(1, b),not_match(1, a)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(2, b),not_match(2, b)  },{ not_match(1, b),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(2, b),not_match(3, c)  },{ match(1, a),not_match(1, b),not_match(2, b),match(2, c)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(3, c),match(2, c)  },{ match(1, a),match(2, b),not_match(2, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(3, c),match(2, c)  },{ match(1, a),not_match(1, b),match(2, b),not_match(2, c),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(3, c),match(2, c)  },{ match(1, a),not_match(1, b),match(2, b),not_match(2, c),not_match(1, a)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(3, c),match(2, c)  },{ match(1, a),not_match(1, b),match(2, b),not_match(2, c),not_match(2, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(3, c),match(2, c)  },{ match(1, a),not_match(1, b),match(2, b),not_match(2, c),not_match(3, c)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(3, c),match(2, c)  },{ match(2, b),not_match(2, c),not_match(2, b),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(3, c),match(2, c)  },{ match(2, b),not_match(2, c),not_match(3, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(3, c),match(2, c)  },{ not_match(1, b),match(2, b),not_match(2, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(3, c),not_match(3, c)  },{ match(1, a),not_match(1, b),match(2, b),not_match(2, c),match(2, c)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),match(3, c),not_match(3, c)  },{ match(2, b),not_match(2, c),match(2, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(1, b),match(1, b)  },{ match(1, a),not_match(1, a)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(1, b),match(3, c),not_match(2, b)  },{ match(1, a),match(2, b),not_match(2, c),match(2, c),not_match(3, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(1, b),not_match(1, a)  },{ match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(1, b),not_match(1, a)  },{ match(1, a),not_match(2, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(1, b),not_match(2, c),not_match(2, b)  },{ match(1, a),match(2, b),match(2, c),not_match(3, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(2, c),match(2, c)  },{ match(1, a),match(2, b),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(2, c),match(2, c)  },{ match(1, a),not_match(1, b),match(2, b),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(2, c),match(2, c)  },{ match(1, a),not_match(1, b),match(2, b),not_match(1, a)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(2, c),match(2, c)  },{ match(1, a),not_match(1, b),match(2, b),not_match(2, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(2, c),match(2, c)  },{ match(2, b),not_match(2, b),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(2, c),match(2, c)  },{ match(2, b),not_match(3, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(2, c),match(2, c)  },{ not_match(1, b),match(2, b),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).
#neg({edge(1, a),edge(1, b),edge(2, b),edge(2, c),edge(3, c),not_match(2, c),not_match(3, c)  },{ match(2, b),match(2, c),not_match(1, a),match(1, b)  },{ edge(1, a). edge(1, b). edge(2, b). edge(2, c). edge(3, c).  }).#modeh(1, match(var(node1),var(node2))).
#modeh(1, not_match(var(node1),var(node2))).
#modeb( not_match(var(node1),var(node2))).
#modeb( match(var(node1),var(node2))).
#modeb( var(node1) != var(node1), (positive)).
#modeb( var(node2) != var(node2), (positive)).
#modeb( edge(var(node1),var(node2)), (positive)).


