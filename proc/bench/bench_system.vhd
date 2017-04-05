library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

library lib_nanoproc;
use lib_nanoproc.all;
USE lib_nanoproc.nano_pkg.all;


entity bench_proc is
end bench_proc;

architecture a of bench_proc is

constant CLOCK_PERIOD : time := 20 ns;


component SYSTEM_PROC 
port
(
 	Resetn, Clock 	: in std_logic;
	io_inp 		: in std_logic_vector(31 downto 0);
	io_out 		: out std_logic_vector(31 downto 0);
        data_out_n : out std_logic_vector(len_data_bus-1 downto 0);
        data_out_s : out std_logic_vector(len_data_bus-1 downto 0);
        data_out_e : out std_logic_vector(len_data_bus-1 downto 0);
        data_out_w : out std_logic_vector(len_data_bus-1 downto 0);
        fifo_empty_n : out std_logic;
        fifo_empty_s : out std_logic;
        fifo_empty_e : out std_logic;
        fifo_empty_w : out std_logic;
        fifo_full_n : out std_logic;
        fifo_full_s : out std_logic;
        fifo_full_e : out std_logic;
        fifo_full_w : out std_logic
      );
end component;

-- signaux d'interface du systeme
signal Resetn, Clock 	: std_logic:='0';
signal io_inp 		: std_logic_vector(31 downto 0);
signal io_out 		: std_logic_vector(31 downto 0);
signal data_out_n :  std_logic_vector(len_data_bus-1 downto 0);
signal data_out_s : std_logic_vector(len_data_bus-1 downto 0);
signal data_out_e : std_logic_vector(len_data_bus-1 downto 0);
signal data_out_w : std_logic_vector(len_data_bus-1 downto 0);
signal fifo_empty_n : std_logic;
signal fifo_empty_s : std_logic;
signal fifo_empty_e : std_logic;
signal fifo_empty_w : std_logic;
signal fifo_full_n : std_logic;
signal fifo_full_s :  std_logic;
signal fifo_full_e : std_logic;
signal fifo_full_w : std_logic;
      

begin

NANOPROC_1:SYSTEM_PROC port map
(
        Resetn => Resetn, 
 	Clock => Clock,
        io_inp => io_inp,
        io_out => io_out,
        data_out_n => data_out_n,
        data_out_s => data_out_s,
        data_out_e => data_out_e,
        data_out_w => data_out_w,
        fifo_empty_n => fifo_empty_n,
        fifo_empty_s => fifo_empty_s,
        fifo_empty_e => fifo_empty_e,
        fifo_empty_w => fifo_empty_w,
        fifo_full_n => fifo_full_n,
        fifo_full_s => fifo_full_s,
        fifo_full_e => fifo_full_e,
        fifo_full_w => fifo_full_w
        
);


-- generation de l'horloge
Clock <= not(Clock) after CLOCK_PERIOD/2;

-- generation du reset
resetn <=	'0',
		'1' after 20 ns ;

end architecture;
















