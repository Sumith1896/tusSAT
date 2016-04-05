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
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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
signal iterator1 : INTEGER := 0; -- iterator over clauses
signal iterator2 : INTEGER := 0; -- iterator over literals
signal iterator3 : INTEGER := 0; -- iterator over scores array 
type score is array ((2*NUMBER_LITERALS) downto 0) of std_logic_vector(127 downto 0);  -- lit_i (val=0) ->2*i, lit_i (val=1) ->2*i-1
signal j_score : score; 
signal max_score :  std_logic_vector(127 downto 0);
signal computing : STD_LOGIC := '0';
signal finished : STD_LOGIC := '0';
signal compute_max : STD_LOGIC := '0';
-- JS implemements score as sum of 2^(-|w|)
-- we implement as sum of 2^{64-|w|}, to avoid float calculations

begin

lit_out <= lit_s;

process(clock, reset)
	begin
	--RESET--
    if reset='1' then 
		formula_s <= ZERO_FORMULA;
		lit_s <= ZERO_LIT;
		iterator1 <= 0;
		iterator2 <= 0;
		iterator3 <= 0;
		j_score <= (others => (others => '0'));
		max_score <= (others => '0');
		computing <= '0';
		finished <= '0';
		compute_max <= '0';
		ended <= '1';
    elsif rising_edge(clock) then
	    if find = '1' and computing = '0' then 
	    	formula_s <= formula_in;
	    	lit_s <= ZERO_LIT;
			iterator1 <= 0;
			iterator2 <= 0;
			iterator3 <= 0;
			j_score <= (others => (others => '0'));
			max_score <= (others => '0');
	    	computing <= '1';
	    	finished <= '0';
	    	compute_max <= '0';
	    	ended <= '0';
		elsif computing = '1' then
			if (compute_max = '1' and iterator3 = (2*NUMBER_LITERALS + 1)) then
				computing <= '0';
				finished <= '1';
				-- find max
			elsif (compute_max = '1') then
				if (max_score < j_score(iterator3)) then
					max_score <= j_score(iterator3);
					lit_s <= (num=>((iterator3+1)/2), val=>is_odd(iterator3) );
				end if;
				iterator3 <= iterator3 + 1;
			--elsif formula_s.clauses(iterator1).len = 0 then -- check this
			--	iterator2 <= 0;
			--	iterator1 <= iterator1 + 1;
			elsif (iterator1 = formula_s.len) then
				compute_max <= '1';
			elsif (iterator2 = formula_s.clauses(iterator1).len) then
				iterator2 <= 0;
				iterator1 <= iterator1 + 1;
			else
				j_score(formula_s.clauses(iterator1).lits(iterator2).num - logic_to_int(formula_s.clauses(iterator1).lits(iterator2).val)) 
				<= 
				j_score(formula_s.clauses(iterator1).lits(iterator2).num - logic_to_int(formula_s.clauses(iterator1).lits(iterator2).val))
					+ ((64-formula_s.clauses(iterator1).len) => '1', others =>'0');
				iterator2 <= iterator2 +1;
				--lit_s <= formula_s.clauses(iterator).lits(0);
				--computing <= '0';
				--finished <= '1';
			end if;
			ended <= '0';
		elsif finished = '1' then
			ended <= '1';
		end if;
	end if;

end process;	
end Behavioral;

