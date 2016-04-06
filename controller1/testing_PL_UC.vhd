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

entity testing_PL_UC is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           i : in  STD_LOGIC_VECTOR((number_literals-1) downto 0);
           ended : out  STD_LOGIC;
           sat : out  STD_LOGIC;
           model : out  STD_LOGIC_VECTOR((number_literals-1) downto 0));
end testing_PL_UC;

architecture Behavioral of testing_PL_UC is
	
component read_store is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           i : in  STD_LOGIC_VECTOR((number_literals-1) downto 0);
           formula_res: out formula;
           ended: out STD_LOGIC);
end component;

component Unit_Clause is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           find : in  STD_LOGIC;
           in_formula : in  formula;
           ended : out  STD_LOGIC;
           found : out  STD_LOGIC;
           lit_found : out  lit);
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


type state is (IDLE, BEFORE_INP, INPING, BACTRACK_POPDB_STACK, BACKTRACK_POPLIT_STACK, NEGATE_BEFORE_PROP, BEFORE_POPULATE_STACK, 
              POPULATE_STACK, BEFORE_PROP, PROPAGATING, AFTER_PROP, BEFORE_KERNELIZE, KERNELIZING, AFTER_KERNELIZE,
              BEFORE_DB, DBING, AFTER_DB, UNSAT, RETURN_MODEL, FILL_VECT, SAT_RETURN, PROPAGATE);
signal present_state : state := BEFORE_INP;

signal IP_load :  STD_LOGIC;
signal IP_i : STD_LOGIC_VECTOR((number_literals-1) downto 0);
signal IP_formula_res: formula;
signal IP_ended: STD_LOGIC;


signal UC_lit_found : lit := ZERO_LIT;
signal UC_find : STD_LOGIC := '0';
signal UC_ended : STD_LOGIC := '0';
signal UC_found : STD_LOGIC := '0';

signal PL_lit_found : lit := ZERO_LIT;
signal PL_find : STD_LOGIC := '0';
signal PL_ended : STD_LOGIC := '0';
signal PL_found : STD_LOGIC := '0';

signal Kernel_find : STD_LOGIC;
signal Kernel_in_formula : formula;
signal Kernel_ended : STD_LOGIC;
signal Kernel_out_formula : formula;
signal Kernel_sat : STD_LOGIC;
signal Kernel_unsat : STD_LOGIC;
signal Kernel_propagating : STD_LOGIC;
signal Kernel_out_lit: lit;

signal F : formula;
signal C : lit;
signal to_populate : lit;
signal to_prop : lit;
signal output_vect : STD_LOGIC_VECTOR((number_literals-1) downto 0);
signal temp_sat : STD_LOGIC;
signal temp_unsat : STD_LOGIC;
signal next_Backtrack : STD_LOGIC;

signal s_in_formula : formula;
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
--  to_populate<= zero_lit;
--  to_prop<= zero_lit;
--  output_vect<= (others => '0');
--  temp_sat<= '0';
--  temp_unsat<= '0';
--  next_Backtrack<= '0';
  Kernel_find <= '0';
  Kernel_in_formula <= zero_formula;
--  DB_find <= '0';
--  DB_formula_in <= zero_formula;
--  Prop_find <= '0';
--  Prop_in_formula <= zero_formula;
--  Prop_in_lit <= zero_lit;
--  Lit_St_wr_en <= '0';
--  Lit_St_pop <= '0';
--  Lit_St_din <= zero_lit;
--  DV_St_wr_en <= '0';
--  DV_St_pop <= '0';
--  DV_St_din <= zero_lit;
--  Formula_St_wr_en <= '0';
--  Formula_St_pop <= '0';
--  Formula_St_din <= zero_formula;
--  Backtrack_St_wr_en <= '0';
--  Backtrack_St_pop <= '0';
--  Backtrack_St_din <= '0';

elsif rising_edge(clock) then
  Kernel_find <= '0';
--  DB_find <= '0';
--  Prop_find <= '0';
--  Lit_St_wr_en <= '0';
--  Lit_St_pop <= '0';
--  DV_St_wr_en <= '0';
--  DV_St_pop <= '0';
--  Formula_St_wr_en <= '0';
--  Formula_St_pop <= '0';
--  Backtrack_St_wr_en <= '0';
--  Backtrack_St_pop <= '0';

    	PL_find <= '0';
    	UC_find <= '0';
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
    	s_in_formula <= F;
      Kernel_in_formula <= F;
    	PL_find <= '1';
    	UC_find <= '1';
      Kernel_find <= '1';
      present_state <= IDLE;

    when OTHERS =>
    	present_state <= IDLE;
	 end case;
	 end if;
	end process;

end Behavioral;