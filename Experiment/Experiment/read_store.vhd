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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity read_store is
	generic(vars: INTEGER:=64
			max_size : INTEGER := 1024;
			int_range_st : INTEGER := -70;
  			int_range_end : INTEGER := 70););
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           i : in  STD_LOGIC_VECTOR((vars-1) downto 0);
end read_store;

architecture Behavioral of read_store is
type  mem_type is array (max_size downto 0) of INTEGER range int_range_st to int_range_end;
signal data : mem_type := (others => 0);
type  mem_type2 is array (max_size downto 0) of STD_LOGIC_VECTOR(63 downto 0);
signal bit_vec : mem_type2 := (others => (others => '0'));
signal noofcycles : INTEGER := 0;
signal lowload : STD_LOGIC := '0';

begin
	

	DATA: process(clock, load)
		variable noofclauses: INTEGER := 0;
		variable row_iterator: INTEGER := 0;
		if rising_edge(clock) then
			
			--RESET
		    if reset='1' then 
		      data <= (others=>0);
		      bit_vec <= (others => (others => '0'));
		      noofcycles <= 0;
		      lowload <= '0';

		    -- PARSE
		    if load='1' then 
		    	bit_vec(noofcycles) <= i;
		      	noofcycles <= noofcycles + 1;
		      	lowload = '0';

			elsif load = '0' and lowload = '0' then
				lowload = '1';

			elsif load = '0' and lowload = '1' then
				noofclauses := noofcycles/2;
				for i in 0 to 1000 loop
					exit when i = noofclauses;
					row_iterator := 0;
					for j in 0 to 64 loop
						exit when j = 64
						if bit_vec(2*i)(j) = '1' and bit_vec(2*i + 1)(j) = '0' then
							data(i)(row_iterator) <= j + 1;
							row_iterator := row_iterator + 1;
						elsif bit_vec(2*i)(j) = '0' and bit_vec(2*i + 1)(j) = '1' then
							data(i)(row_iterator) <= - j - 1;
							row_iterator := row_iterator + 1;
						end if;
					end loop
				end loop;
			end if;
		end if;
	end process;		

end Behavioral;

