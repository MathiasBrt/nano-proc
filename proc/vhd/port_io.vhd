library IEEE;
use IEEE.std_logic_1164.ALL ;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
library lib_nanoproc;
use lib_nanoproc.all;
USE lib_nanoproc.nano_pkg.all;

-- Port I/O de 32 entrees sorties
-- entrees :
-- clk, reset_n
-- ecr : signal ecriture dans registre out, actif a 1
-- dat_in_io : signal du bus de donnees pour ecriture dans registre
-- dat_out_io : signal du bus de donnees pour lecture des entrees
-- adress : selection 0 : poids faible, 1 poids forts
-- in_io : 32 entrees exterieures
-- out_io : 32 sorties exterieures

entity PORT_IO is
port (	clk, reset_n, ecr : in std_logic;
	adress 		: in std_logic;
	dat_in_io 	: in std_logic_vector(len_data_bus-1 downto 0) ;
	in_io  		: in std_logic_vector(31 downto 0);
	dat_out_io  	: out std_logic_vector(len_data_bus-1 downto 0);
	out_io  	: out std_logic_vector(31 downto 0)) ;
end PORT_IO;

architecture A of PORT_IO is

signal reg_d, reg_q : std_logic_vector(31 downto 0);

begin

synch : process(clk)
begin
	if (clk'event and clk='1') then
		if (reset_n='0') then
			reg_q<=(others=>'0'); 	-- RAZ registre
		else
			reg_q<=reg_d;		-- fonction registre
		end if;
	end if;
end process;

combi : process(ecr,adress,dat_in_io,reg_q,in_io)
begin
	reg_d<=reg_q;		-- fonction memo du registre
	if (ecr='1') then
		if (adress='0') then
			reg_d(15 downto 0)<=dat_in_io;
		else
			reg_d(31 downto 16)<=dat_in_io;
		end if;
	end if;
	out_io<=reg_q;	
	if (adress='0') then
		dat_out_io<=in_io(15 downto 0);
	else
		dat_out_io<=in_io(31 downto 16);
	end if;

end process;

	
end A;
