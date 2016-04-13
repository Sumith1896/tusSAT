----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:17:40 04/04/2016 
-- Design Name: 
-- Module Name:    Unit_Clause - Behavioral 
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

entity Unit_Clause is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           find : in  STD_LOGIC;
           in_formula : in  formula;
           ended : out  STD_LOGIC;
           found : out  STD_LOGIC;
           lit_found : out  lit);
end Unit_Clause;

architecture Behavioral of Unit_Clause is

signal s_in_formula : formula := ZERO_FORMULA;
signal s_ended : STD_LOGIC := '0';
signal s_found : STD_LOGIC := '0';
signal s_lit_found : lit := ZERO_LIT;
signal s_finding : STD_LOGIC := '0';
signal i : INTEGER := 0;
begin
ended <= s_ended;
found <= s_found;
lit_found <= s_lit_found;

process(clock,reset)
begin
if reset='1' then
	s_ended <= '0';
	s_found <= '0';
elsif rising_edge(clock) then
	s_ended <= '0';
	if find='1' and s_finding='0' then
		s_in_formula <= in_formula;
		s_finding <= '1';
		s_ended <= '0';
		i <= 0;
	elsif s_finding = '1' then

		--for i in 0 to NUMBER_CLAUSES-1 loop
		--	exit when ((i = s_in_formula.len)or(_finished='1'));
		--	if (s_in_formula.clauses(i)).len = 1 then
		--		_found <= '1';
		--		_finished <= '1';
		--		s_lit_found <= (s_in_formula.clauses(i)).lits[0];
		--	end if ;
		--end loop ;
		--s_ended <= '1';

		if((i < s_in_formula.len) and (i < NUMBER_CLAUSES)) then
			if s_in_formula.clauses(i).len = 1 then
				s_finding <= '0';
				s_found <= '1';
				s_ended <= '1';
				s_lit_found <= s_in_formula.clauses(i).lits(0);
			else
				s_ended <= '0';
			end if;
		else
			s_finding <= '0';
			s_ended <= '1';
			s_found <= '0'; 
		end if;
		i <= i+1;
	end if;
end if;

end process ;

end Behavioral;

