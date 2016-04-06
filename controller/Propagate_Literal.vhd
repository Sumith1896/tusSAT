----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:55:55 04/05/2016 
-- Design Name: 
-- Module Name:    Propagate_Literal - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Common.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Propagate_Literal is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           find : in  STD_LOGIC;
           in_formula : in  formula;
           in_lit : in  lit;
           ended : out  STD_LOGIC;
           empty_clause : out  STD_LOGIC;
           empty_formula : out  STD_LOGIC;
           out_formula : out  formula);
end Propagate_Literal;

architecture Behavioral of Propagate_Literal is

signal s_in_formula : formula := ZERO_FORMULA;
signal s_in_lit : lit := ZERO_LIT;
signal s_ended : STD_LOGIC := '1';
signal s_empty_clause : STD_LOGIC := '0';
signal s_empty_formula : STD_LOGIC := '0';
signal s_out_formula : formula := ZERO_FORMULA;

signal s_finding : STD_LOGIC := '0';
signal i : INTEGER := 0;
signal j : INTEGER := 0;

type state is (IDLE,BEGIN_OUTER,BEGIN_INNER,RUN_INNER,END_INNER,END_OUTER,DONE);       -- State declaration
signal present_state: state := IDLE;

signal final_formula : formula := ZERO_FORMULA;
signal temp_clause : clause := ZERO_CLAUSE;
signal num_clauses : INTEGER := 0;
signal num_lits : INTEGER := 0;

begin

ended <= s_ended;
empty_clause <= s_empty_clause;
empty_formula <= s_empty_formula;
out_formula <= s_out_formula;

process(clock,reset)
begin
if reset='1' then
	s_in_formula <= ZERO_FORMULA;
	s_in_lit <= ZERO_LIT;
	s_ended <= '1';
	s_empty_clause <= '0';
	s_empty_formula <= '0';
	s_out_formula <= ZERO_FORMULA;
	s_finding <= '0';
	i <= 0;
	j <= 0;
	present_state <= IDLE;
	final_formula <= ZERO_FORMULA;
	temp_clause <= ZERO_CLAUSE;
	num_clauses <= 0;
	num_lits <= 0;
	present_state <= IDLE;
	
elsif rising_edge(clock) then

 if find='1' and s_finding = '0' then
	 	s_in_formula <= in_formula;
	 	s_in_lit <= in_lit;
	 	s_finding <= '1';
	 	s_ended <= '0';
	 	present_state <= BEGIN_OUTER;
 elsif s_finding = '1' then
 	s_ended <= '0';
 	case( present_state ) is

 		when BEGIN_OUTER  =>
 			final_formula <= ZERO_FORMULA;
 			num_clauses <= 0;
 			i<=0;
 			present_state <= BEGIN_INNER;

 		when BEGIN_INNER =>
 			if i >= s_in_formula.len then
 				present_state <= END_OUTER;
 			else
 				temp_clause <= ZERO_CLAUSE;
 				num_lits <= 0;
 				j <= 0;
 				present_state <= RUN_INNER;
 			end if;

 		when RUN_INNER =>
 			if j >= s_in_formula.clauses(i).len then
 				present_state <= END_INNER;
 			else
 			 	if s_in_formula.clauses(i).lits(j).num = s_in_lit.num then
 			 		if s_in_formula.clauses(i).lits(j).val = s_in_lit.val then
 			 			i <= i+1;
 			 			present_state <= BEGIN_INNER;
 			 		else
 			 			j <= j+1;
 			 			present_state <= RUN_INNER;
 			 		end if ;
 			 	elsif s_in_formula.clauses(i).lits(j).num = 0 then
		 			j <= j+1;
		 			present_state <= RUN_INNER;
 			 	else
 			 		temp_clause.lits(num_lits) <= s_in_formula.clauses(i).lits(j);
 			 		temp_clause.len <= num_lits + 1;
 			 		num_lits <= num_lits + 1;
 			 		j <= j + 1;
 			 		present_state <= RUN_INNER;
 			 	end if; 			
 			end if ;

 		when END_INNER =>
 			if num_lits = 0 then
				s_ended <= '1';
				s_finding <= '0';
 				s_empty_clause <= '1';
				s_empty_formula <= '0';
				s_out_formula <= final_formula;
				present_state <= DONE;
			else
				final_formula.clauses(num_clauses) <= temp_clause;
				final_formula.len <= num_clauses+1;
				num_clauses <= num_clauses+1;
				i <= i+1;
				present_state <= BEGIN_OUTER;
 			end if ;

 		when END_OUTER =>
 			if num_clauses = 0 then
				s_ended <= '1';
				s_finding <= '0';
 				s_empty_clause <= '0';
				s_empty_formula <= '1';
				s_out_formula <= final_formula;
				present_state <= DONE;
 			else
				s_ended <= '1';
				s_finding <= '0';
 				s_empty_clause <= '0';
				s_empty_formula <= '0';
				s_out_formula <= final_formula;
				present_state <= DONE; 				
 			end if ;

 		when DONE =>
			present_state <= IDLE; 

 		when others =>
 			s_ended <= '1';
			s_finding <= '0';
			s_empty_clause <= '0';
			s_empty_formula <= '0';
			s_out_formula <= ZERO_FORMULA;
 			present_state <= IDLE;

 	end case ;
 end if;

end if;
end process;


end Behavioral;

