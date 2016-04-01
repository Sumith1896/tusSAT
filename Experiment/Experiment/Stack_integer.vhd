----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:13:23 04/02/2016 
-- Design Name: 
-- Module Name:    Stack_integer - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Stack_integer is
	generic (max_size : INTEGER := 1024;
				int_range_st : INTEGER := -70;
				int_range_end : INTEGER := 70);
				
	Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           wr_en : in  STD_LOGIC;
           rd_en : in  STD_LOGIC;
           pop : in  STD_LOGIC;
           din : in  INTEGER range int_range_st to int_range_end;
           dout : out  INTEGER range int_range_st to int_range_end;
           full : out  STD_LOGIC;
           empty : out  STD_LOGIC);
end Stack_integer;

architecture Behavioral of Stack_integer is
--DATA VARIABLES
type  mem_type is array (max_size downto 0) of INTEGER range int_range_st to int_range_end;
signal data : mem_type := (others => 0);
signal curr_size : INTEGER := 0;

--OTHER Vars
signal data_in : INTEGER range int_range_st to int_range_end;
signal data_out : INTEGER range int_range_st to int_range_end;
signal full_signal : STD_LOGIC := '0';
signal empty_signal : STD_LOGIC := '1';
begin
  
  data_in <= din;
  dout <= data_out;
  full <= full_signal;
  empty <= empty_signal;

	RESET: process(clock)
  begin
    if reset='1' and rising_edge(clock) then
      data <= (others=>0);
      curr_size <= 0;
      data_out <= 0;
      empty_signal <= '1';
      full_signal <= '0';
    end if ;
  end process;

  PUSH : process(clock, wr_en)
  variable temp : INTEGER := curr_size;
  begin
    if rising_edge(clock) then
      if wr_en='1' and full_signal='0' then
        data(curr_size) <= din;
        curr_size <= curr_size + 1;
        temp := temp + 1;
      end if ;

      if temp=(max_size-2) then
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
  end process;

  READ : process(clock, rd_en)
  begin
    if rising_edge(clock) then
      if rd_en='1' and empty_signal='0' then
        data_out <= data(curr_size-1)
      end if ;
    end if;
  end process;

  POP : process( clock, pop )
  variable temp : INTEGER := curr_size;
  begin
    if rising_edge(clock) then
      if pop = '1' and empty_signal='0' then
        data_out <= data(curr_size-1)
        curr_size <= curr_size - 1;
        temp := temp - 1;
      end if;

      if temp=(max_size-2) then
        full_signal <= '1';
        empty_signal <= '0';
      elsif temp=0 then
        full_signal <= '0';
        empty_signal <= '1';
      else
        full_signal <= '0';
        empty_signal <= '0';
      end if;
        
    end if ;
  end process ; -- POP
end Behavioral;

