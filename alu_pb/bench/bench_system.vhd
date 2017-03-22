library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

library lib_nanoproc;
use lib_nanoproc.all;
USE lib_nanoproc.nano_pkg.all;


entity bench_system is
end bench_system;

architecture a of bench_system is

constant CLOCK_PERIOD : time := 20 ns;

function seven_seg_to_int(
	seven_seg : std_logic_vector( 6 downto 0 )
) return integer is
begin
	case seven_seg is
		when "1000000" => return( 0 );
		when "1111001" => return( 1 );
		when "0100100" => return( 2 );
		when "0110000" => return( 3 );
		when "0011001" => return( 4 );
		when "0010010" => return( 5 );
		when "0000010" => return( 6 );
		when "1111000" => return( 7 );
		when "0000000" => return( 8 );
		when "0010000" => return( 9 );
		when "0001000" => return( 10 );
		when "0000011" => return( 11 );
		when "1000110" => return( 12 );
		when "0100001" => return( 13 );
		when "0000110" => return( 14 );
		when "0001110" => return( 15 );
		when others => return( 0 );
	end case;
end function;


component system
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
end component;

-- signaux d'interface du systeme
signal clk : std_logic := '0';
signal reset : std_logic;
signal alu_code :  std_logic_vector( 1 downto 0 );
signal hex_op1 : std_logic_vector( 6 downto 0 );
signal hex_op2 : std_logic_vector( 6 downto 0 );
signal hex_res : std_logic_vector( 6 downto 0 );
signal key_up_op1_b : std_logic;
signal key_up_op2_b : std_logic;
signal key_down_op1_b : std_logic;
signal key_down_op2_b : std_logic;

-- signaux utilises pour visualiser les afficheurs
signal int_hex_op1,int_hex_op2,int_hex_res : integer;


begin

inst_system : system port map (
	clk => clk, 
	reset => reset,
	alu_code => alu_code,
	hex_op1 => hex_op1,
	hex_op2 => hex_op2,
	hex_res => hex_res,
	key_up_op1_b => key_up_op1_b,
	key_up_op2_b => key_up_op2_b,
	key_down_op1_b => key_down_op1_b,
	key_down_op2_b => key_down_op2_b
);


int_hex_op1 <= seven_seg_to_int( hex_op1 );
int_hex_op2 <= seven_seg_to_int( hex_op2 );
int_hex_res <= seven_seg_to_int( hex_res );

-- generation de l'horloge
clk <= not(clk) after CLOCK_PERIOD/2;

-- generation du reset
reset <=	'1',
		'0' after CLOCK_PERIOD;

-- generation de la forme d'onde correspondant à l'appui
-- sur les touches
key_up_op1_b <= '0', 
	'1' after 2*CLOCK_PERIOD, 
	'0' after 5*CLOCK_PERIOD,
	'1' after 6*CLOCK_PERIOD;
key_up_op2_b <= '0',
	'1' after 10*CLOCK_PERIOD,
	'0' after 11*CLOCK_PERIOD,
	'1' after 12*CLOCK_PERIOD;
key_down_op1_b <= '0',
	'1' after 16*CLOCK_PERIOD, 
	'0' after 18*CLOCK_PERIOD,
	'1' after 20*CLOCK_PERIOD;
key_down_op2_b <= '0',
	'1' after 5*CLOCK_PERIOD, 
	'0' after 16*CLOCK_PERIOD,
	'1' after 21*CLOCK_PERIOD;


-- generation de la forme d'onde correspondant à la
-- selection de l'operation
alu_code <= alu_add, alu_and after 14*CLOCK_PERIOD;


end architecture;


