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
architecture arch_prog_0 of ROM is

type tab_rom is array (0 to 2**(len_addr_bus-1)-1) of bit_vector(len_data_bus-1 downto 0) ;

constant MY_ROM : tab_rom :=
( 0 => x"0040", -- ldi r0,#AAAA
  1 => x"AAAA", 
  2 => x"0058", -- ldi r3,#000F
  3 => x"000F",
  4 => x"0083", -- add r0,r3
  5 => x"027F", -- bra,-1 pour boucle (10 0111 1111)
  6 => x"0000", 
  others=>x"0000");
begin

	output <= to_stdlogicvector(MY_ROM(conv_integer(address))) ;
	
end architecture;

--------------------------------------------------------------------------
-- arch_prog_1 un autre programme?
--------------------------------------------------------------------------
architecture arch_prog_1 of ROM is

type tab_rom is array (0 to 2**(len_addr_bus-1)-1) of bit_vector(len_data_bus-1 downto 0) ;

constant MY_ROM : tab_rom :=
( 0 => x"0040", -- ldi r0,#AAAA
  1 => x"AAAA", 
  2 => x"0058", -- ldi r3,#000F
  3 => x"000F",
  4 => x"0083", -- add r0,r3
  5 => x"027F", -- bra,-1 pour boucle (10 0111 1111)
  6 => x"0000", 
  others=>x"0000");
begin

	output <= to_stdlogicvector(MY_ROM(conv_integer(address))) ;
	
end architecture;












