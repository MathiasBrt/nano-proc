LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

entity send is
  
  port (
    clk            : in  std_logic;
    RST            : in  std_logic;
    data_in_north : in std_logic_vector(15 downto 0);  -- Bus d'envoi de la donnée vers la sortie nord
    data_in_south  : in std_logic_vector(15 downto 0);
    data_in_east  : in std_logic_vector(15 downto 0);
    data_in_west  : in std_logic_vector(15 downto 0);
    WR_EN_North    : in std_logic;                       -- Signal de control de la fifo permettant d'entrer en mode écriture
    WR_EN_South    : in std_logic;
    WR_EN_East    : in std_logic;
    WR_EN_West    : in std_logic;
    
    data_out_north : out std_logic_vector(15 downto 0);  -- Bus d'envoi de la donnée vers la sortie nord
    data_out_south  : out std_logic_vector(15 downto 0);
    data_out_east  : out std_logic_vector(15 downto 0);
    data_out_west  : out std_logic_vector(15 downto 0);
    ctrl_fifo_North    : out std_logic;                       -- Signal de control de la fifo permettant d'entrer en mode écriture
    ctrl_fifo_South    : out std_logic;
    ctrl_fifo_East    : out std_logic;
    ctrl_fifo_West    : out std_logic
    );
end send;

architecture NSEW_send of send is

  component flip_flop_1bit
    port (
      clk          : in std_logic;      -- rst
      rst          : in std_logic;
      data_in      : in std_logic;      -- enable
      data_out      : out std_logic
      );
    
  end component;

  component flip_flop_16bits
    port (
      clk          : in std_logic;      
      rst          : in std_logic;
      data_in      : in std_logic_vector(15 downto 0);      
      enable       : in std_logic;
      data_out      : out std_logic_vector(15 downto 0)
      );
    
  end component;
  
begin  -- NSEW_send

  U1 : flip_flop_16bits
    port map (
      clk      => clk,
      rst      => rst,
      data_in  => data_in_north,
      enable   => WR_EN_North,
      data_out => data_out_north);
  U2 : flip_flop_1bit
    port map (
      clk      => clk,
      rst      => rst,
      data_in  => WR_EN_North,
      data_out => ctrl_fifo_North);

     U3 : flip_flop_16bits
    port map (
      clk      => clk,
      rst      => rst,
      data_in  => data_in_south,
      enable   => WR_EN_South,
      data_out => data_out_south);
  U4 : flip_flop_1bit
    port map (
      clk      => clk,
      rst      => rst,
      data_in  => WR_EN_South,
      data_out => ctrl_fifo_South);


     U5 : flip_flop_16bits
    port map (
      clk      => clk,
      rst      => rst,
      data_in  => data_in_east,
      enable   => WR_EN_East,
      data_out => data_out_east);
  U6 : flip_flop_1bit
    port map (
      clk      => clk,
      rst      => rst,
      data_in  => WR_EN_East,
      data_out => ctrl_fifo_East);



     U7 : flip_flop_16bits
    port map (
      clk      => clk,
      rst      => rst,
      data_in  => data_in_west,
      enable   => WR_EN_West,
      data_out => data_out_west);
  U8 : flip_flop_1bit
    port map (
      clk      => clk,
      rst      => rst,
      data_in  => WR_EN_West,
      data_out => ctrl_fifo_West);
    
end NSEW_send;
