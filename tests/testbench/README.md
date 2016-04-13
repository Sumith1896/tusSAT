The following are the testbenches in the project folder:

Add the testbenches given: There are 15 test benches are varying difficulties
A lot more can be generated very easily using syntestbench.py in others folder.

VERY IMP : Change the NUMBER_LITERALS and NUMBER_CLAUSES in the Common.vhd file as per the 
boolean expression. These NUMBER_LITERALS can be greater than the number of literals in 
the expression(same for number of clauses) but should not be lesser. The fastest simulation
is obtained when it is exactly equal.
Every testbench generated using syntestbench.py has the expected result on first two
lines of the testbench(applies to all files submitted). In case the instructors intends
to generate more using the script you can refer to this for the answer.

tussle_testbench1.vhd
---------------------

This has :
NUMBER_LITERALS = 6
NUMBER_CLAUSES = 7
(a | b |f) & (~b | d | f) &( ~b | ~d | f) &(c | ~a | f) & (~c | e | f) & (~c |~e|f) & (~f | g) & (~f | ~g)
This is unsatisfiable.

tussle_testbench2.vhd
---------------------

This has
NUMBER_LITERALS = 6
NUMBER_CLAUSES = 7
(a | b |f) & (~b | d | f) &( ~b | ~d | f) &(c | ~a | f) & (~c | e | f) & (~c |~e|f) & (~f | g) & (f | ~g)
This is satisfiable and the returned model satisfies it.

(Following are a few basic and a few advance test cases)

tussle_testbench3.vhd
---------------------
NUMBER_LITERALS : 3
NUMBER_CLAUSES : 3
a & (~a | b) & ~b
UNSAT

tussle_testbench4.vhd
---------------------
NUMBER_LITERALS : 3
NUMBER_CLAUSES : 3
a & ~a
UNSAT

tussle_testbench5.vhd
---------------------
NUMBER_LITERALS : 3
NUMBER_CLAUSES : 3
a & ~b
SAT

tussle_testbench6.vhd
---------------------
NUMBER_LITERALS : 3
NUMBER_CLAUSES : 3
(~a | b) &(~b |a)
SAT

tussle_testbench7.vhd
---------------------
NUMBER_LITERALS : 3
NUMBER_CLAUSES : 3
(a | b) & (~b | c)
SAT

tussle_testbench8.vhd
---------------------
NUMBER_LITERALS : 3
NUMBER_CLAUSES : 3
a & b & c
SAT

tussle_testbench9.vhd
---------------------
NUMBER_LITERALS : 3
NUMBER_CLAUSES : 3
(a  | b)&(~a | b)
SAT

tussle_testbench10.vhd
---------------------
NUMBER_LITERALS : 3
NUMBER_CLAUSES : 3
a &( ~a |b)&(~b | a)
SAT

The following are a few advance cases. We selected a few. 
These were taken as inputs in dimacs format and fed to syntestbench.py
Various tests on satisfiability using dimacs cnf file syntax
You can find lots of cnf files in
ftp://dimacs.rutgers.edu/pub/challenge/satisfiability/benchmarks/cnf/

tussle_testbench11.vhd
---------------------
NUMBER_LITERALS : 3
NUMBER_CLAUSES : 2
And(Or(Not(cnf_1), cnf_2, cnf_3), Or(Not(cnf_3), cnf_1))
SAT

tussle_testbench12.vhd
---------------------
NUMBER_LITERALS : 16
NUMBER_CLAUSES : 18
And(Or(Not(cnf_10), Not(cnf_11)), Or(Not(cnf_10), cnf_9), Or(Not(cnf_14), Not(cnf_8)), Or(Not(cnf_15), cnf_14), Or(Not(cnf_16), cnf_7), Or(Not(cnf_2), Not(cnf_4)), Or(Not(cnf_4), Not(cnf_5)), Or(Not(cnf_6), cnf_5), Or(Not(cnf_7), cnf_6), Or(Not(cnf_9), cnf_8), Or(cnf_1, cnf_2), Or(cnf_10, cnf_12), Or(cnf_10, cnf_9), Or(cnf_11, cnf_12), Or(cnf_13, cnf_14), Or(cnf_15, cnf_16), Or(cnf_3, cnf_4), Or(cnf_6, cnf_7))
SAT

tussle_testbench13.vhd
---------------------
NUMBER_LITERALS : 6
NUMBER_CLAUSES : 9
And(Not(cnf_1), Not(cnf_3), Or(Not(cnf_1), Not(cnf_3)), Or(Not(cnf_1), cnf_2), Or(Not(cnf_2), Not(cnf_5), cnf_4, cnf_6), Or(Not(cnf_2), cnf_1, cnf_3), Or(Not(cnf_4), Not(cnf_6)), Or(Not(cnf_4), cnf_2), Or(Not(cnf_4), cnf_5))
SAT

tussle_testbench14.vhd
---------------------
NUMBER_LITERALS : 42
NUMBER_CLAUSES : 133
And(Or(Not(cnf_1), Not(cnf_13)), Or(Not(cnf_1), Not(cnf_19)), Or(Not(cnf_1), Not(cnf_25)), Or(Not(cnf_1), Not(cnf_31)), Or(Not(cnf_1), Not(cnf_37)), Or(Not(cnf_1), Not(cnf_7)), Or(Not(cnf_10), Not(cnf_16)), Or(Not(cnf_10), Not(cnf_22)), Or(Not(cnf_10), Not(cnf_28)), Or(Not(cnf_10), Not(cnf_34)), Or(Not(cnf_10), Not(cnf_4)), Or(Not(cnf_10), Not(cnf_40)), Or(Not(cnf_11), Not(cnf_17)), Or(Not(cnf_11), Not(cnf_23)), Or(Not(cnf_11), Not(cnf_29)), Or(Not(cnf_11), Not(cnf_35)), Or(Not(cnf_11), Not(cnf_41)), Or(Not(cnf_11), Not(cnf_5)), Or(Not(cnf_12), Not(cnf_18)), Or(Not(cnf_12), Not(cnf_24)), Or(Not(cnf_12), Not(cnf_30)), Or(Not(cnf_12), Not(cnf_36)), Or(Not(cnf_12), Not(cnf_42)), Or(Not(cnf_12), Not(cnf_6)), Or(Not(cnf_13), Not(cnf_19)), Or(Not(cnf_13), Not(cnf_25)), Or(Not(cnf_13), Not(cnf_31)), Or(Not(cnf_13), Not(cnf_37)), Or(Not(cnf_13), Not(cnf_7)), Or(Not(cnf_14), Not(cnf_2)), Or(Not(cnf_14), Not(cnf_20)), Or(Not(cnf_14), Not(cnf_26)), Or(Not(cnf_14), Not(cnf_32)), Or(Not(cnf_14), Not(cnf_38)), Or(Not(cnf_14), Not(cnf_8)), Or(Not(cnf_15), Not(cnf_21)), Or(Not(cnf_15), Not(cnf_27)), Or(Not(cnf_15), Not(cnf_3)), Or(Not(cnf_15), Not(cnf_33)), Or(Not(cnf_15), Not(cnf_39)), Or(Not(cnf_15), Not(cnf_9)), Or(Not(cnf_16), Not(cnf_22)), Or(Not(cnf_16), Not(cnf_28)), Or(Not(cnf_16), Not(cnf_34)), Or(Not(cnf_16), Not(cnf_4)), Or(Not(cnf_16), Not(cnf_40)), Or(Not(cnf_17), Not(cnf_23)), Or(Not(cnf_17), Not(cnf_29)), Or(Not(cnf_17), Not(cnf_35)), Or(Not(cnf_17), Not(cnf_41)), Or(Not(cnf_17), Not(cnf_5)), Or(Not(cnf_18), Not(cnf_24)), Or(Not(cnf_18), Not(cnf_30)), Or(Not(cnf_18), Not(cnf_36)), Or(Not(cnf_18), Not(cnf_42)), Or(Not(cnf_18), Not(cnf_6)), Or(Not(cnf_19), Not(cnf_25)), Or(Not(cnf_19), Not(cnf_31)), Or(Not(cnf_19), Not(cnf_37)), Or(Not(cnf_19), Not(cnf_7)), Or(Not(cnf_2), Not(cnf_20)), Or(Not(cnf_2), Not(cnf_26)), Or(Not(cnf_2), Not(cnf_32)), Or(Not(cnf_2), Not(cnf_38)), Or(Not(cnf_2), Not(cnf_8)), Or(Not(cnf_20), Not(cnf_26)), Or(Not(cnf_20), Not(cnf_32)), Or(Not(cnf_20), Not(cnf_38)), Or(Not(cnf_20), Not(cnf_8)), Or(Not(cnf_21), Not(cnf_27)), Or(Not(cnf_21), Not(cnf_3)), Or(Not(cnf_21), Not(cnf_33)), Or(Not(cnf_21), Not(cnf_39)), Or(Not(cnf_21), Not(cnf_9)), Or(Not(cnf_22), Not(cnf_28)), Or(Not(cnf_22), Not(cnf_34)), Or(Not(cnf_22), Not(cnf_4)), Or(Not(cnf_22), Not(cnf_40)), Or(Not(cnf_23), Not(cnf_29)), Or(Not(cnf_23), Not(cnf_35)), Or(Not(cnf_23), Not(cnf_41)), Or(Not(cnf_23), Not(cnf_5)), Or(Not(cnf_24), Not(cnf_30)), Or(Not(cnf_24), Not(cnf_36)), Or(Not(cnf_24), Not(cnf_42)), Or(Not(cnf_24), Not(cnf_6)), Or(Not(cnf_25), Not(cnf_31)), Or(Not(cnf_25), Not(cnf_37)), Or(Not(cnf_25), Not(cnf_7)), Or(Not(cnf_26), Not(cnf_32)), Or(Not(cnf_26), Not(cnf_38)), Or(Not(cnf_26), Not(cnf_8)), Or(Not(cnf_27), Not(cnf_3)), Or(Not(cnf_27), Not(cnf_33)), Or(Not(cnf_27), Not(cnf_39)), Or(Not(cnf_27), Not(cnf_9)), Or(Not(cnf_28), Not(cnf_34)), Or(Not(cnf_28), Not(cnf_4)), Or(Not(cnf_28), Not(cnf_40)), Or(Not(cnf_29), Not(cnf_35)), Or(Not(cnf_29), Not(cnf_41)), Or(Not(cnf_29), Not(cnf_5)), Or(Not(cnf_3), Not(cnf_33)), Or(Not(cnf_3), Not(cnf_39)), Or(Not(cnf_3), Not(cnf_9)), Or(Not(cnf_30), Not(cnf_36)), Or(Not(cnf_30), Not(cnf_42)), Or(Not(cnf_30), Not(cnf_6)), Or(Not(cnf_31), Not(cnf_37)), Or(Not(cnf_31), Not(cnf_7)), Or(Not(cnf_32), Not(cnf_38)), Or(Not(cnf_32), Not(cnf_8)), Or(Not(cnf_33), Not(cnf_39)), Or(Not(cnf_33), Not(cnf_9)), Or(Not(cnf_34), Not(cnf_4)), Or(Not(cnf_34), Not(cnf_40)), Or(Not(cnf_35), Not(cnf_41)), Or(Not(cnf_35), Not(cnf_5)), Or(Not(cnf_36), Not(cnf_42)), Or(Not(cnf_36), Not(cnf_6)), Or(Not(cnf_37), Not(cnf_7)), Or(Not(cnf_38), Not(cnf_8)), Or(Not(cnf_39), Not(cnf_9)), Or(Not(cnf_4), Not(cnf_40)), Or(Not(cnf_41), Not(cnf_5)), Or(Not(cnf_42), Not(cnf_6)), Or(cnf_1, cnf_2, cnf_3, cnf_4, cnf_5, cnf_6), Or(cnf_10, cnf_11, cnf_12, cnf_7, cnf_8, cnf_9), Or(cnf_13, cnf_14, cnf_15, cnf_16, cnf_17, cnf_18), Or(cnf_19, cnf_20, cnf_21, cnf_22, cnf_23, cnf_24), Or(cnf_25, cnf_26, cnf_27, cnf_28, cnf_29, cnf_30), Or(cnf_31, cnf_32, cnf_33, cnf_34, cnf_35, cnf_36), Or(cnf_37, cnf_38, cnf_39, cnf_40, cnf_41, cnf_42))
UNSAT
PS: This takes considerable time but does eventually report unsat.

tussle_testbench15.vhd
---------------------
NUMBER_LITERALS : 5
NUMBER_CLAUSES : 5
And(Or(Not(cnf_1), Not(cnf_5)), Or(Not(cnf_2), cnf_1, cnf_3), Or(Not(cnf_3), Not(cnf_4), cnf_1), Or(Not(cnf_3), cnf_4, cnf_5), Or(cnf_1, cnf_2, cnf_3))
SAT

