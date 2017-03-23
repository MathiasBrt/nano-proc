library ieee;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all;

entity demux is
  
  generic (
    AW  : integer := 8;   -- Address Width
    DW  : integer := 16   -- Data Width
    );
  port (
  
      data_in  :     in std_logic_vector(DW-1 downto 0);  -- input data
      demux_ctrl : 	in std_logic_vector(1 downto 0);  -- control bits
      if_north : 		out std_logic_vector(DW-1 downto 0);  -- north interface
      if_south :     out std_logic_vector(DW-1 downto 0); -- south interface
      if_east  :     out std_logic_vector(DW-1 downto 0); -- east interface
      if_west  :     out std_logic_vector(DW-1 downto 0)); -- west interface

    end demux;

    architecture dmux of demux is
	 
	 SIGNAL if_north_sig 	: std_logic_vector(DW-1 downto 0);
	 SIGNAL if_south_sig 	: std_logic_vector(DW-1 downto 0);
	 SIGNAL if_east_sig 	: std_logic_vector(DW-1 downto 0);
	 SIGNAL if_west_sig 	: std_logic_vector(DW-1 downto 0);
	 
	 begin
	 
	 process (data_in) -- liste de sensibilité arbitraire : à vérifier
    begin  -- dmux

      case demux_ctrl is
			when "00" => 
				if_north_sig <= data_in;
			when "01" => 
				if_south_sig <= data_in;
			when "10" => 
				if_east_sig <= data_in;
			when "11" => 
				if_west_sig <= data_in;
			when others => null;
		end case;
	 end process ;
	 if_north <= if_north_sig;
	 if_south <= if_south_sig;
	 if_east <= if_east_sig;
	 if_west <= if_west_sig;
    end dmux;
	 
	 
