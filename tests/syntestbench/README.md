We have incorported a testbench generation code in form of syntestbench python script.
Dependency : Python, SymPy

Usage:
do 
```
$ python syntestbench.py > testbench.vhd
```
then enter
- number of literals
- number of clauses
- boolean expression

The code will then be generated in testbench.vhd

For boolean expressions(these need not be in CNF)
Use & for And, ~ for negation and | for Or
Example : (p | q) & (~p | q) & (p | ~q)
