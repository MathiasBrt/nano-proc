library ieee;
use ieee.std_logic_1164.all;

entity DEC3TO8 is
port ( 	w 	: in std_logic_vector(2 downto 0);
	y 	: out std_logic_vector(0 to 7));
end DEC3TO8;
	
architecture behavior of DEC3TO8 is
begin
	process (w)
	begin
	case w is
		when "000" => y <= "10000000";
		when "001" => y <= "01000000";
		when "010" => y <= "00100000";
		when "011" => y <= "00010000";
		when "100" => y <= "00001000";
		when "101" => y <= "00000100";
		when "110" => y <= "00000010";
		when "111" => y <= "00000001";
		when others =>
	end case;
	end process;
end behavior;
