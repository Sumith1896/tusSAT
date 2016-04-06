----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:44:50 04/04/2016 
-- Design Name: 
-- Module Name:    Pure_Literal - Behavioral 
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
use work.common.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pure_Literal is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           in_formula : in  formula;
           find : in  STD_LOGIC;
           ended : out  STD_LOGIC;
           found : out  STD_LOGIC;
           lit_found : out lit);
end Pure_Literal;

architecture Behavioral of Pure_Literal is

signal s_in_formula : formula := ZERO_FORMULA;
signal s_ended :  STD_LOGIC := '0';
signal s_found : STD_LOGIC := '0';
signal s_lit_found : lit := ZERO_LIT;
signal s_finding : STD_LOGIC := '0';
signal s_val_set : STD_LOGIC_VECTOR((number_literals-1) downto 0) := (others => '0');
signal s_val : STD_LOGIC_VECTOR((number_literals-1) downto 0) := (others => '0');
signal s_is_pure : STD_LOGIC_VECTOR((number_literals-1) downto 0) := (others => '0');
signal oiterator : INTEGER := 0;
signal iiterator : INTEGER := 0;
signal piterator : INTEGER := 0;


begin
ended <= s_ended;
found <= s_found;
lit_found <= s_lit_found;

process(clock, reset)
begin
if reset ='1' then
	s_in_formula <= ZERO_FORMULA;
	s_ended <= '0';
	s_found <= '0';
	s_lit_found <= ZERO_LIT;
	s_finding <= '0';
	s_val_set <= (others => '0');
	s_val <= (others => '0');
	s_is_pure <= (others => '1');
	oiterator <= 0;
	iiterator <= 0;
	piterator <= 0;

elsif rising_edge(clock) then 
	s_ended <= '0';
	if find='1' and s_finding='0' then
		s_in_formula <= in_formula;
		s_finding <= '1';
		s_ended <= '0';
		oiterator <= 0;
		iiterator <= 0;
		piterator <= 0;
		s_val_set <= (others => '0');
		s_val <= (others => '0');
		s_is_pure <= (others => '1');

	elsif s_finding = '1' then
		if oiterator < s_in_formula.len then
			if iiterator < s_in_formula.clauses(oiterator).len then
				if s_is_pure(s_in_formula.clauses(oiterator).lits(iiterator).num-1) = '1' then
					if s_val_set(s_in_formula.clauses(oiterator).lits(iiterator).num-1) = '1' then
						if s_val(s_in_formula.clauses(oiterator).lits(iiterator).num-1) /= s_in_formula.clauses(oiterator).lits(iiterator).val then
							s_is_pure(s_in_formula.clauses(oiterator).lits(iiterator).num-1) <= '0';
						end if;
					else
						s_val(s_in_formula.clauses(oiterator).lits(iiterator).num-1) <= s_in_formula.clauses(oiterator).lits(iiterator).val;
						s_val_set(s_in_formula.clauses(oiterator).lits(iiterator).num-1) <= '1';
					end if;
				end if;
				iiterator <= iiterator + 1;
			else
				iiterator <= 0;
				oiterator <= oiterator + 1;
			end if;
		else
			if piterator < number_literals then
				if s_is_pure(piterator) = '0' or s_val_set(piterator) = '0' then
					piterator <= piterator + 1;
				else
					s_lit_found.num <= piterator+1;
					s_lit_found.val <= s_val(piterator);
					s_finding <= '0';
					s_found <= '1';
					s_ended <= '1';
				end if;
			else 
				s_finding <= '0';
				s_found <= '0';
				s_ended <= '1';
			end if;
		end if;
	end if;
end if;
end process;
end Behavioral;
