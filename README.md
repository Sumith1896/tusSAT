## tusSAT

A hardware SAT solver implementation in VHDL for our [CS 254: Digital Logic Design](https://www.cse.iitb.ac.in/~supratik/courses/cs226/) course project under the guidance of [Prof. Supratik Chakraborty](https://www.cse.iitb.ac.in/~supratik/). The team name of the members `tussle`, hence the name `tusSAT`.

## Usage

You can add the sources to a project and use `tusSAT_top.vhd` as your top module. <br>
You can get ready-to-import project here [https://cse.iitb.ac.in/~sumith/projects/tusSAT.tar.gz](http://cse.iitb.ac.in/~sumith/projects/tusSAT.tar.gz).

## Doc

Our project documentation is in the `doc` section. The code has inline comments added too.

## Testing

The tests are in `tests` subdirectory. The `testbench` are some select testbenches mostly from [DIMACS Satisfiability challenges](ftp://dimacs.rutgers.edu/pub/challenge/satisfiability/benchmarks/cnf/). You can also generate your `.vhd` testbench for your own boolean expression using `syntestbench.py`. This converts the given boolean expression to a `.vhd` testbench. This has [SymPy](http://www.sympy.org/en/index.html) as it's dependency. More detailed instructions can be found in it's readme.

## Open source

The project will be maintained open source under BSD license. <br>
We are welcome for contributions and design suggestions. We are also open to very general VHDL suggestions as we are rookies in this area. Please open an issue in this repository or ping us. <br>
If you send in a PR, ping [@Sumith1896](https://github.com/Sumith1896) or [@shubham-goel](https://github.com/shubham-goel) for review.
