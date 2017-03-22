-----------------------------FILTRE.vhd----------------------------------------
library IEEE ;
use IEEE.std_logic_1164.ALL ;
USE ieee.numeric_std.all;

--library lib_FILTRE ;

entity test_cna is
	port(	
		CLK		: in STD_LOGIC ;
		RESET		: in STD_LOGIC ;
		DAC_WRb          : out STD_LOGIC ;
	    cna_Out	: out STD_LOGIC_VECTOR(7 downto 0 ) ) ;
end test_cna;

architecture A of test_cna is

attribute chip_pin          		: string;
attribute chip_pin of clk  : signal is "L1";
attribute chip_pin of RESET : signal is "R22";
attribute chip_pin of DAC_WRb  : signal is "P18";
attribute chip_pin  of  cna_Out     : signal is "F20,E18,G18,G17,H17,H18,N21,N15"; 


--  attribute chip_pin  of  addr_lig      	: signal is "J3,K5,R4,J7,V6,J5,P19"; -- 6 a 0 
--  attribute	 chip_pin  of cb_ac_std_capteur : signal is "N19";
-- Quartus VHDL Template
-- Clearable loadable enablable counter


	SIGNAL	count_signal: unsigned(12 DOWNTO 0);
	
BEGIN
PROCESS (clk, reset)
	BEGIN
	
		IF reset = '0' THEN		
			count_signal <= (OTHERS => '0');			
		 ELSIF (clk'EVENT AND clk = '1') THEN			
						count_signal <= count_signal + "0000000000001";								
		END IF;
END PROCESS;

	cna_out(7 downto 0) <= STD_LOGIC_VECTOR(count_signal(12 downto 5));	
	DAC_WRb <= count_signal(4);


end A;

