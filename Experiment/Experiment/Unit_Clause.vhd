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

signal _in_formula : formula := ZERO_FORMULA;
signal _ended : STD_LOGIC := '0';
signal _found : STD_LOGIC := '0';
signal _lit_found : lit := ZERO_LIT;
signal _finding : STD_LOGIC := '0';
signal i : INTEGER := 0;
begin
ended <= _ended;
found <= _found;
lit_found <= _lit_found;

process(clock,reset)
begin
if reset='1' then
	_ended <= '1';
	_found <= '0';
	_lit_found <= ZERO_LIT;
elsif rising_edge(clock) then

	if find='1' and _finding='0' then
		_in_formula <= in_formula;
		_finding <= '1';
		_ended <= '0';
		i <= 0;
	elsif _finding = '1' then

		--for i in 0 to NUMBER_CLAUSES-1 loop
		--	exit when ((i = _in_formula.len)or(_finished='1'));
		--	if (_in_formula.clauses[i]).len = 1 then
		--		_found <= '1';
		--		_finished <= '1';
		--		_lit_found <= (_in_formula.clauses[i]).lits[0];
		--	end if ;
		--end loop ;
		--_ended <= '1';

		if((i < _in_formula.len) and (i < NUMBER_CLAUSES)) then
			if (_in_formula.clauses[i]).len = 1 then
				_finding <= '0';
				_found <= '1';
				_finished <= '1';
				_ended <= '1';
				_lit_found <= (_in_formula.clauses[i]).lits[0];
			else
				_ended <= '0';
			end if;
		else
			_finding <= '0';
			_ended <= '1';
			_found <= '0'; 
		end if;
		i <= i+1;
	end if;
end if;

end process ;

end Behavioral;

