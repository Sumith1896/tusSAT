from sympy import *
from sympy.logic.boolalg import Or, Not, conjuncts, disjuncts, to_cnf, to_int_repr, _find_predicates, is_literal

# error checking

def repeat_to_length(item, length):
	if length == 0:
		return []
	if length == 1:
		return [item]
	else:
		return [item] + repeat_to_length(item, length - 1)

def syntestbench(s, numlit, numclause):
	numlit = int(numlit)
	numclause = int(numclause)
	print("--ANSWER TO THIS TEST BENCH")
	print("--", end="")
	print(satisfiable(s))
	s = to_cnf(sympify(s))
	symbols = sorted(_find_predicates(s), key=default_sort_key)
	symbols_int_repr = set(range(0, len(symbols)))
	to_print = []
	if s.func != And:
		s1 = repeat_to_length(0, numlit)
		s2 = repeat_to_length(0, numlit)
		if s.func != Or:
			if s.is_Symbol:
				s1[symbols.index(s)] = 1
				to_print.append(s1)
				to_print.append(s2)
			else:
				s2[symbols.index(Not(s))] = 1
				to_print.append(s1)
				to_print.append(s2)
		else:
			for arg in s.args:
				if arg.is_Symbol:
					s1[symbols.index(arg)] = 1
				else:
					s2[symbols.index(Not(arg))] = 1
			to_print.append(s1)
			to_print.append(s2)

	else:
		clauses = s.args		
		for clause in clauses:
			s1 = repeat_to_length(0, numlit)
			s2 = repeat_to_length(0, numlit)
			if clause.func != Or:
				if clause.is_Symbol:
					s1[symbols.index(clause)] = 1
					to_print.append(s1)
					to_print.append(s2)
				else:
					s2[symbols.index(Not(clause))] = 1
					to_print.append(s1)
					to_print.append(s2)
			else:
				for arg in clause.args:
					if arg.is_Symbol:
						s1[symbols.index(arg)] = 1
					else:
						s2[symbols.index(Not(arg))] = 1
				to_print.append(s1)
				to_print.append(s2)
		
	if(numclause > len(to_print)/2):
		s1 = repeat_to_length(0, numlit)
		s2 = repeat_to_length(0, numlit)
		for i in range(numclause - int(len(to_print)/2)):
			to_print.append(s1)
			to_print.append(s2)

	return to_print

numlit = input("")
numclause = input("")
response = input("")

getlist = syntestbench(response, numlit, numclause)

print("""--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:09:58 04/06/2016
-- Design Name:   
-- Module Name:   /home/sumith1896/sandbox/controller/testing101.vhd
-- Project Name:  controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: controller
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testing101 IS
END testing101;
 
ARCHITECTURE behavior OF testing101 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT controller
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         load : IN  std_logic;
         i : IN  std_logic_vector(""" + str(int(numlit) - 1) + """ downto 0);
         ended : OUT  std_logic;
         sat : OUT  std_logic;
         model : OUT  std_logic_vector(""" + str(int(numlit) - 1) + """ downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal load : std_logic := '0';
   signal i : std_logic_vector(""" + str(int(numlit) - 1) + """ downto 0) := (others => '0');

 	--Outputs
   signal ended : std_logic;
   signal sat : std_logic;
   signal model : std_logic_vector(""" + str(int(numlit) - 1) + """ downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controller PORT MAP (
          clock => clock,
          reset => reset,
          load => load,
          i => i,
          ended => ended,
          sat => sat,
          model => model
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
wait for 100 ns;  
reset <= '1';
wait for 2*clock_period;
reset <= '0';

load <= '1';
""") 
for listi in getlist:
	print("i <= \"", end="")
	for x in listi:
		print(x, end="")
	print("\";")
	print("wait for clock_period;")

print("""
load <= '0';
     
      -- insert stimulus here 

      wait;
   end process;

END;""")


