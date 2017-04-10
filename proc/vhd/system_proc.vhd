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
        rcv_data : in std_logic_vector(len_data_bus-1 downto 0);      -- Data sortant venant de la FIFO PRINCIPALe
        rcv_interruption_b : in STD_LOGIC;                               -- Signal d'interuption venant de la sortie Empty de la FIFO
                                                                        -- PRINCIPALE
                                                                        -- actif bas
        rcv_en_fifo_principale : out std_logic;
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
generic (fifo_depth : integer);
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

signal    w_ram,wr,ecr_port  :  std_logic;
signal    d_in,data_ram,data_rom,data_in,data_port  :  std_logic_vector(len_data_bus-1 downto 0);
signal    sys_add_bus  	: std_logic_vector(len_addr_bus-1 downto 0);
signal 		sys_add_ram	: std_logic_vector(len_addr_bus-3 downto 0);
signal 		sys_add_rom	: std_logic_vector(len_addr_bus-2 downto 0);
signal		sys_add_port	: std_logic;
signal    s_data_n_send,s_data_s_send,s_data_e_send,s_data_w_send : std_logic_vector(len_data_bus-1 downto 0); --
--signal d'entrée des fifos de sorties
signal    s_wr_en_n,s_wr_en_s,s_wr_en_e,s_wr_en_w : std_logic;
signal    fifo_full_n_sig, fifo_full_s_sig, fifo_full_e_sig, fifo_full_w_sig : std_logic; --signal fifo alerte plein
signal    bus_inter_fifo : STD_LOGIC_VECTOR (len_data_bus-1 downto 0);
Signal    fifo_principale_write_en, fifo_principale_read_en, fifo_principale_empty, fifo_principale_full : STD_LOGIC;
signal    fifo_principale_data_out : STD_LOGIC_VECTOR (len_data_bus-1 downto 0);
signal    s_rd_en_n_rcv, s_rd_en_s_rcv, s_rd_en_e_rcv, s_rd_en_w_rcv : std_logic;
signal    s_rd_en_n_send, s_rd_en_s_send, s_rd_en_e_send, s_rd_en_w_send : std_logic;
signal ctrl_priorite, maintien_priorite : STD_LOGIC_VECTOR(3 downto 0);  -- Signal qui détermine quelque fifo pourra écrire dans la fifo principale en première
signal bit_etat : STD_LOGIC; -- 0 si la fifo envoie son premier mot, 1 sinon.

--signaux pour la fsm
type ETAT is (attente, transmission1, transmission2);
signal current_state, next_state : ETAT;

begin

U1:proc port map(
	       din=>d_in,
	       Resetn=>Resetn,
	       Clk=>Clock,
	       write=>wr,
	       Rd_out=>data_in,
	       Rad_out =>sys_add_bus,
               send_out_n => s_data_n_send,
               send_out_s => s_data_s_send,
               send_out_e => s_data_e_send,
               send_out_w => s_data_w_send,
               rcv_data => fifo_principale_data_out,
               rcv_interruption_b => fifo_principale_empty,
               rcv_en_fifo_principale => fifo_principale_read_en,
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

-- Mapping des 4 fifos de sortie (North, South, East, West)
FIFO_N : STD_FIFO generic map (10) 
  port map (
    clk     => Clock,
    resetn  => Resetn,
    WriteEn => s_wr_en_n,
    DataIn  => s_data_n_send,
    ReadEn  => s_rd_en_n_rcv,
    DataOut => data_n_send,
    Empty   => fifo_empty_n_send,
    Full    => fifo_full_n_sig);

FIFO_S : STD_FIFO generic map (10)
  port map (
    clk     => Clock,
    resetn  => Resetn,
    WriteEn => s_wr_en_s,
    DataIn => s_data_s_send,
    ReadEn  => s_rd_en_s_rcv,
    DataOut => data_s_send,
    Empty   => fifo_empty_s_send,
    Full    => fifo_full_s_sig);

FIFO_E : STD_FIFO generic map (10) 
  port map (
    clk     => Clock,
    resetn  => Resetn,
    WriteEn => s_wr_en_e,
    DataIn => s_data_e_send,
    ReadEn  => s_rd_en_e_rcv,
    DataOut => data_e_send,
    Empty   => fifo_empty_e_send,
    Full    => fifo_full_e_sig);

FIFO_W : STD_FIFO generic map (10) 
  port map (
    clk     => Clock,
    resetn  => Resetn,
    WriteEn => s_wr_en_w,
    DataIn => s_data_w_send,
    ReadEn  => s_rd_en_w_rcv,
    DataOut => data_w_send,
    Empty   => fifo_empty_w_send,
    Full    => fifo_full_w_sig);

FIFO_PRINCIPALE : STD_FIFO generic map (40) 
  port map (
    clk     => Clock,
    resetn  => Resetn,
    WriteEn => fifo_principale_write_en,
    DataIn  => bus_inter_fifo,
    ReadEn  => fifo_principale_read_en,
    DataOut => fifo_principale_data_out,
    Empty   => fifo_principale_empty,
    Full    => fifo_principale_full);

--CONTROL_FIFO_PRINCIPALE : process (Clock, resetn)
--                                                        -- "0001" = N; "0010" = S; "0100" = E; "1000" = W

--begin
 

--  if (Clock='1' and Clock'event) then
--     if (resetn = '0') then 
--       s_rd_en_n <= '0';
--       s_rd_en_s <= '0';
--       s_rd_en_e <= '0';
--       s_rd_en_w <= '0';
--       ctrl_priorite <= "0001";
--       maintien_priorite <= "0000";
--       bit_etat <= '0';
--     elsif (bit_etat='0') then
--      s_rd_en_n <= (ctrl_priorite(0) and (not fifo_empty_n_in))
--                 or (ctrl_priorite(1) and fifo_empty_s_in and fifo_empty_e_in and fifo_empty_w_in and (not fifo_empty_n_in))
--                 or (ctrl_priorite(2) and fifo_empty_e_in and fifo_empty_w_in and (not fifo_empty_n_in))
--                 or (ctrl_priorite(3) and fifo_empty_w_in and (not fifo_empty_n_in));
--      s_rd_en_s <= (ctrl_priorite(1) and (not fifo_empty_s_in))
--                 or (ctrl_priorite(2) and fifo_empty_e_in and fifo_empty_w_in and fifo_empty_n_in and (not fifo_empty_s_in))
--                 or (ctrl_priorite(3) and fifo_empty_w_in and fifo_empty_n_in and (not fifo_empty_s_in))
--                 or (ctrl_priorite(0) and fifo_empty_n_in and (not fifo_empty_s_in));
--      s_rd_en_e <= (ctrl_priorite(2) and (not fifo_empty_e_in))
--                 or (ctrl_priorite(3) and fifo_empty_s_in and fifo_empty_e_in and fifo_empty_w_in and (not fifo_empty_e_in))
--                 or (ctrl_priorite(0) and fifo_empty_e_in and fifo_empty_w_in and (not fifo_empty_e_in))
--                 or (ctrl_priorite(1) and fifo_empty_w_in and (not fifo_empty_e_in));
--      s_rd_en_w <= (ctrl_priorite(3) and (not fifo_empty_w_in))
--                 or (ctrl_priorite(0) and fifo_empty_n_in and fifo_empty_s_in and fifo_empty_e_in and (not fifo_empty_w_in))
--                 or (ctrl_priorite(1) and fifo_empty_s_in and fifo_empty_e_in and (not fifo_empty_w_in))
--                 or (ctrl_priorite(2) and fifo_empty_e_in and (not fifo_empty_w_in));
--      maintien_priorite(0) <= s_rd_en_n;
--      maintien_priorite(1) <= s_rd_en_s;
--      maintien_priorite(2) <= s_rd_en_e;
--      maintien_priorite(3) <= s_rd_en_w;
--      if (s_rd_en_n = '1') then
--        bus_inter_fifo <= data_in_n;
--      elsif (s_rd_en_s = '1') then
--        bus_inter_fifo <= data_in_s;
--      elsif (s_rd_en_e = '1') then
--        bus_inter_fifo <= data_in_e;
--      elsif (s_rd_en_w = '1') then
--        bus_inter_fifo <= data_in_w;
--      end if;
--      bit_etat <= s_rd_en_n or s_rd_en_s or s_rd_en_e or s_rd_en_w;
--      fifo_principale_write_en <= s_rd_en_n or s_rd_en_s or s_rd_en_e or s_rd_en_w;
--    else
--      s_rd_en_n <= maintien_priorite(0); -- On garde l'ordre du cycle précédent pour envoyer le deuxième mot de la même fifo.
--      s_rd_en_s <= maintien_priorite(1);
--      s_rd_en_e <= maintien_priorite(2);
--      s_rd_en_w <= maintien_priorite(3);
--      if (s_rd_en_n = '1') then
--        bus_inter_fifo <= data_in_n;
--      elsif (s_rd_en_s = '1') then
--        bus_inter_fifo <= data_in_s;
--      elsif (s_rd_en_e = '1') then
--        bus_inter_fifo <= data_in_e;
--      elsif (s_rd_en_w = '1') then
--        bus_inter_fifo <= data_in_w;
--      end if;
--      ctrl_priorite <= maintien_priorite(2) & maintien_priorite(1) & maintien_priorite(0) & maintien_priorite(3); -- On donne la priorité à la fifo suivante pour le cycle d'après.
--      fifo_principale_write_en <= s_rd_en_n or s_rd_en_s or s_rd_en_e or s_rd_en_w;
--      bit_etat <= '0';
--    end if;
--  end if;
--end process;

process (Clock, Resetn)
begin  -- process
  if Clock'event and Clock = '1' then  -- rising clock edge
    if Resetn='0' then
      current_state <= attente;
    else
      current_state <= next_state;
    end if;
  end if;
end process;

process (current_state, fifo_empty_n_rcv, fifo_empty_s_rcv, fifo_empty_e_rcv, fifo_empty_w_rcv, data_n_rcv, data_s_rcv, data_e_rcv, data_w_rcv)
begin  -- process
  s_rd_en_n_rcv<='0';
  s_rd_en_s_rcv<='0';
  s_rd_en_e_rcv<='0';
  s_rd_en_w_rcv<='0';
  fifo_principale_write_en<='0';
  case current_state is
    when attente =>
     if (fifo_empty_n_rcv and fifo_empty_s_rcv and fifo_empty_e_rcv and fifo_empty_w_rcv)='0' then
        next_state <= transmission1;
      end if; 
    when transmission1 =>
      if fifo_empty_n_rcv='0' then
        s_rd_en_n_rcv <= '1';
        bus_inter_fifo <= data_n_rcv;
        fifo_principale_write_en<='1';
      elsif fifo_empty_s_rcv='0' then
        s_rd_en_s_rcv <= '1';
        bus_inter_fifo <= data_s_rcv;
        fifo_principale_write_en<='1';
      elsif fifo_empty_e_rcv='0' then
        s_rd_en_e_rcv <= '1';
        bus_inter_fifo <= data_e_rcv;
        fifo_principale_write_en<='1';
      elsif fifo_empty_w_rcv='0' then
        s_rd_en_w_rcv <= '1';
        bus_inter_fifo <= data_w_rcv;
        fifo_principale_write_en<='1';
      end if;
      next_state <= transmission2;
    when transmission2 =>
      if fifo_empty_n_rcv='0' then
        s_rd_en_n_rcv <= '1';
        bus_inter_fifo <= data_n_rcv;
        fifo_principale_write_en<='1';
      elsif fifo_empty_s_rcv='0' then
        s_rd_en_s_rcv <= '1';
        bus_inter_fifo <= data_s_rcv;
        fifo_principale_write_en<='1';
      elsif fifo_empty_e_rcv='0' then
        s_rd_en_e_rcv <= '1';
        bus_inter_fifo <= data_e_rcv;
        fifo_principale_write_en<='1';
      elsif fifo_empty_w_rcv='0' then
        s_rd_en_w_rcv <= '1';
        bus_inter_fifo <= data_w_rcv;
        fifo_principale_write_en<='1';
      end if;
        next_state <= attente;
    when others =>
        next_state <= attente;
  end case;
end process;

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
