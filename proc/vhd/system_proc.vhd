library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
library lib_nanoproc;
use lib_nanoproc.all;
USE lib_nanoproc.nano_pkg.all;

-- Systeme nanoprocesseur
-- Ecole PHELMA - Grenoble INP
-- Auteur : Vincent FRISTOT
-- date : Mai 2008
-- 

entity SYSTEM_PROC is
PORT ( 	Resetn, Clock 	: in std_logic;
	io_inp 		: in std_logic_vector(31 downto 0);
        rd_en_n : in std_logic;
        rd_en_s : in std_logic;
        rd_en_e : in std_logic;
        rd_en_w : in std_logic;
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
end SYSTEM_PROC;

-- systeme a nanoproc
-- 1 nanoproc
-- plan memoire pour bus d'adresses de 8 bits :
-- 0x00 - 0x7F : ROM
-- 0x80 - 0xBF : RAM, decodage sur A7A6
-- 0xC0	- 0xFF : decodage registres I/O, poids faible A0=0

architecture a of SYSTEM_PROC is

component PROC
port ( 	din 		: in std_logic_vector(len_data_bus-1 downto 0);
	resetn, clk 	: in std_logic;
	write 		: out std_logic;
	Rd_out 		: out std_logic_vector(len_data_bus-1 downto 0);
	Rad_out 	: out std_logic_vector(len_addr_bus-1 downto 0);
        send_out_n : out std_logic_vector(len_data_bus-1 downto 0);
        send_out_s : out std_logic_vector(len_data_bus-1 downto 0);
        send_out_e : out std_logic_vector(len_data_bus-1 downto 0);
        send_out_w : out std_logic_vector(len_data_bus-1 downto 0);
        north_en : out std_logic;
        south_en : out std_logic;
        east_en : out std_logic;
        west_en : out std_logic);
end component;

component RAM
generic (add_bits 	: integer;
	 data_bits 	: integer);
port (
         add 		: in std_logic_vector(add_bits-1 downto 0);
	 data_in 	: in std_logic_vector(data_bits-1 downto 0);
	 data_out	: out std_logic_vector(data_bits-1 downto 0);
	 clk,write 	: in std_logic
       );
end component;

component ROM
port (	address 	: in std_logic_vector(len_addr_bus-2 downto 0) ;
	output  	: out std_logic_vector(15 downto 0)
      );
end component;

component PORT_IO
port (	clk, reset_n, ecr : in std_logic;
	adress 		: in std_logic;
	dat_in_io 	: in std_logic_vector(len_data_bus-1 downto 0);
	in_io  		: in std_logic_vector(31 downto 0);
	dat_out_io  	: out std_logic_vector(len_data_bus-1 downto 0);
	out_io  	: out std_logic_vector(31 downto 0)
      ) ;
end component;

component STD_FIFO
port ( 
  CLK		: in  STD_LOGIC;
  resetn    	: in  STD_LOGIC;
  WriteEn	: in  STD_LOGIC;
  DataIn	: in  STD_LOGIC_VECTOR (len_data_bus - 1 downto 0);
  ReadEn	: in  STD_LOGIC;
  DataOut	: out STD_LOGIC_VECTOR (len_data_bus - 1 downto 0);
  Empty	: out STD_LOGIC;
  Full	: out STD_LOGIC
  );
end component;

signal          w_ram,wr,ecr_port  :  std_logic;
signal          d_in,data_ram,data_rom,data_in,data_port  :  std_logic_vector(len_data_bus-1 downto 0);
signal          sys_add_bus  	: std_logic_vector(len_addr_bus-1 downto 0);
signal 		sys_add_ram	: std_logic_vector(len_addr_bus-3 downto 0);
signal 		sys_add_rom	: std_logic_vector(len_addr_bus-2 downto 0);
signal		sys_add_port	: std_logic;
signal s_data_in_n,s_data_in_s,s_data_in_e,s_data_in_w : std_logic_vector(len_data_bus-1 downto 0);
signal s_wr_en_n,s_wr_en_s,s_wr_en_e,s_wr_en_w : std_logic;

begin

U1:proc port map(
	       din=>d_in,
	       Resetn=>Resetn,
	       Clk=>Clock,
	       write=>wr,
	       Rd_out=>data_in,
	       Rad_out =>sys_add_bus,
               send_out_n => s_data_in_n,
               send_out_s => s_data_in_s,
               send_out_e => s_data_in_e,
               send_out_w => s_data_in_w,
               north_en => s_wr_en_n,
               south_en => s_wr_en_s,
               east_en => s_wr_en_e,
               west_en => s_wr_en_w);

U2:ram 	generic map (len_addr_bus-2,len_data_bus) -- Adresses sur 6 bits
	port map(
		add=>sys_add_ram,
		data_in=>data_in,
		data_out=>data_ram,
		clk=>Clock,
		write=>w_ram);	      

U3: rom port map(				-- adresses sur 7 bits
		address=> sys_add_rom,
		output=> data_rom);

U4: port_io port map(
		clk => Clock,
		reset_n=>Resetn,
		ecr => ecr_port,
		adress => sys_add_port,
		dat_in_io => data_in,
		in_io => io_inp,
		dat_out_io => data_port,
		out_io => io_out);

-- Mapping des 4 fifos (North, South, East, West)
FIFO_N : STD_FIFO port map (
  clk     => Clock,
  resetn  => Resetn,
  WriteEn => s_wr_en_n,
  DataIn => s_data_in_n,
  ReadEn  => rd_en_n,
  DataOut => data_out_n,
  Empty   => fifo_empty_n,
  Full    => fifo_full_n);

FIFO_S : STD_FIFO port map (
  clk     => Clock,
  resetn  => Resetn,
  WriteEn => s_wr_en_s,
  DataIn => s_data_in_s,
  ReadEn  => rd_en_s,
  DataOut => data_out_s,
  Empty   => fifo_empty_s,
  Full    => fifo_full_s);

FIFO_E : STD_FIFO port map (
  clk     => Clock,
  resetn  => Resetn,
  WriteEn => s_wr_en_e,
  DataIn => s_data_in_e,
  ReadEn  => rd_en_e,
  DataOut => data_out_e,
  Empty   => fifo_empty_e,
  Full    => fifo_full_e);

FIFO_W : STD_FIFO port map (
  clk     => Clock,
  resetn  => Resetn,
  WriteEn => s_wr_en_w,
  DataIn => s_data_in_w,
  ReadEn  => rd_en_w,
  DataOut => data_out_w,
  Empty   => fifo_empty_w,
  Full    => fifo_full_w);


process (sys_add_bus,wr,data_rom,data_ram,data_port)
begin
	ecr_port<='0';
	w_ram<='0';
	d_in<=(others=>'0');
	sys_add_ram <= sys_add_bus(len_addr_bus-3 downto 0);	-- bus adresses pour RAM
	sys_add_port<= sys_add_bus(0);
	sys_add_rom <= sys_add_bus(len_addr_bus-2 downto 0);
	
	case sys_add_bus(7 downto 6) is 		-- decodage adresses sur A7A6
	when "10" => 					-- decodage RAM
	 	if (wr='1' ) then w_ram<='1'; end if; 	-- decodage sur adresse A7 pour SRAM
		d_in<=data_ram;
	when "11" =>					-- decodage port I/O
		if (wr='1') then ecr_port<='1';	end if;	
		d_in<=data_port;
	when others =>					-- decodage ROM
		d_in<=data_rom;
	end case;
end process;

end a;
