----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:26:00 04/05/2016 
-- Design Name: 
-- Module Name:    controller - Behavioral 
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
use work.common.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           i : in  STD_LOGIC_VECTOR((number_literals-1) downto 0);
           ended : out  STD_LOGIC;
           sat : out  STD_LOGIC;
           model : out  STD_LOGIC_VECTOR((number_literals-1) downto 0));
end controller;

architecture Behavioral of controller is

component DB_Kernel is
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
end component;

component decide_branch is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           find : in  STD_LOGIC;
           formula_in : in  formula;
           ended : out  STD_LOGIC;
           lit_out : out  lit);
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

component Stack_integer is		
	Port ( clock : in  STD_LOGIC;
         reset : in  STD_LOGIC;
         wr_en : in  STD_LOGIC;
         pop : in  STD_LOGIC;
         din : in  lit;
         dout : out  lit;
         front : out lit;
         full : out  STD_LOGIC;
         empty : out  STD_LOGIC);
end component;

component Stack_formula is
	Port ( clock : in  STD_LOGIC;
         reset : in  STD_LOGIC;
         wr_en : in  STD_LOGIC;
         pop : in  STD_LOGIC;
         din : in  formula;
         dout : out  formula;
         front : out formula;
         full : out  STD_LOGIC;
         empty : out  STD_LOGIC);
end component;

component Stack_bool is
	Port ( clock : in  STD_LOGIC;
         reset : in  STD_LOGIC;
         wr_en : in  STD_LOGIC;
         pop : in  STD_LOGIC;
         din : in  STD_LOGIC;
         dout : out  STD_LOGIC;
         front : out STD_LOGIC;
         full : out  STD_LOGIC;
         empty : out  STD_LOGIC);
end component;

component read_store is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           i : in  STD_LOGIC_VECTOR((number_literals-1) downto 0);
           formula_res: out formula;
           ended: out STD_LOGIC);
end component;

type state is (IDLE, BEFORE_INP, INPING, BACTRACK_POPDB_STACK, BACKTRACK_POPLIT_STACK, NEGATE_BEFORE_PROP, BEFORE_POPULATE_STACK, 
              POPULATE_STACK, BEFORE_PROP, PROPAGATING, AFTER_PROP, BEFORE_KERNELIZE, KERNELIZING, AFTER_KERNELIZE,
              BEFORE_DB, DBING, AFTER_DB, UNSAT, RETURN_MODEL, FILL_VECT, SAT_RETURN, PROPAGATE);
signal present_state : state := BEFORE_INP;
--signal called_from_state : state := IDLE;

signal Kernel_find : STD_LOGIC;
signal Kernel_in_formula : formula;
signal Kernel_ended : STD_LOGIC;
signal Kernel_out_formula : formula;
signal Kernel_sat : STD_LOGIC;
signal Kernel_unsat : STD_LOGIC;
signal Kernel_propagating : STD_LOGIC;
signal Kernel_out_lit: lit;

signal DB_find : STD_LOGIC;
signal DB_formula_in : formula;
signal DB_ended : STD_LOGIC;
signal DB_lit_out : lit;

signal Prop_find : STD_LOGIC;
signal Prop_in_formula : formula;
signal Prop_in_lit : lit;
signal Prop_ended : STD_LOGIC;
signal Prop_empty_clause : STD_LOGIC;
signal Prop_empty_formula : STD_LOGIC;
signal Prop_out_formula : formula;

signal Lit_St_wr_en : STD_LOGIC;
signal Lit_St_pop : STD_LOGIC;
signal Lit_St_din : lit;
signal Lit_St_dout :  lit;
signal Lit_St_front : lit;
signal Lit_St_full :  STD_LOGIC;
signal Lit_St_empty :  STD_LOGIC;

signal DV_St_wr_en : STD_LOGIC;
signal DV_St_pop : STD_LOGIC;
signal DV_St_din : lit;
signal DV_St_dout :  lit;
signal DV_St_front : lit;
signal DV_St_full :  STD_LOGIC;
signal DV_St_empty :  STD_LOGIC;

signal Formula_St_wr_en : STD_LOGIC;
signal Formula_St_pop : STD_LOGIC;
signal Formula_St_din : formula;
signal Formula_St_dout :  formula;
signal Formula_St_front : formula;
signal Formula_St_full :  STD_LOGIC;
signal Formula_St_empty :  STD_LOGIC;

signal Backtrack_St_wr_en : STD_LOGIC;
signal Backtrack_St_pop : STD_LOGIC;
signal Backtrack_St_din : STD_LOGIC;
signal Backtrack_St_dout :  STD_LOGIC;
signal Backtrack_St_front : STD_LOGIC;
signal Backtrack_St_full :  STD_LOGIC;
signal Backtrack_St_empty :  STD_LOGIC;

signal IP_load :  STD_LOGIC;
signal IP_i : STD_LOGIC_VECTOR((number_literals-1) downto 0);
signal IP_formula_res: formula;
signal IP_ended: STD_LOGIC;

signal F : formula;
signal C : lit;
signal to_populate : lit;
signal to_prop : lit;
signal output_vect : STD_LOGIC_VECTOR((number_literals-1) downto 0);
signal temp_sat : STD_LOGIC;
signal temp_unsat : STD_LOGIC;
signal next_Backtrack : STD_LOGIC;

begin

Kernel : DB_Kernel
port map(
clock => clock,
reset => reset,
find => Kernel_find,
in_formula => Kernel_in_formula,
ended => Kernel_ended,
out_formula => Kernel_out_formula,
sat => Kernel_sat,
unsat => Kernel_unsat,
propagating => Kernel_propagating,
out_lit => Kernel_out_lit
);

DB : decide_branch
port map(
clock => clock,
reset => reset,
find => DB_find,
formula_in => DB_formula_in,
ended => DB_ended,
lit_out => DB_lit_out
);

Prop : Propagate_Literal
port map(
clock => clock,
reset => reset,
find => Prop_find,
in_formula => Prop_in_formula,
in_lit => Prop_in_lit,
ended => Prop_ended,
empty_clause => Prop_empty_clause,
empty_formula => Prop_empty_formula,
out_formula => Prop_out_formula
);

Lit_St : Stack_integer
port map(
clock => clock,
reset => reset,
wr_en => Lit_St_wr_en,
pop => Lit_St_pop,
din => Lit_St_din,
dout => Lit_St_dout,
front => Lit_St_front,
full => Lit_St_full,
empty => Lit_St_empty
);

DV_St : Stack_integer
port map(
clock => clock,
reset => reset,
wr_en => DV_St_wr_en,
pop => DV_St_pop,
din => DV_St_din,
dout => DV_St_dout,
front => DV_St_front,
full => DV_St_full,
empty => DV_St_empty
);

Formula_St : Stack_formula
port map(
clock => clock,
reset => reset,
wr_en => Formula_St_wr_en,
pop => Formula_St_pop,
din => Formula_St_din,
dout => Formula_St_dout,
front => Formula_St_front,
full => Formula_St_full,
empty => Formula_St_empty
);

Backtrack_St : Stack_bool
port map(
clock => clock,
reset => reset,
wr_en => Backtrack_St_wr_en,
pop => Backtrack_St_pop,
din => Backtrack_St_din,
dout => Backtrack_St_dout,
front => Backtrack_St_front,
full => Backtrack_St_full,
empty => Backtrack_St_empty
);

IP : read_store
port map(
clock => clock,
reset => reset,
load => load,
i => i,
formula_res => IP_formula_res,
ended => IP_ended
);

process(clock,reset)
begin
if reset='1' then
  ended <= '0';
  sat <= '0';
  model <= (others => '0');
  F <= zero_formula;
  C<= zero_lit;
  to_populate<= zero_lit;
  to_prop<= zero_lit;
  output_vect<= (others => '0');
  temp_sat<= '0';
  temp_unsat<= '0';
  next_Backtrack<= '0';
  Kernel_find <= '0';
  Kernel_in_formula <= zero_formula;
  DB_find <= '0';
  DB_formula_in <= zero_formula;
  Prop_find <= '0';
  Prop_in_formula <= zero_formula;
  Prop_in_lit <= zero_lit;
  Lit_St_wr_en <= '0';
  Lit_St_pop <= '0';
  Lit_St_din <= zero_lit;
  DV_St_wr_en <= '0';
  DV_St_pop <= '0';
  DV_St_din <= zero_lit;
  Formula_St_wr_en <= '0';
  Formula_St_pop <= '0';
  Formula_St_din <= zero_formula;
  Backtrack_St_wr_en <= '0';
  Backtrack_St_pop <= '0';
  Backtrack_St_din <= '0';

elsif rising_edge(clock) then
  Kernel_find <= '0';
  DB_find <= '0';
  Prop_find <= '0';
  Lit_St_wr_en <= '0';
  Lit_St_pop <= '0';
  DV_St_wr_en <= '0';
  DV_St_pop <= '0';
  Formula_St_wr_en <= '0';
  Formula_St_pop <= '0';
  Backtrack_St_wr_en <= '0';
  Backtrack_St_pop <= '0';

  case(present_state) is
    when BEFORE_INP =>
      if load = '1' then
        present_state <= INPING;
      end if;
    
    when INPING =>
      if IP_ended = '1' then
        F <= IP_formula_res;
        present_state <= BEFORE_KERNELIZE;
      end if;

    when BEFORE_KERNELIZE=>
      Kernel_in_formula <= F;
      Kernel_find <= '1';
      present_state <= KERNELIZING;

    when KERNELIZING =>
      if (Kernel_ended = '1') then
        F <= Kernel_out_formula;
        temp_sat <= Kernel_sat;
        temp_unsat <= Kernel_unsat;
        present_state <= AFTER_KERNELIZE;
      elsif Kernel_propagating = '1' then
        Lit_St_din <= Kernel_out_lit;
        Lit_St_wr_en <= '1';
      end if;

    when AFTER_KERNELIZE =>
      if temp_sat = '1' then
        present_state <= RETURN_MODEL;
      elsif temp_unsat = '1' then
        present_state <= BACTRACK_POPDB_STACK;
      else
        present_state <= BEFORE_DB;        
      end if ;

    when BACTRACK_POPDB_STACK => 
      if(Backtrack_St_empty = '1') then
        present_state <= UNSAT;
      elsif(Backtrack_St_front = '1') then
        Backtrack_St_pop <= '1';
        DV_St_pop <= '1';
        Formula_St_pop <= '1';
      else
        present_state <= BACKTRACK_POPLIT_STACK;
      end if;

    when BACKTRACK_POPLIT_STACK =>
      if(Lit_St_front /= DV_St_front) then
        Lit_St_pop <= '1';
      else
        Lit_St_pop <= '1';
        C <= DV_St_front;
        DV_St_pop <= '1';
        Backtrack_St_pop <= '1';
        F <= Formula_St_front;
        Formula_St_pop <= '1';
        present_state <= NEGATE_BEFORE_PROP;
      end if;

    when NEGATE_BEFORE_PROP =>
      C.val <= not C.val;
      next_Backtrack <= '1';
      present_state <= PROPAGATE;

    when PROPAGATE =>
      to_populate <= C;
      present_state <= BEFORE_POPULATE_STACK;

    when BEFORE_POPULATE_STACK =>
      Formula_St_din <= F;
      Backtrack_St_din <= next_Backtrack;
      DV_St_din <= C;
      Lit_St_din <= C;
      present_state <= POPULATE_STACK;
    
    when POPULATE_STACK =>
      DV_St_wr_en <= '1';
      Lit_St_wr_en <= '1';
      Backtrack_St_wr_en <= '1'; 
      Formula_St_wr_en <= '1';
      C <= to_populate;
      present_state <= BEFORE_PROP;

    when BEFORE_PROP => 
      Prop_find <= '1';
      to_prop <= C;
      present_state <= PROPAGATING;

    when PROPAGATING =>
      if(Prop_ended = '1') then
        F <= Prop_out_formula;
        temp_sat <= Prop_empty_formula;
        temp_unsat <= Prop_empty_clause;
        present_state <= AFTER_PROP;
      end if;

    when AFTER_PROP =>
      if(temp_sat = '1') then
        present_state <= RETURN_MODEL;
      elsif(temp_unsat = '1') then
        present_state <= BACTRACK_POPDB_STACK;
      else
        present_state <= BEFORE_KERNELIZE;
      end if;

    when BEFORE_DB => 
      DB_formula_in <= F;
      DB_find <= '1';
      present_state <= DBING;

    when DBING => 
      if DB_ended = '1' then
        C <= DB_lit_out;
        next_Backtrack <= '0';
        present_state <= AFTER_DB;
      end if ;

    when AFTER_DB =>
      to_populate <= C;
      present_state <= BEFORE_POPULATE_STACK;

    when UNSAT => 
      ended <= '1';
      sat <= '0';

    when RETURN_MODEL =>
      output_vect <= (others => '0');
      present_state <= FILL_VECT;

    when FILL_VECT =>
      if Lit_St_empty = '0' then
        output_vect(Lit_St_front.num) <= Lit_St_front.val;
        Lit_St_pop <= '1';
      else
        present_state <= SAT_RETURN;
      end if ;

    when SAT_RETURN =>
      ended <= '1';
      sat <= '1';
      model <= output_vect;

    when OTHERS =>
      present_state <= IDLE;

  end case ;
end if;
end process;

end Behavioral;

