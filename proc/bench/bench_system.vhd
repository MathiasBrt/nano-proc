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
        rd_en_n : out std_logic;
        rd_en_s : out std_logic;
        rd_en_e : out std_logic;
        rd_en_w : out std_logic;
	io_out 		: out std_logic_vector(31 downto 0);
        data_out_n : out std_logic_vector(len_data_bus-1 downto 0);
        data_out_s : out std_logic_vector(len_data_bus-1 downto 0);
        data_out_e : out std_logic_vector(len_data_bus-1 downto 0);
        data_out_w : out std_logic_vector(len_data_bus-1 downto 0);
        data_in_n : in std_logic_vector(len_data_bus-1 downto 0);
        data_in_s : in std_logic_vector(len_data_bus-1 downto 0);
        data_in_e : in std_logic_vector(len_data_bus-1 downto 0);
        data_in_w : in std_logic_vector(len_data_bus-1 downto 0);
        fifo_empty_n_out : out std_logic;
        fifo_empty_s_out : out std_logic;
        fifo_empty_e_out : out std_logic;
        fifo_empty_w_out : out std_logic;
        fifo_empty_n_in : in std_logic;
        fifo_empty_s_in : in std_logic;
        fifo_empty_e_in : in std_logic;
        fifo_empty_w_in : in std_logic
      );
end component;

-- signaux d'interface du systeme
signal Resetn, Clock 	: std_logic:='0';
signal io_inp 		: std_logic_vector(31 downto 0);
signal rd_en_n : std_logic;
signal rd_en_s : std_logic;
signal rd_en_e : std_logic;
signal rd_en_w : std_logic;
signal io_out 		: std_logic_vector(31 downto 0);
signal data_out_n :  std_logic_vector(len_data_bus-1 downto 0);
signal data_out_s : std_logic_vector(len_data_bus-1 downto 0);
signal data_out_e : std_logic_vector(len_data_bus-1 downto 0);
signal data_out_w : std_logic_vector(len_data_bus-1 downto 0);
signal data_in_n :  std_logic_vector(len_data_bus-1 downto 0);
signal data_in_s : std_logic_vector(len_data_bus-1 downto 0);
signal data_in_e : std_logic_vector(len_data_bus-1 downto 0);
signal data_in_w : std_logic_vector(len_data_bus-1 downto 0);
signal fifo_empty_n_out : std_logic;
signal fifo_empty_s_out : std_logic;
signal fifo_empty_e_out : std_logic;
signal fifo_empty_w_out : std_logic;
signal fifo_empty_n_in : std_logic;
signal fifo_empty_s_in : std_logic;
signal fifo_empty_e_in : std_logic;
signal fifo_empty_w_in : std_logic;

begin

NANOPROC_1:SYSTEM_PROC port map
(
        Resetn => Resetn, 
 	Clock => Clock,
        io_inp => io_inp,
        rd_en_n => rd_en_n,
        rd_en_s => rd_en_s,
        rd_en_e => rd_en_e,
        rd_en_w => rd_en_w,
        io_out => io_out,
        data_out_n => data_out_n,
        data_out_s => data_out_s,
        data_out_e => data_out_e,
        data_out_w => data_out_w,
        data_in_n => data_in_n,
        data_in_s => data_in_s,
        data_in_e => data_in_e,
        data_in_w => data_in_w,
        fifo_empty_n_out => fifo_empty_n_out,
        fifo_empty_s_out => fifo_empty_s_out,
        fifo_empty_e_out => fifo_empty_e_out,
        fifo_empty_w_out => fifo_empty_w_out,
        fifo_empty_n_in => fifo_empty_n_in,
        fifo_empty_s_in => fifo_empty_s_in,
        fifo_empty_e_in => fifo_empty_e_in,
        fifo_empty_w_in => fifo_empty_w_in
);


-- generation de l'horloge
Clock <= not(Clock) after CLOCK_PERIOD/2;

-- generation du reset
resetn <=	'0',
		'1' after 20 ns ;

data_in_n <= x"ABCD" after 60 ns, x"FFFF" after 80 ns, x"0000" after 100 ns;
fifo_empty_n_in <= '0' after 40 ns, '1' after 80 ns;

-- controle du read enable
--rd_en_n <= '0', '1' after 410 ns, '0' after 450 ns;

end architecture;
















