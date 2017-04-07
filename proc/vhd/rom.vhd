library IEEE;
use IEEE.std_logic_1164.ALL ;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
library lib_nanoproc;
use lib_nanoproc.all;
USE lib_nanoproc.nano_pkg.all;

entity ROM is
port (	address : in std_logic_vector(len_addr_bus-2 downto 0) ;
	output  : out std_logic_vector(len_data_bus-1 downto 0) ) ;
end ROM;

--------------------------------------------------------------------------
-- arch_prog_0: un premier programme
--------------------------------------------------------------------------
--architecture arch_prog_0 of ROM is

--type tab_rom is array (0 to 2**(len_addr_bus-1)-1) of bit_vector(len_data_bus-1 downto 0) ;

--constant MY_ROM : tab_rom :=
--( 0 => "0000000001110000",   -- ldi r6,#0000 : Numéro du processeur source (0000)
--  1 => x"000E", 
--  2 => "0000000001001000",   -- ldi r1,#0001 : Numéro du proc destination (0001)
--  3 => x"000A",
--  4 => "0000000001000000",   -- ldi r0, # ABCD : Donnée à envoyer (1010 1011
--                             -- 1100 1101)
--  5 => x"ABCD", 
--  6 => "0000010000001000",   -- send r1, r0 : Envoi de la donnée contenue dans r0 vers le
--                                -- proc pointé par r1
--  7 => "0000000010001110",           -- r1 add r6 => r1
--  others=>x"0000");
--begin

--	output <= to_stdlogicvector(MY_ROM(conv_integer(address))) ;
	
--end architecture;

----------------------------------------------------------------------------
---- arch_prog_1 un autre programme?
--------------------------------------------------------------------------
architecture arch_prog_1 of ROM is

type tab_rom is array (0 to 2**(len_addr_bus-1)-1) of bit_vector(len_data_bus-1 downto 0) ;

constant MY_ROM : tab_rom :=
( 0 => "0000000001110000",
  1 => "1010101111001101",
  2 => "0000010001000000",
  3 => "0000000001110000",
  4 => "0000000011111111",
  5 => "0000010010000000",
  others=>x"0000");
begin

	output <= to_stdlogicvector(MY_ROM(conv_integer(address))) ;
	
end architecture;













