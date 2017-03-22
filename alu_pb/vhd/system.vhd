library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library lib_nanoproc;
use lib_nanoproc.nano_pkg.all;

entity system is
port(	clk : in std_logic;
	reset : in std_logic;
	alu_code : in std_logic_vector( 1 downto 0 );
	hex_op1 : out std_logic_vector( 6 downto 0 );
	hex_op2 : out std_logic_vector( 6 downto 0 );
	hex_res : out std_logic_vector( 6 downto 0 );
	key_up_op1_b : in std_logic;
	key_up_op2_b : in std_logic;
	key_down_op1_b : in std_logic;
	key_down_op2_b : in std_logic
);
end entity;

	
architecture arch_fct of system is

component ALU
port ( 	a,b : in std_logic_vector(len_data_bus-1 downto 0);
	alu_code : in std_logic_vector(1 downto 0);
	r : out std_logic_vector(len_data_bus-1 downto 0));
end component;

component key_sm 
generic ( resolution : integer := 4
);
port ( 	clk : in std_logic;
	reset : in std_logic;
	key_up : in std_logic;
	key_down : in std_logic;
	val : out std_logic_vector( resolution-1 downto 0 )	
);
end component;

component ROM_DIGIT
port (	digit : in std_logic_vector(3 downto 0) ;
	output  : out std_logic_vector(6 downto 0) ) ;
end component;


signal alu_op1, alu_op2, alu_res : std_logic_vector( 3 downto 0 );
signal	key_up_op1, key_up_op2, key_down_op1, key_down_op2 : std_logic;



begin


key_up_op1 <= not key_up_op1_b;
key_up_op2 <= not key_up_op2_b;
key_down_op1 <= not key_down_op1_b;
key_down_op2 <= not key_down_op2_b;


inst_alu : alu port map (
	a => alu_op1,
	b => alu_op2,
	alu_code => alu_code,
	r => alu_res
);

inst_hex_op1 : ROM_DIGIT port map (
	digit => alu_op1,
	output => hex_op1
);

inst_hex_op2 : ROM_DIGIT port map (
	digit => alu_op2,
	output => hex_op2
);

inst_hex_res : ROM_DIGIT port map (
	digit => alu_res,
	output => hex_res
);

inst_key_fsm_op1 : key_sm generic map (
	resolution => 4
)
port map (
	clk => clk,
	reset => reset,
	key_up => key_up_op1,
	key_down => key_down_op1,
	val => alu_op1
);

inst_key_fsm_op2 : key_sm generic map (
	resolution => 4
)
port map (
	clk => clk,
	reset => reset,
	key_up => key_up_op2,
	key_down => key_down_op2,
	val => alu_op2
);

end architecture;
