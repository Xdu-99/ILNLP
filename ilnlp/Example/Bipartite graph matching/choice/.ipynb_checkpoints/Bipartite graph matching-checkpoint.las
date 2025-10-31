


 :- match(X, Y1), match(X, Y2), Y1 != Y2.
 :- edge(X, Y), not match(X, _), not match(_, Y).
#pos({edge(1, a),edge(2, a),edge(3, a),edge(4, a),edge(1, b),match(1, a)  },{ match(1, b),match(4, a),match(3, a)  },{ edge(1, a). edge(2, a). edge(3, a). edge(4, a). edge(1, b).  }).
#pos({edge(1, a),edge(2, a),edge(3, a),edge(4, a),edge(1, b),match(1, b)  },{ match(1, a),match(4, a),match(3, a)  },{ edge(1, a). edge(2, a). edge(3, a). edge(4, a). edge(1, b).  }).
#pos({edge(1, a),edge(2, a),edge(3, a),edge(4, a),edge(1, b),match(1, b),match(3, a)  },{ match(1, a),match(4, a)  },{ edge(1, a). edge(2, a). edge(3, a). edge(4, a). edge(1, b).  }).
#pos({edge(1, a),edge(2, a),edge(3, a),edge(4, a),edge(1, b),match(1, b),match(4, a)  },{ match(1, a),match(3, a)  },{ edge(1, a). edge(2, a). edge(3, a). edge(4, a). edge(1, b).  }).
#neg({edge(1, a),edge(2, a),edge(3, a),edge(4, a),edge(1, b),match(4, a),match(3, a)  },{ match(1, a),match(1, b)  },{ edge(1, a). edge(2, a). edge(3, a). edge(4, a). edge(1, b).  }).#modeha(1, match(var(node1),var(node2))).
#modeb( match(var(node1),var(node2))).
#modeb( var(node1) != var(node1), (positive)).
#modeb( var(node2) != var(node2), (positive)).
#modeb( edge(var(node1),var(node2)), (positive)).


