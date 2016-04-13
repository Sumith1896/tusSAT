----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:40:37 04/02/2016 
-- Design Name: 
-- Module Name:    read_store - Behavioral 
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

entity read_store is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           i : in  STD_LOGIC_VECTOR((number_literals-1) downto 0);
           formula_res: out formula;
           ended: out STD_LOGIC);
end read_store;

architecture Behavioral of read_store is
signal temp_formula : formula := ZERO_FORMULA;
type mem_type is array ((2*number_clauses - 1) downto 0) of STD_LOGIC_VECTOR((number_literals-1) downto 0);
signal bit_vec : mem_type := (others => (others => '0'));
signal noofcycles : INTEGER := 0;
signal noofclauses: INTEGER := 0;
signal prev_load : STD_LOGIC := '0';
signal prev_load1 : STD_LOGIC := '0';
signal oiterator : INTEGER := 0;
signal iiterator : INTEGER := 0;
signal row_iterator : INTEGER := 0;
signal computing : STD_LOGIC := '0';
signal finished : STD_LOGIC := '0';

begin

process(clock, reset)
	begin
	--RESET--
    if reset='1' then 
		temp_formula <= ZERO_FORMULA;
		bit_vec <= (others => (others => '0'));
		noofcycles <= 0;
		prev_load <= '0';
		prev_load1 <= '0';
		noofclauses <= 0;
		oiterator <= 0;
		iiterator <= 0;
		row_iterator <= 0;
		computing <= '0';
		finished <= '0';
		ended <= '0';
    elsif rising_edge(clock) then
	    -- PARSE
	    prev_load <= load;
	    prev_load1 <= prev_load;	
		ended <= '0';
	    if load='1' and computing = '0'then 
	    	bit_vec(noofcycles) <= i;
	      	noofcycles <= noofcycles + 1;
			ended <= '0';

		elsif load = '0' and prev_load = '1' then
			--prev_load <= '1';
			ended <= '0';

		elsif load = '0' and prev_load = '0' and prev_load1 = '1' and computing = '0' then
			computing <= '1';
			noofclauses <= noofcycles/2;
			temp_formula.len <= noofcycles/2;
			ended <= '0';

		elsif computing = '1' then
			if oiterator < noofclauses then
				if iiterator < number_literals then
					if bit_vec(2*oiterator)(iiterator) = '1' and bit_vec(2*oiterator + 1)(iiterator) = '0' then
						temp_formula.clauses(oiterator).lits(row_iterator).num <= iiterator + 1;
						temp_formula.clauses(oiterator).lits(row_iterator).val <= '1';
						row_iterator <= row_iterator + 1;
					elsif bit_vec(2*oiterator)(iiterator) = '0' and bit_vec(2*oiterator + 1)(iiterator) = '1' then
						temp_formula.clauses(oiterator).lits(row_iterator).num <= iiterator + 1;
						temp_formula.clauses(oiterator).lits(row_iterator).val <= '0';
						row_iterator <= row_iterator + 1;
					end if;
					iiterator <= iiterator + 1;
				else

					if row_iterator = 0 then
						temp_formula.len <= temp_formula.len - 1;
					end if ;

					iiterator <= 0;
					temp_formula.clauses(oiterator).len <= row_iterator;
					row_iterator <= 0;
					oiterator <= oiterator + 1;
				end if;
			else 
				computing <= '0';
				finished <= '1';
			end if;
			ended <= '0';
		elsif finished='1' then
			formula_res <= temp_formula;
			ended <= '1';
		end if;
	end if;
end process;		
end Behavioral;
