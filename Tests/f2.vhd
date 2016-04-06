--ANSWER TO THIS TEST BENCH
--{cnf_12: True, cnf_16: True, cnf_6: True, cnf_13: True, cnf_2: False, cnf_9: True, cnf_10: False, cnf_11: False, cnf_4: False, cnf_14: False, cnf_8: True, cnf_3: True, cnf_1: True, cnf_7: True, cnf_15: False, cnf_5: True}
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
         i : IN  std_logic_vector(15 downto 0);
         ended : OUT  std_logic;
         sat : OUT  std_logic;
         model : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal load : std_logic := '0';
   signal i : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal ended : std_logic;
   signal sat : std_logic;
   signal model : std_logic_vector(15 downto 0);

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

i <= "1000000010000000";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0101000000000000";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0100000000000001";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0011000000000000";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0000110000000000";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0000001100000000";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0000000001100000";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0000000000001100";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0000010000000000";
wait for clock_period;
i <= "0000001000000000";
wait for clock_period;
i <= "0000000000010000";
wait for clock_period;
i <= "0000000000001000";
wait for clock_period;
i <= "0000000000001000";
wait for clock_period;
i <= "0000000000000100";
wait for clock_period;
i <= "0000000000000100";
wait for clock_period;
i <= "0000000100000000";
wait for clock_period;
i <= "0000000000000010";
wait for clock_period;
i <= "0000000000000001";
wait for clock_period;
i <= "0000000000000001";
wait for clock_period;
i <= "0100000000000000";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0110000000000000";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0000010000000010";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0000000010100000";
wait for clock_period;
i <= "0000000000000000";
wait for clock_period;
i <= "0000000000110000";
wait for clock_period;

load <= '0';
     
      -- insert stimulus here 

      wait;
   end process;

END;
