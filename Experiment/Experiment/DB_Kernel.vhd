----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:41:02 04/05/2016 
-- Design Name: 
-- Module Name:    DB_Kernel - Behavioral 
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
use work.common.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DB_Kernel is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           find : in  STD_LOGIC;
           in_formula : in  formula;
           ended : out  STD_LOGIC;
           out_formula : out  formula;
           sat : out  STD_LOGIC;
           unsat : out  STD_LOGIC;
           propagating : out  STD_LOGIC;
           out_lit: out  lit);
end DB_Kernel;

architecture Behavioral of DB_Kernel is

component Unit_Clause is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           find : in  STD_LOGIC;
           in_formula : in  formula;
           ended : out  STD_LOGIC;
           found : out  STD_LOGIC;
           lit_found : out  lit);
end component;


component Propagate_Literal is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           find : in  STD_LOGIC;
           in_formula : in  formula;
           in_lit : in  lit;
           ended : out  STD_LOGIC;
           empty_clause : out  STD_LOGIC;
           empty_formula : out  STD_LOGIC;
           out_formula : out  formula);
end component;

component Pure_Literal is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           find : in  STD_LOGIC;
           in_formula : in  formula;
           ended : out  STD_LOGIC;
           found : out  STD_LOGIC;
           lit_found : out  lit);
end component;

signal s_in_formula : formula := ZERO_FORMULA;
signal s_out_formula : formula := ZERO_FORMULA;
signal s_out_lit : lit := ZERO_LIT;
--signal s_ended : STD_LOGIC := '1';
signal s_sat : STD_LOGIC := '0';
signal s_unsat : STD_LOGIC := '0';

signal s_finding : STD_LOGIC := '0';
signal s_temp_found : STD_LOGIC := '0';
signal C : lit := ZERO_LIT;

type state is (UC_b,UC_r,UC_e,PL_b,PL_r,PL_e,PROP_b,PROP_r,PROP_e,IDLE);
signal present_state : state := IDLE;
signal called_from_state : state := IDLE;

signal UC_lit_found : lit := ZERO_LIT;
signal UC_find : STD_LOGIC := '0';
signal UC_ended : STD_LOGIC := '0';
signal UC_found : STD_LOGIC := '0';

signal PL_lit_found : lit := ZERO_LIT;
signal PL_find : STD_LOGIC := '0';
signal PL_ended : STD_LOGIC := '0';
signal PL_found : STD_LOGIC := '0';

signal PropL_find : STD_LOGIC := '0';
signal PropL_in_lit : lit := ZERO_LIT;
signal PropL_ended : STD_LOGIC := '0';
signal PropL_empty_clause : STD_LOGIC := '0';
signal PropL_empty_formula : STD_LOGIC := '0';
signal PropL_out_formula : formula := ZERO_FORMULA;

begin

out_formula <= s_in_formula;
out_lit <= C;

UC : Unit_Clause
  port map(
    clock => clock,
    reset => reset,
    find => UC_find,
    in_formula => s_in_formula,
    ended => UC_ended,
    found => UC_found,
    lit_found => UC_lit_found
    );

PL : Pure_Literal
  port map(
    clock => clock,
    reset => reset,
    find => PL_find,
    in_formula => s_in_formula,
    ended => PL_ended,
    found => PL_found,
    lit_found => PL_lit_found
    );

PropL : Propagate_Literal
  port map(
    clock => clock,
    reset => reset,
    find => PropL_find,
    in_formula => s_in_formula,
    in_lit => PropL_in_lit,
    ended => PropL_ended,
    empty_clause => PropL_empty_clause,
    empty_formula => PropL_empty_formula,
    out_formula => PropL_out_formula
    );

process(clock,reset)
begin
if reset='1' then
  ended <= '1';
  sat <= '0';
  unsat <= '0';
  out_formula <= ZERO_FORMULA;
  propagating <= '0';
  out_lit <= ZERO_LIT;

  s_in_formula <= ZERO_FORMULA;
  s_finding <= '0';
  present_state <= IDLE;
  called_from_state <= IDLE;

  UC_find <= '0';
  PL_find <= '0';

  PropL_find <= '0';
  PropL_in_lit <= ZERO_LIT;

elsif rising_edge(clock) then

 if find='1' and s_finding = '0' then
    s_in_formula <= in_formula;
    s_finding <= '1';
    ended <= '0';
    present_state <= UC_b;
    ended <= '0';
    sat <= '0';
    unsat <= '0';
    out_formula <= ZERO_FORMULA;
    propagating <= '0';
    out_lit <= ZERO_LIT;
 elsif s_finding = '1' then
    ended <= '0';
    propagating <= '0';
    case( present_state ) is
      
      when UC_b =>
        UC_find <= '1';
        present_state <= UC_r;
      
      when UC_r =>
        if UC_ended = '1' then
          C <= UC_lit_found;
          s_temp_found <= UC_found;
          present_state <= UC_e;
        end if ;

      when UC_e => 
        if(s_temp_found = '1') then
          called_from_state <= UC_b;
          present_state <= PROP_b;
        else
          present_state <= PL_b;
        end if;

      when PROP_b =>
        PropL_find <= '1';
        propagating <= '1';
        out_lit <= C;
        present_state <= PROP_r;

      when PROP_r =>
        if PropL_ended = '1' then
          s_sat <= PropL_empty_formula;
          s_unsat <= PropL_empty_clause;
          s_in_formula <= PropL_out_formula;
          present_state <= PROP_e;
        end if ;

      when PROP_e =>
        if s_sat = '1' then
          -- RETURN SAT
          ended <= '1';
          sat <= '1';
          unsat <= '0';
          propagating <= '0';
          out_formula <= s_in_formula;
          --out_lit <= ZERO_LIT;
        elsif s_unsat = '1' then
          -- RETURN UNSAT
          ended <= '1';
          sat <= '0';
          unsat <= '1';
          propagating <= '0';
          out_formula <= s_in_formula;
          --out_lit <= ZERO_LIT;
        else
            present_state <= called_from_state;
        end if;

      when PL_b =>
        PL_find <= '1';
        present_state <= PL_r;
      
      when PL_r =>
        if PL_ended = '1' then
          C <= PL_lit_found;
          s_temp_found <= PL_found;
          present_state <= PL_e;
        end if ;

      when PL_e => 
        if(s_temp_found = '1') then
          called_from_state <= PL_b;
          present_state <= PROP_b;
        else
          --RETURN
          ended <= '1';
          sat <= '0';
          unsat <= '0';
          propagating <= '0';
          out_formula <= s_in_formula;
          --out_lit <= ZERO_LIT;

          present_state <= IDLE;
        end if;

      when IDLE =>
        present_state <= IDLE;
    end case ;
  end if;
end if;
end process;

end Behavioral;

