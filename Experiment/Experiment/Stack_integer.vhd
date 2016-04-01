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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Stack_integer is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           rd_en : in  STD_LOGIC;
           wr_en : in  STD_LOGIC;
           pop : in  STD_LOGIC;
           din : in  INTEGER;
           dout : out  INTEGER;
           full : out  STD_LOGIC;
           empty : out  STD_LOGIC);
end Stack_integer;

architecture Behavioral of Stack_integer is

begin


end Behavioral;

