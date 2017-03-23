library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flip_flop_16bits is
  
  generic (
    RNW  : integer := 3;
    OCW  : integer  := 5;
    ACW  : integer  := 2;
    IBSW : integer  := 4);

  port (
    clk      : in  std_logic;
    rst      : in  std_logic;
    data_in  : in  std_logic_vector(15 downto 0);
    enable   : in  std_logic;
    data_out : out std_logic_vector(15 downto 0));

end flip_flop_16bits;

architecture bascule of flip_flop_16bits is

  signal s_data_out : std_logic_vector(15 downto 0) := "0000000000000000";
    
begin  -- bascule
  process (clk, rst)
  begin  -- process
    if rst = '1' then                   -- asynchronous reset (active low)
      s_data_out <= "0000000000000000";
    elsif clk'event and clk = '1' then  -- rising clock edge
      if enable='1' then
        s_data_out <= data_in;

      end if;
    end if;
  end process;

  data_out <= s_data_out;


end bascule;
