--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:25:25 04/06/2016
-- Design Name:   
-- Module Name:   /home/shubham/DLD/Project/controller1/testb_PL_UC.vhd
-- Project Name:  controller1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: testing_PL_UC
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
 
ENTITY testb_PL_UC IS
END testb_PL_UC;
 
ARCHITECTURE behavior OF testb_PL_UC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT testing_PL_UC
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         load : IN  std_logic;
         i : IN  std_logic_vector(3 downto 0);
         ended : OUT  std_logic;
         sat : OUT  std_logic;
         model : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal load : std_logic := '0';
   signal i : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ended : std_logic;
   signal sat : std_logic;
   signal model : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: testing_PL_UC PORT MAP (
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
--      wait for 100 ns;	
--
--      wait for clock_period*10;
--		wait for 100 ns;	
--reset <= '1';
--wait for 2*clock_period;
--reset <= '0';
--load<='1';
--i<="1";
--wait for clock_period;
--load<='1';
--i<="0";
--wait for clock_period;
--load<='1';
--i<="1";
--wait for clock_period;
--load<='1';
--i<="0";
--wait for clock_period;
--load<='0';

-- 1 X 1
-- Ans  A:true
      -- insert stimulus here 
		wait for 100 ns;	
		reset <= '1';

    --wait for clock_period/2;
		wait for 2*clock_period;
		reset <= '0';
		load<='1';
		i<="1000";
		wait for clock_period;
		load<='1';
		i<="0000";
      wait for clock_period;
		load<='1';
		i<="0100";
		wait for clock_period;
		load<='1';
		i<="0000";
     
		wait for clock_period;
		load<='0';
		
      wait;
   end process;

END;
