--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:12:20 04/02/2016
-- Design Name:   
-- Module Name:   C:/Users/Harshal Mahajan/Downloads/Daylast/Dsd/tb3.vhd
-- Project Name:  Dsd
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Stack_integer
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
 
ENTITY tb3 IS
END tb3;
 
ARCHITECTURE behavior OF tb3 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Stack_integer
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         wr_en : IN  std_logic;
         rd_en : IN  std_logic;
         pop : IN  std_logic;
         din : IN  INTEGER;
         dout : OUT  INTEGER;
         full : OUT  std_logic;
         empty : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal wr_en : std_logic := '0';
   signal rd_en : std_logic := '0';
   signal pop : std_logic := '0';
   signal din : INTEGER := 0;

 	--Outputs
   signal dout : iNTEGER :=0;
   signal full : std_logic;
   signal empty : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Stack_integer PORT MAP (
          clock => clock,
          reset => reset,
          wr_en => wr_en,
          rd_en => rd_en,
          pop => pop,
          din => din,
          dout => dout,
          full => full,
          empty => empty
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
      wait for clock_period*3; --wait for 3 clock periods(simply)
		wait for clock_period/2;
        rd_en <= '1';  --Enable the stack.
        wr_en <= '1'; --Set for push operation.
        for i in 0 to 10 loop  --Push integers from 0 to 255 to the stack.
            din <= I;
            wait for clock_period;
        end loop;
        rd_en <= '0';  --disable the stack.
		  wr_en <= '0';
        wait for clock_period*2;
        for i in 0 to 11 loop  --POP all elements from stack one by one.
				RD_EN <= '0';
				pop <= '1';  --Set for POP operation.
            wait for clock_period;
				POP <= '0';
				RD_EN <= '1';
				WAIT FOR CLOCK_PERIOD*2;
        end loop;   
        rd_en <= '0'; --Disable stack.
        pop <= '0';
        wait for clock_period*3;
      -- insert stimulus here 

      wait;
   end process;

END;
