--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package Common is

-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
-- Declare constants
--
 constant number_clauses : INTEGER := 1024;
 constant number_literals : INTEGER := 64;
 constant lit_range_st : INTEGER := 0;
 constant lit_range_end : INTEGER := 64;
 constant bool_stack_size : INTEGER := 1024;
 constant lit_stack_size : INTEGER := 64;
 constant formula_stack_size : INTEGER := 64;
 
 type lit is 
 record 
 	num : INTEGER range lit_range_st to lit_range_end;
 	val : std_logic;
 end record;

 type lit_array is array(number_literals downto 0) of lit;

 type clause is 
 record 
 	lits : lit_array;
 	len : INTEGER range 0 to number_literals;
 end record;

 type clause_array is array(number_clauses downto 0) of clause;

 type formula is 
 record
	clauses : clause_array;
	len : INTEGER range 0 to number_clauses;
 end record;

 type formula_array is array(formula_stack_size downto 0) of formula;

 constant zero_lit : lit := (num=>0,val=>'0');
 constant zero_lit_array : lit_array := (others => zero_lit);
 constant zero_clause : clause := (lits=>zero_lit_array,len=>0);
 constant zero_clause_array : clause_array := (others => zero_clause);
 constant zero_formula : formula := (clauses=>zero_clause_array,len=>0);
 constant zero_formula_array : formula_array := (others => zero_formula);
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--
end Common;

package body Common is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end Common;
