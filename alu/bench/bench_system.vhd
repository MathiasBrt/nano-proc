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
port(	alu_code : in std_logic_vector( 1 downto 0 );
	alu_op1 : in std_logic_vector( 3 downto 0 );
	alu_op2 : in std_logic_vector( 3 downto 0 );
	hex_op1 : out std_logic_vector( 6 downto 0 );
	hex_op2 : out std_logic_vector( 6 downto 0 );
	hex_res : out std_logic_vector( 6 downto 0 )
);
end component;

-- signaux d'interface du systeme
signal alu_code :  std_logic_vector( 1 downto 0 );
signal alu_op1 :  std_logic_vector( 3 downto 0 );
signal alu_op2 :  std_logic_vector( 3 downto 0 );
signal hex_op1 : std_logic_vector( 6 downto 0 );
signal hex_op2 : std_logic_vector( 6 downto 0 );
signal hex_res : std_logic_vector( 6 downto 0 );

-- signaux utilises pour visualiser les afficheurs
signal int_hex_op1,int_hex_op2,int_hex_res : integer;


begin

inst_system : system port map (
	alu_code => alu_code,
	alu_op1 => alu_op1,
	alu_op2 => alu_op2,
	hex_op1 => hex_op1,
	hex_op2 => hex_op2,
	hex_res => hex_res
);


int_hex_op1 <= seven_seg_to_int( hex_op1 );
int_hex_op2 <= seven_seg_to_int( hex_op2 );
int_hex_res <= seven_seg_to_int( hex_res );


-- generation de la forme d'onde correspondant au switch
alu_op1 <= "0000", "1010" after 50 ns;
alu_op2 <= "0000", "0110" after 90 ns;

-- generation de la forme d'onde correspondant à la
-- selection de l'operation
alu_code <= alu_add, alu_not after 70 ns;


end architecture;


