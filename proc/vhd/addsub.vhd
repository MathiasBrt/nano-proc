library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library lib_nanoproc;
use lib_nanoproc.nano_pkg.all;

entity ADDSUB is
port ( 	a,b : in std_logic_vector(len_data_bus-1 downto 0);
	alu_valid_sub : in std_logic;
	r : out std_logic_vector(len_data_bus-1 downto 0));
end ADDSUB;
	
architecture behavior of ADDSUB is
signal in_a,in_b : unsigned(len_data_bus-1 downto 0);
begin
	process (a,b,alu_valid_sub,in_a,in_b)
	begin
		in_a<=unsigned(a);
		in_b<=unsigned(b);
		if alu_valid_sub = '1' then -- adder
			r<=std_logic_vector(in_b - in_a);
		else
			r<=std_logic_vector(in_b + in_a);
		end if;
	end process;
end behavior;
