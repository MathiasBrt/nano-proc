library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flip_flop_1bit is
  
  port (
    clk      : in  std_logic;
    rst      : in  std_logic;
    data_in  : in  std_logic;
    data_out : out std_logic;

end flip_flop_1bit;

architecture bascule of flip_flop_1bit is

  signal s_data_out : std_logic:= '0';    
begin  -- bascule
  process (clk, rst)
  begin  -- process
    if rst = '1' then                   -- asynchronous reset (active low)
      s_data_out <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
        s_data_out <= data_in;

    end if;
  end process;

  data_out <= s_data_out;


end bascule;
