----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:41:23 04/02/2016 
-- Design Name: 
-- Module Name:    Stack_bool - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Stack_bool is
				
	Port ( clock : in  STD_LOGIC;
		 reset : in  STD_LOGIC;
		 wr_en : in  STD_LOGIC;
		 rd_en : in  STD_LOGIC;
		 pop : in  STD_LOGIC;
		 din : in  STD_LOGIC;
		 dout : out  STD_LOGIC;
		 full : out  STD_LOGIC;
		 empty : out  STD_LOGIC);
end Stack_bool;

architecture Behavioral of Stack_bool is
--DATA VARIABLES
type  mem_type is array (bool_stack_size downto 0) of STD_LOGIC;
signal data : mem_type := (others => '0');
signal curr_size : INTEGER := 0;

--OTHER Vars
signal data_in : STD_LOGIC;
signal data_out : STD_LOGIC;
signal full_signal : STD_LOGIC := '0';
signal empty_signal : STD_LOGIC := '1';
begin
	
	data_in <= din;
	dout <= data_out;
	full <= full_signal;
	empty <= empty_signal;

	process(clock)
	variable temp : INTEGER := curr_size;
	begin
		if rising_edge(clock) then
			
			--RESET
			if reset='1' then 
				data <= (others=> '0');
				curr_size <= 0;
				data_out <= '0';
				empty_signal <= '1';
				full_signal <= '0';
			
			-- PUSH
			elsif wr_en='1' and full_signal='0' then 
				data(curr_size) <= data_in;
				curr_size <= curr_size + 1;
				temp := temp + 1;
			
			--READ
			elsif rd_en='1' and empty_signal='0' then 
				data_out <= data(curr_size-1);
			
			--POP
			elsif pop = '1' and empty_signal='0' then 
				data_out <= data(curr_size-1);
				curr_size <= curr_size - 1;
				temp := temp - 1;
			end if;

			--SET_SIGNALS
			if temp=(bool_stack_size) then
				full_signal <= '1';
				empty_signal <= '0';
			elsif temp=0 then
				full_signal <= '0';
				empty_signal <= '1';
			else
				full_signal <= '0';
				empty_signal <= '0';
			end if;
				
		end if;
	end process ;
end Behavioral;

