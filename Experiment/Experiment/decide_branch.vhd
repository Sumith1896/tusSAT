----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:55:19 04/05/2016 
-- Design Name: 
-- Module Name:    decide_branch - Behavioral 
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

entity decide_branch is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           find : in  STD_LOGIC;
           formula_in : in  formula;
           ended : out  STD_LOGIC;
           lit_out : out  lit);
end decide_branch;

architecture Behavioral of decide_branch is
signal formula_s : formula := ZERO_FORMULA;
signal lit_s : lit := ZERO_LIT;
signal iterator : INTEGER := 0;
signal computing : STD_LOGIC := '0';
signal finished : STD_LOGIC := '0';

begin

lit_out <= lit_s;

process(clock, reset)
	begin
	--RESET--
    if reset='1' then 
		formula_s <= ZERO_FORMULA;
		lit_s <= ZERO_LIT;
		iterator <= 0;
		computing <= '0';
		finished <= '0';
		ended <= '1';
    elsif rising_edge(clock) then
	    if find = '1' and computing = '0' then 
	    	formula_s <= formula_in;
	    	computing <= '1';
	    	finished <= '0';
	    	ended <= '0';
		elsif computing = '1' then
			if formula_s.clauses(iterator).len = 0 then
				iterator <= iterator + 1;
			else
				lit_s <= formula_s.clauses(iterator).lits(0);
				computing <= '0';
				finished <= '1';
			end if;
			ended <= '0';
		elsif finished = '1' then
			ended <= '1';
		end if;
	end if;

end process;	
end Behavioral;

