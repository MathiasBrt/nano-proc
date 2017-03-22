-- 2008_0425 nanoproc
-- auteur : Vincent Fristot
-- Ecole Phelma Grenoble INP
--
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

package NANO_PKG is
	constant len_data_bus : integer :=4;
	constant len_addr_bus : integer :=8;
	type REGISTER_FILE is array (natural range<>) of std_logic_vector(len_data_bus-1 downto 0);
	
	constant alu_add : std_logic_vector(1 downto 0) := "00"; -- liste des codes alu
	constant alu_sub : std_logic_vector(1 downto 0) := "01"; 
	constant alu_and : std_logic_vector(1 downto 0) := "10"; 



end NANO_PKG;
