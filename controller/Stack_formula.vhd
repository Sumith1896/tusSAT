----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:13:23 04/02/2016 
-- Design Name: 
-- Module Name:    Stack_formula - Behavioral 
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

entity Stack_formula is
				
	Port ( clock : in  STD_LOGIC;
         reset : in  STD_LOGIC;
         wr_en : in  STD_LOGIC;
         pop : in  STD_LOGIC;
         din : in  formula;
         dout : out  formula;
         front : out formula;
         full : out  STD_LOGIC;
         empty : out  STD_LOGIC);
end Stack_formula;

architecture Behavioral of Stack_formula is
--DATA VARIABLES
type  mem_type is array (formula_stack_size downto 0) of formula;
signal data : mem_type := (others => zero_formula);
signal curr_size : INTEGER := 0;

--OTHER Vars
signal data_in : formula;
signal data_out : formula;
signal full_signal : STD_LOGIC := '0';
signal empty_signal : STD_LOGIC := '1';
begin
  
  data_in <= din;
  dout <= data_out;
  full <= full_signal;
  empty <= empty_signal;

	process(clock,reset)
  variable temp : INTEGER := curr_size;
  begin
    --RESET
    if reset='1' then 
        data <= (others=>zero_formula);
        curr_size <= 0;
        data_out <= zero_formula;
        empty_signal <= '1';
        full_signal <= '0';
        front <= zero_formula;

    elsif rising_edge(clock) then      
      -- PUSH
      if wr_en='1' and full_signal='0' then 
        data(curr_size) <= data_in;
        curr_size <= curr_size + 1;
        temp := temp + 1;

      --POP
      elsif pop = '1' and empty_signal='0' then 
        data_out <= data(curr_size-1);
        curr_size <= curr_size - 1;
        temp := temp - 1;
      end if;

      --FRONT
      if temp > 0 then 
        front <= data(temp-1);
      end if;

      if temp=(formula_stack_size) then
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

