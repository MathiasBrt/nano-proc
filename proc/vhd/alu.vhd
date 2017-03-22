library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library lib_nanoproc;
use lib_nanoproc.nano_pkg.all;

entity ALU is
port ( 	a,b : in std_logic_vector(len_data_bus-1 downto 0);
	alu_code : in std_logic_vector(1 downto 0);
	r : out std_logic_vector(len_data_bus-1 downto 0));
end ALU;
	
architecture behavior of ALU is
signal in_a,in_b : unsigned(len_data_bus-1 downto 0);
begin
	process (a,b,alu_code,in_a,in_b)
	begin
		in_a<=unsigned(a);
		in_b<=unsigned(b);
		case alu_code is
		when alu_add => r<=std_logic_vector(in_b + in_a);
		when alu_sub => r<=std_logic_vector(in_b - in_a);
		when alu_and => r<=std_logic_vector(in_b and in_a);
		when others => r<=std_logic_vector(in_b + in_a);		
		end case;
	end process;
end behavior;
