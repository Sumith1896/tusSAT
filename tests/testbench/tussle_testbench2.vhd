--ANSWER TO THIS TEST BENCH
--{c: False, b: False, e: False, d: False, a: False, g: True, f: True}
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
         i : IN  std_logic_vector(6 downto 0);
         ended : OUT  std_logic;
         sat : OUT  std_logic;
         model : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal load : std_logic := '0';
   signal i : std_logic_vector(6 downto 0) := (others => '0');

 	--Outputs
   signal ended : std_logic;
   signal sat : std_logic;
   signal model : std_logic_vector(6 downto 0);

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

i <= "0000010";
wait for clock_period;
i <= "0000001";
wait for clock_period;
i <= "0000001";
wait for clock_period;
i <= "0000010";
wait for clock_period;
i <= "1100010";
wait for clock_period;
i <= "0000000";
wait for clock_period;
i <= "0010010";
wait for clock_period;
i <= "1000000";
wait for clock_period;
i <= "0001010";
wait for clock_period;
i <= "0100000";
wait for clock_period;
i <= "0000110";
wait for clock_period;
i <= "0010000";
wait for clock_period;
i <= "0000010";
wait for clock_period;
i <= "0101000";
wait for clock_period;
i <= "0000010";
wait for clock_period;
i <= "0010100";
wait for clock_period;

load <= '0';
     
      -- insert stimulus here 

      wait;
   end process;

END;
