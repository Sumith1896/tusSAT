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
load => IP_load,
i => IP_i,
formula_res => IP_formula_res,
ended => IP_ended
);

end Behavioral;

