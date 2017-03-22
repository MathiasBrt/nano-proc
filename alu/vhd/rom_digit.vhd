library IEEE;
use IEEE.std_logic_1164.ALL ;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
library lib_nanoproc;
use lib_nanoproc.all;
USE lib_nanoproc.nano_pkg.all;

-- ROM pilotage afficheur 7 segments
-- niveau 0 actif, ordre des bits :

--       0
--      --
--   5 | 6| 1
--      --
--   4 |  | 2
--      --
--       3

entity ROM_DIGIT is
port (	digit : in std_logic_vector(3 downto 0) ;
	output  : out std_logic_vector(6 downto 0) ) ;
end ROM_DIGIT;

architecture A of ROM_DIGIT is

type tab_rom is array (0 to 15) of bit_vector(7 downto 0) ;

constant MY_ROM : tab_rom :=
( 0 => x"40",
  1 => x"79", 
  2 => x"24",
  3 => x"30",
  4 => x"19",
  5 => x"12",
  6 => x"02",
  7 => x"78",  
  8 => x"00",
  9 => x"10",
  10 => x"08",
  11 => x"03",
  12 => x"46",
  13 => x"21",
  14 => x"06",
  15 => x"0E");
begin

	output <= to_stdlogicvector(MY_ROM(conv_integer(digit))(6 downto 0)) ;
	
end A;
