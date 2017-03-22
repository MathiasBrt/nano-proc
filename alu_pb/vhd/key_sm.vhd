library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity key_sm is
generic ( resolution : integer := 4
);
port ( 	clk : in std_logic;
	reset : in std_logic;
	key_up : in std_logic;
	key_down : in std_logic;
	val : out std_logic_vector( resolution-1 downto 0 )	
);
end entity;
	
architecture arch_fct of key_sm is
	type state is (key_wait, key_up_release_wait, key_down_release_wait);
	signal cur_state : state;
	signal nxt_state : state;
	signal cur_val : std_logic_vector( resolution-1 downto 0 );
	signal nxt_val : std_logic_vector( resolution-1 downto 0 );
	signal sync_key_up : std_logic;
	signal sync_key_down : std_logic;
begin

	val <= cur_val;

	process_seq : process( reset, clk )
	begin
		if ( reset = '1' )
		then
			cur_state <= key_wait;
			cur_val <= ( others=>'0' );
			sync_key_up <= '0';
			sync_key_down <= '0';
		elsif ( clk'event and clk = '1' )
		then
			sync_key_up <= key_up;
			sync_key_down <= key_down;
			cur_val <= nxt_val;
			cur_state <= nxt_state;
		end if;
	end process;

	process_comb : process( cur_state, cur_val, sync_key_up, sync_key_down )
	begin
		case cur_state is
			when key_wait =>
				if ( sync_key_up = '1' )
				then
					nxt_state <= key_up_release_wait;
					nxt_val <= std_logic_vector(unsigned(cur_val) + 1);
				elsif ( sync_key_down = '1' )
				then
					nxt_state <= key_down_release_wait;
                                        nxt_val <= std_logic_vector( unsigned(cur_val) - 1);
				else
					nxt_state <= key_wait;
					nxt_val <= cur_val;
				end if;

			when key_up_release_wait =>
				if (  sync_key_up = '1' )
				then
					nxt_state <= key_up_release_wait;
					nxt_val <= cur_val;
				else
                                        nxt_state <= key_wait;
                                        nxt_val <= cur_val;
				end if;				

			when key_down_release_wait =>
                                if (  sync_key_down = '1' )
                                then
                                        nxt_state <= key_down_release_wait;
                                        nxt_val <= cur_val;
                                else
                                        nxt_state <= key_wait;
                                        nxt_val <= cur_val;
                                end if;
		end case;
	end process;
 

end architecture;

