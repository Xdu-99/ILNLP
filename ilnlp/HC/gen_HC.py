import argparse
import random
import re
import os
import subprocess
import sys
from collections import defaultdict
from itertools import combinations, chain, permutations
import clingo
import clingo.ast
import networkx as nx
import numpy as np

import parser
import asp_types
import ground
from profile import Profiler

def gen_graph(nodes, prob):
    """生成Erdos-Renyi随机图"""
    graph = []
    graph = nx.erdos_renyi_graph(nodes, prob, directed=False)
    nodes=[]
    edges=[]
    for node in graph.nodes():
        nodes.append(f"node({node+1})") 
        neighbors = list(graph.neighbors(node))
        for nb in neighbors:
            edges.append(f"edge({node+1},{nb+1})")  
         
    return nodes, edges, 

def generate_hamiltonian_examples(n_examples, n_nodes, prob):
    # ASP 程序
    asp_program = """
       :- in(U,V),in(U,W),V != W.
       :- in(V,U),in(W,U),V != W.
       reach(X):-edge(U,X),in(U,X), reach(U).
       reach(Y):-in(X,Y),initial(X).
       :- node(X),not reach(X).
       {in(X,Y)}:-edge(X,Y). 
       edge(X,Y) :- edge(Y,X).
       initial(1).
       #show in/2. 
       #show reach/1.
       """
    examples = []
    for i in range(n_examples):
        nodes,edges = gen_graph(n_nodes,prob)
        # construct the input 
        input_io = " ".join(nodes+edges) + " initial(1)."

        # construct the ASP instance of graph
        asp_graph = ". ".join(nodes+edges) + "." 

        # 使用 clingo 求解回答集 
        control = clingo.Control()
        control.add("base", [], asp_program + asp_graph) 
        #control.add("base", [], asp_graph) 
        control.ground([("base", [])])

        control.configuration.solve.models = 0  # 获取所有回答集
        output_io = []
        with control.solve(yield_=True) as handle:
            for i, model in enumerate(handle, 1): 
                output_io.append(str(model))
        examples.append((input_io,output_io))
        
    return examples

if __name__ == "__main__":
    # generate 10 ILNLP tasks
        # 设置命令行参数解析
    arg_parser = argparse.ArgumentParser(
        description="Generating the examples E for Hamiltonian circuits inductive learning tasks <B,E>",
        formatter_class=argparse.RawTextHelpFormatter
    )
    arg_parser.add_argument(
        "nn",
        type=int,
        default=5,
        help="number of nodes of a graph"
    )   
    
    args = arg_parser.parse_args()
    
    # |E| \in {5, 10, 30}, nn 
    for NE in [5,10,30]:
        for i in range(1,11,1):
            file = "../HC/4/examples/hc-"+str(NE)+"-"+str(i)+".las"
            examples = generate_hamiltonian_examples(NE, args.nn, 0.6)
            with open(file,"w") as f:
                for input, output in examples:
                    print(f"I:{input}\n", file=f)
                    print("O:", file=f)
                    for e in output:
                        print(f"{{{e}}}\n", file=f) 