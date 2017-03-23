library ieee;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all;

entity mux is
  port (
  
      data_out  :     out std_logic_vector(len_data_bus-1 downto 0);  -- input data
      mux_ctrl : 	in std_logic_vector(1 downto 0);  -- control bits
      if_north : 		in std_logic_vector(len_data_bus-1 downto 0);  -- north interface
      if_south :     in std_logic_vector(len_data_bus-1 downto 0); -- south interface
      if_east  :     in std_logic_vector(len_data_bus-1 downto 0); -- east interface
      if_west  :     in std_logic_vector(len_data_bus-1 downto 0)); -- west interface

    end mux;

    architecture mmux of mux is
	 
	 SIGNAL sig_data : 	 std_logic_vector(len_data_bus-1 downto 0);
	 begin
	 
	 process (mux_ctrl,if_west, if_east, if_south, if_north) -- liste de sensibilité arbitraire : à vérifier
    begin  -- dmux

      case mux_ctrl is
			when "00" => 
                              sig_data <= if_south;
			when "01" => 
                              sig_data <= if_north;
			when "10" => 
                              sig_data <= if_west;
			when "11" => 
                              sig_data <= if_east;
			when others => null;
		end case;
	 end process ;
	 data_out <= sig_data;
    end mmux;
