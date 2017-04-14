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
        rd_en_n_rcv : out std_logic;
        rd_en_s_rcv : out std_logic;
        rd_en_e_rcv : out std_logic;
        rd_en_w_rcv : out std_logic;
        rd_en_n_send : in std_logic;
        rd_en_s_send : in std_logic;
        rd_en_e_send : in std_logic;
        rd_en_w_send : in std_logic;
	io_out 		: out std_logic_vector(31 downto 0);
        data_n_send : out std_logic_vector(len_data_bus-1 downto 0);
        data_s_send : out std_logic_vector(len_data_bus-1 downto 0);
        data_e_send : out std_logic_vector(len_data_bus-1 downto 0);
        data_w_send : out std_logic_vector(len_data_bus-1 downto 0);
        data_n_rcv : in std_logic_vector(len_data_bus-1 downto 0);
        data_s_rcv : in std_logic_vector(len_data_bus-1 downto 0);
        data_e_rcv : in std_logic_vector(len_data_bus-1 downto 0);
        data_w_rcv : in std_logic_vector(len_data_bus-1 downto 0);
        fifo_empty_n_send : out std_logic;
        fifo_empty_s_send : out std_logic;
        fifo_empty_e_send : out std_logic;
        fifo_empty_w_send : out std_logic;
        fifo_empty_n_rcv : in std_logic;
        fifo_empty_s_rcv : in std_logic;
        fifo_empty_e_rcv : in std_logic;
        fifo_empty_w_rcv : in std_logic
      );
end component;

-- signaux d'interface du systeme
signal Resetn, Clock 	: std_logic:='0';
signal io_inp 		: std_logic_vector(31 downto 0);
signal rd_en_n_rcv : std_logic;
signal rd_en_s_rcv : std_logic;
signal rd_en_e_rcv : std_logic;
signal rd_en_w_rcv : std_logic;
signal rd_en_n_send : std_logic;
signal rd_en_s_send : std_logic;
signal rd_en_e_send : std_logic;
signal rd_en_w_send : std_logic;
signal io_out 		: std_logic_vector(31 downto 0);
signal data_n_send :  std_logic_vector(len_data_bus-1 downto 0);
signal data_s_send : std_logic_vector(len_data_bus-1 downto 0);
signal data_e_send : std_logic_vector(len_data_bus-1 downto 0);
signal data_w_send : std_logic_vector(len_data_bus-1 downto 0);
signal data_n_rcv :  std_logic_vector(len_data_bus-1 downto 0);
signal data_s_rcv : std_logic_vector(len_data_bus-1 downto 0);
signal data_e_rcv : std_logic_vector(len_data_bus-1 downto 0);
signal data_w_rcv : std_logic_vector(len_data_bus-1 downto 0);
signal fifo_empty_n_send: std_logic;
signal fifo_empty_s_send: std_logic;
signal fifo_empty_e_send : std_logic;
signal fifo_empty_w_send: std_logic;
signal fifo_empty_n_rcv: std_logic;
signal fifo_empty_s_rcv: std_logic;
signal fifo_empty_e_rcv: std_logic;
signal fifo_empty_w_rcv: std_logic;

begin

NANOPROC_1:SYSTEM_PROC port map
(
        Resetn => Resetn, 
 	Clock => Clock,
        io_inp => io_inp,
        rd_en_n_rcv => rd_en_n_rcv,
        rd_en_s_rcv => rd_en_s_rcv,
        rd_en_e_rcv => rd_en_e_rcv,
        rd_en_w_rcv => rd_en_w_rcv,
        rd_en_n_send => rd_en_n_send,
        rd_en_s_send => rd_en_s_send,
        rd_en_e_send => rd_en_e_send,
        rd_en_w_send => rd_en_w_send,
        io_out => io_out,
        data_n_send => data_n_send,
        data_s_send => data_s_send,
        data_e_send => data_e_send,
        data_w_send => data_w_send,
        data_n_rcv => data_n_rcv,
        data_s_rcv => data_s_rcv,
        data_e_rcv => data_e_rcv,
        data_w_rcv => data_w_rcv,
        fifo_empty_n_send => fifo_empty_n_send,
        fifo_empty_s_send => fifo_empty_s_send,
        fifo_empty_e_send => fifo_empty_e_send,
        fifo_empty_w_send => fifo_empty_w_send,
        fifo_empty_n_rcv => fifo_empty_n_rcv,
        fifo_empty_s_rcv => fifo_empty_s_rcv,
        fifo_empty_e_rcv => fifo_empty_e_rcv,
        fifo_empty_w_rcv => fifo_empty_w_rcv
);


-- generation de l'horloge
Clock <= not(Clock) after CLOCK_PERIOD/2;

-- generation du reset
resetn <=	'0',
		'1' after 30 ns ;

data_n_rcv <= x"000E" after 90 ns, x"FFFF" after 110 ns, x"0000" after 130 ns;
fifo_empty_n_rcv<= '1' after 30 ns, '0' after 70 ns, '1' after 130 ns;
fifo_empty_s_rcv<= '1' after 30 ns;
fifo_empty_e_rcv<= '1' after 30 ns;
fifo_empty_w_rcv<= '1' after 30 ns;

-- controle du read enable
--rd_en_n <= '0', '1' after 410 ns, '0' after 450 ns;

end architecture;
















