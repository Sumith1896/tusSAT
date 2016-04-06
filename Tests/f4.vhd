--ANSWER TO THIS TEST BENCH
--False
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:09:58 04/06/2016
-- Design Name:   
-- Module Name:   /home/sumith1896/sandbox/controller/testing101.vhd
-- Project Name:  controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: controller
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testing101 IS
END testing101;
 
ARCHITECTURE behavior OF testing101 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT controller
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         load : IN  std_logic;
         i : IN  std_logic_vector(41 downto 0);
         ended : OUT  std_logic;
         sat : OUT  std_logic;
         model : OUT  std_logic_vector(41 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal load : std_logic := '0';
   signal i : std_logic_vector(41 downto 0) := (others => '0');

 	--Outputs
   signal ended : std_logic;
   signal sat : std_logic;
   signal model : std_logic_vector(41 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controller PORT MAP (
          clock => clock,
          reset => reset,
          load => load,
          i => i,
          ended => ended,
          sat => sat,
          model => model
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
wait for 100 ns;  
reset <= '1';
wait for 2*clock_period;
reset <= '0';

load <= '1';

i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "100010000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "100000000010000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "100000000000000001000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "100000000000000000000000100000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "100000000000000000000000000000100000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "100000000000000000000000000000000000000100";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "010000010000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "010000000000001000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "010000000000000000001000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "010000000000000000000000000100000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "010000000000000000000000000000000100000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "010000000000000000000000000000000010000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "001000001000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "001000000000000100000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "001000000000000000000100000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "001000000000000000000000000010000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "001000000000000000000000000000000001000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "001000000000000000000000000000000000010000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000100000100000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000100000000000010000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000100000000000000000001000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000100000000000000000000000001000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000100000000000000000000000000000000100000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000100000000000000000000000000000000001000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000010000010000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000010000000000001000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000010000000000000000000100000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000010000000000000000000000000100000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000010000000000000000000000000000000000100";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000001000001000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000001000000100000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000001000000000000100000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000001000000000000000000010000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000001000000000000000000000000010000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000001000000000000000000000000000000000010";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000100000010000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000100000000000010000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000100000000000000010000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000100000000000000000001000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000100000000000000000000000001000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000100000000000000000000000000000000001";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000010000001000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000010000000000001000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000010000000000000000000100000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000010000000000000000000000000100000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000010000000000000000000000000010000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000001000000100000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000001000000000000100000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000001000000000000000000010000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000001000000000000000000000000001000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000001000000000000000000000000000010000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000100000010000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000100000000000001000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000100000000000000000001000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000100000000000000000000000000100000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000100000000000000000000000000001000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000010000001000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000010000000000000100000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000010000000000000000000100000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000010000000000000000000000000000100";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000001100000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000001000000100000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000001000000000000010000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000001000000000000000000010000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000001000000000000000000000000000010";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000100000100000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000100000000000010000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000100000000000000000010000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000100000000000000000000000000010";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000010000010000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000010000000010000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000010000000000001000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000010000000000000000001000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000010000000000000000000000000001";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000001000001000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000001000000000000100000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000001000000000000000000100000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000001000000000000000000010000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000100000100000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000100000000000010000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000100000000000000000001000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000100000000000000000000010000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000010000001000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000010000000000001000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000010000000000000000000100000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000010000000000000000000001000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000001000000100000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000001000000000000100000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000001000000000000000000000100";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000100000010000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000100000000000010000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000100000000000000000000010";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000010010000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000010000001000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000010000000000001000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000010000000000000000000001";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000001000000100000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000001000000000000100000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000001000000000000010000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000100000010000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000100000000000001000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000100000000000000010000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000010001000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000010000000001000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000010000000000000000001";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000001000001000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000001000000000000100000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000001000000000000001000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000100000100000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000100000000000000100";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000010000010000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000010000000000000010";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000001000001000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000001000000000000001";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000100000100000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000100000010000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000010000001000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000010000000010000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000001000000100000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000001000000001000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000100000000100";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000010000000010";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000001000000001";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000110000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000001010000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000101000";
wait for clock_period;
i <= "100000000001000000000010000000000100011000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "011100000000000000000000000000000000000111";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000011111100000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000010111110000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000001111101000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000111111000000000000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;
i <= "000000000000000000000000000000111011100000";
wait for clock_period;
i <= "000000000000000000000000000000000000000000";
wait for clock_period;

load <= '0';
     
      -- insert stimulus here 

      wait;
   end process;

END;