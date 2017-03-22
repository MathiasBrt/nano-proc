------------------------------CONTR.vhd- filte passe tout carte DE1 CAN CNA 8 bits ----------------------

library IEEE ;
use IEEE.std_logic_1164.ALL ;
-- library ARITHMETIC;
use IEEE.STD_LOGIC_ARITH.ALL;


entity can_cna_DE1 is
	port(	Filter_In	: in STD_LOGIC_VECTOR(7 downto 0) ;
	    Clk			: in STD_LOGIC ;   -- 50 MHZ
		Reset			: in STD_LOGIC ;
		ADC_Eocb		: in STD_LOGIC ;
		ADC_Convstb		: OUT STD_LOGIC ;
		ADC_Rdb		: OUT STD_LOGIC ;
		DAC_wrb			: OUT STD_LOGIC ;
		Filter_Out	: out STD_LOGIC_VECTOR(7 downto 0 ) ) ;
end can_cna_DE1 ;
-- Machine Ä âtats, contrüleur du filtre.

architecture A of can_cna_DE1  is

attribute chip_pin          		: string;
attribute chip_pin of Filter_In     : signal is "F12,F15,E14,H14,H12,H13,G15,E15"; 
attribute chip_pin of clk  : signal is "L1";
attribute chip_pin of RESET : signal is "R22";
attribute chip_pin of ADC_Eocb : signal is "D16";
attribute chip_pin of ADC_Convstb : signal is "G16";
attribute chip_pin of ADC_Rdb : signal is "F13";
attribute chip_pin of DAC_WRb  : signal is "P18";
attribute chip_pin  of  Filter_Out     : signal is "F20,E18,G18,G17,H17,H18,N21,N15"; 

type STATE is (S0,S1,S2);
signal Current_State, Next_State   : STATE ;
signal Reg_d, Reg_q	               :          STD_LOGIC_VECTOR(7 downto 0 );
signal Eocb_sync,adc_rd_csb        :          STD_LOGIC;

begin

 		ADC_Rdb		<= ADC_rd_csb;
	P_STATE : process(Clk)

	-- Mâmorisation des variables d'etats
	begin
		if (Clk = '1' and Clk'EVENT ) then
	-- Initialisation Ä l'etat 0 sous contrüle de "reset"
		   if (RESET='0') then 
			 Current_State <= S0 ;
			reg_q <= "00000000";
			Filter_Out <= "00000000";			
--			 Tap_Number <= "-----" ;
		   else
		    Current_State <= Next_State ;
		    reg_q <= reg_d;
			Eocb_sync <= ADC_Eocb;		
			Filter_Out <= reg_q;
		   end if ;
		end if;
	end process P_STATE;

	P_FSM:process(Current_State, Eocb_sync, reg_q)
	begin
	case Current_State is 
		 when S0 =>
			ADC_Convstb <= '1';
			DAC_wrb	<='1' ;
			ADC_Rd_csb <= '0';
			reg_d <= reg_q;
			Next_State <= S1;									

 		 when S1 =>
			ADC_Convstb <= '0';							-- lancement  conversion
			DAC_wrb	<='1' ;
			if (Eocb_sync='0') then
  				reg_d <= Filter_in;
				ADC_Rd_csb <= '0';
 				Next_State <= S2;
			else
  				reg_d <= reg_q;
				ADC_Rd_csb <= '0';
				reg_d <= reg_q;
				Next_State <= S1;
 			end if;

   		  when S2 => 
	        if (Eocb_sync='0') then			-- attente que Eocb repasse ‡ "1"
			 Next_State <= S2;
			else
			 Next_State <= S0;
			end if;	
			ADC_Rd_csb <= '0';
			ADC_Convstb <= '1';
			reg_d <= reg_q;
			DAC_wrb	<='0' ;			-- Ecriture DAC

 	 end case;
 	 end process P_FSM;
 
end A;

