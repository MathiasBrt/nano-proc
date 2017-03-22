Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

--use ieee.exemplar.exemplar_1164.all;


-- synthese d'une ram cf ALTERA AN 225
-- 20.10.2003



entity RAM is
generic (add_bits : integer;
	 data_bits : integer);
port (
         add 	: in std_logic_vector(add_bits-1 downto 0);
	 data_in : in std_logic_vector(data_bits-1 downto 0);
	 data_out: out std_logic_vector(data_bits-1 downto 0);
	 clk,write : in std_logic);
end ram;

architecture A of ram is
  subtype word is std_logic_vector(data_bits-1 downto 0);
  constant nwords :integer :=2**add_bits;
  type mem_type is array (0 to nwords-1) of word;
  signal  mem : mem_type;

begin
  seq : process(clk,add)
  begin
      if (clk'event and clk = '1') then
	if (write = '1') then
	      mem(conv_integer(add))<=data_in; -- positionne mem fin process
	end if;
      end if;
  end process seq;

  data_out<=mem(conv_integer(add));

end A;
