library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

library lib_nanoproc;
use lib_nanoproc.all;
USE lib_nanoproc.nano_pkg.all;


entity bench_system is
end bench_system;

architecture a of bench_system is

constant CLOCK_PERIOD : time := 20 ns;

function seven_seg_to_int(
	seven_seg : std_logic_vector( 6 downto 0 )
) return integer is
begin
	case seven_seg is
		when "1000000" => return( 0 );
		when "1111001" => return( 1 );
		when "0100100" => return( 2 );
		when "0110000" => return( 3 );
		when "0011001" => return( 4 );
		when "0010010" => return( 5 );
		when "0000010" => return( 6 );
		when "1111000" => return( 7 );
		when "0000000" => return( 8 );
		when "0010000" => return( 9 );
		when "0001000" => return( 10 );
		when "0000011" => return( 11 );
		when "1000110" => return( 12 );
		when "0100001" => return( 13 );
		when "0000110" => return( 14 );
		when "0001110" => return( 15 );
		when others => return( 0 );
	end case;
end function;

component SYSTEM 
port
(
        RESET, CLOCK_50 : in std_logic;
        KEY             : in std_logic_vector(1 downto 0); -- deux boutons poussoirs
        Filter_In       : in std_logic_vector(7 downto 0);
        Filter_Out      : out std_logic_vector(7 downto 0);
        ADC_Eocb        : in std_logic;         -- interface conv CAN
        ADC_Convstb     : out std_logic;
        ADC_Rdb,DAC_wrb : out std_logic;                -- resultat seuillage
        HEX0,HEX1,HEX2,HEX3 : out std_logic_vector(6 downto 0) -- afficheurs 7 seg
);
end component;

-- signaux d'interface du systeme
signal RESET, CLOCK_50 : std_logic := '0';
signal KEY             : std_logic_vector(1 downto 0) := "00"; 
signal Filter_In       : std_logic_vector(7 downto 0) := ( others => 'Z' );
signal Filter_Out      : std_logic_vector(7 downto 0);
signal ADC_Eocb        : std_logic := '1'; 
signal ADC_Convstb     : std_logic;
signal ADC_Rdb,DAC_wrb : std_logic;  
signal HEX0,HEX1,HEX2,HEX3 : std_logic_vector(6 downto 0);

-- signaux utilises pour visualiser les afficheurs
signal int_HEX0,int_HEX1,int_HEX2,int_HEX3 : integer;

-- signaux utilises pour la generation de la sinusoide
signal sin_freq : real := 5000.0;
signal sin_delta_phi : real;
signal sin_val : std_logic_vector( 7 downto 0 ); 

-- signaux utilisé pour simuler l'adc
signal adc_val : std_logic_vector( 7 downto 0 ); 
signal adc_ok : std_logic := '0';

begin

U1:SYSTEM port map
(
        RESET => RESET, 
 	CLOCK_50 => CLOCK_50,
        KEY => KEY, 
        Filter_In => Filter_In, 
        Filter_Out => Filter_Out,
        ADC_Eocb => ADC_Eocb,
        ADC_Convstb => ADC_Convstb,
        ADC_Rdb => ADC_Rdb,
 	DAC_wrb => DAC_wrb, 
        HEX0 => HEX0,
	HEX1 => HEX1,
	HEX2 => HEX2,
	HEX3 => HEX3
);

int_HEX0 <= seven_seg_to_int( HEX0 );
int_HEX1 <= seven_seg_to_int( HEX1 );
int_HEX2 <= seven_seg_to_int( HEX2 );
int_HEX3 <= seven_seg_to_int( HEX3 );

-- generation de l'horloge
CLOCK_50 <= not(CLOCK_50) after CLOCK_PERIOD/2;

-- generation du reset
reset <=	'0',
		'1' after 20 ns ;

-- generation de la forme d'onde correspondant à l'appui
-- sur les touches
KEY <=	"11",
	"10" after 100 ns;


-- calcul de la difference de phase entre deux
-- echantillons de sinus successifs
sin_delta_phi <= 2.0*MATH_PI*sin_freq*real( time'pos(CLOCK_PERIOD) * 1.0e-15 );

-- process de generation de la sinusoide
process_gen_sin : process (CLOCK_50)
	variable sin_arg : real := 0.0;
begin
	if CLOCK_50='1' and CLOCK_50'event then
		sin_arg := "MOD"( sin_arg + sin_delta_phi , 2.0*MATH_PI);
		sin_val <= conv_std_logic_vector( natural((sin(sin_arg)*127.49+128.0)), 8 );
	end if;
	
end process;  

-- processus d'émulation de l'ADC pour la partie conversion
process_conv : process
begin
	wait until ADC_Convstb'event and ADC_Convstb = '0';

	adc_ok <= '0'; -- en cours de conversion
	wait for 420 ns;

	ADC_Eocb <= '0';	
	adc_ok <= '1';
	wait for 100 ns;

	ADC_Eocb <= '1';

end process;

-- processus d'émulation de l'ADC pour la partie lecture
process_adc_rd : process( ADC_Rdb, adc_ok )  
begin
	if ( ADC_Rdb = '0' )
	then
		if ( adc_ok = '1' )
		then
			Filter_In <= sin_val;						
		else
			Filter_In <= ( others => 'U' );
		end if;
	elsif ( ADC_Rdb = '1' )
	then
		Filter_In <= ( others => 'Z' );
	end if;
end process;


end architecture;
















