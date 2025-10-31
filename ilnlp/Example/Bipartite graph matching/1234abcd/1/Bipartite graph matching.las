


 :- edge(X, Y), not match(X, _), not match(_, Y).
#pos({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(2, b),match(3, c),match(1, a),not_match(1, d),not_match(4, a),match(4, d)  },{ not_match(1, a),match(1, d),match(4, a),not_match(4, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#pos({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(2, b),match(3, c),not_match(1, a),match(1, d),match(4, a),not_match(4, d)  },{ match(1, a),not_match(1, d),not_match(4, a),match(4, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),match(1, d)  },{ match(2, b),not_match(1, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),match(1, d)  },{ match(3, c),not_match(1, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),match(1, d)  },{ match(4, d),not_match(1, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),match(1, d)  },{ not_match(1, d),not_match(1, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),match(1, d)  },{ not_match(4, a),not_match(1, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),match(4, a)  },{ match(2, b),not_match(1, a),match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),match(4, a)  },{ match(3, c),not_match(1, a),match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),match(4, a)  },{ match(4, d),not_match(1, a),match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),match(4, a)  },{ not_match(1, d),not_match(1, a),match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),match(4, a)  },{ not_match(4, a),not_match(1, a),match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),not_match(1, a)  },{ match(2, b)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),not_match(1, a)  },{ match(3, c)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),not_match(4, d)  },{ match(2, b),not_match(1, a),match(1, d),match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),not_match(4, d)  },{ match(3, c),not_match(1, a),match(1, d),match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),not_match(4, d)  },{ match(4, d),not_match(1, a),match(1, d),match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),not_match(4, d)  },{ not_match(1, d),not_match(1, a),match(1, d),match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(1, a),not_match(4, d)  },{ not_match(4, a),not_match(1, a),match(1, d),match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(4, d),match(1, d)  },{ match(1, a),not_match(1, d),not_match(4, a),not_match(1, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(4, d),match(4, a)  },{ match(1, a),not_match(1, d),not_match(4, a),not_match(1, a),match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(4, d),not_match(1, a)  },{ match(1, a),not_match(1, d),not_match(4, a),match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(4, d),not_match(1, a)  },{ match(1, a),not_match(1, d),not_match(4, a),match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(4, d),not_match(1, a)  },{ match(1, a),not_match(1, d),not_match(4, a),not_match(4, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(4, d),not_match(1, a)  },{ match(2, b),match(1, a),not_match(1, d),not_match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(4, d),not_match(1, a)  },{ match(3, c),match(1, a),not_match(1, d),not_match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),match(4, d),not_match(4, d)  },{ match(1, a),not_match(1, d),not_match(4, a),not_match(1, a),match(1, d),match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(1, d),match(1, d)  },{ match(1, a),not_match(1, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(1, d),match(4, a)  },{ match(1, a),not_match(1, a),match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(1, d),not_match(1, a)  },{ match(1, a),match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(1, d),not_match(1, a)  },{ match(1, a),match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(1, d),not_match(1, a)  },{ match(1, a),not_match(4, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(1, d),not_match(1, a)  },{ match(2, b),match(1, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(1, d),not_match(1, a)  },{ match(3, c),match(1, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(1, d),not_match(4, d)  },{ match(1, a),not_match(1, a),match(1, d),match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(4, a),match(1, d)  },{ match(1, a),not_match(1, d),not_match(1, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(4, a),match(4, a)  },{ match(1, a),not_match(1, d),not_match(1, a),match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(4, a),not_match(1, a)  },{ match(1, a),not_match(1, d),match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(4, a),not_match(1, a)  },{ match(1, a),not_match(1, d),match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(4, a),not_match(1, a)  },{ match(1, a),not_match(1, d),not_match(4, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(4, a),not_match(1, a)  },{ match(2, b),match(1, a),not_match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(4, a),not_match(1, a)  },{ match(3, c),match(1, a),not_match(1, d)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).
#neg({edge(1, a),edge(1, d),edge(2, b),edge(3, c),edge(4, a),edge(4, d),not_match(4, a),not_match(4, d)  },{ match(1, a),not_match(1, d),not_match(1, a),match(1, d),match(4, a)  },{ edge(1, a). edge(1, d). edge(2, b). edge(3, c). edge(4, a). edge(4, d).  }).#modeh(1, match(var(node1),var(node2))).
#modeh(1, not_match(var(node1),var(node2))).
#modeb( not_match(var(node1),var(node2))).
#modeb( match(var(node1),var(node2))).
#modeb( var(node1) != var(node1), (positive)).
#modeb( var(node2) != var(node2), (positive)).
#modeb( edge(var(node1),var(node2)), (positive)).


