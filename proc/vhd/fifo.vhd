library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

library lib_nanoproc;
USE lib_nanoproc.NANO_PKG.all;

entity STD_FIFO is
  generic (fifo_depth);
  Port ( 
    CLK		: in  STD_LOGIC;
    resetn	: in  STD_LOGIC;
    WriteEn	: in  STD_LOGIC;
    DataIn	: in  STD_LOGIC_VECTOR (len_data_bus - 1 downto 0);
    ReadEn	: in  STD_LOGIC;
    DataOut	: out STD_LOGIC_VECTOR (len_data_bus - 1 downto 0);
    Empty	: out STD_LOGIC;
    Full	: out STD_LOGIC
    );
end STD_FIFO;

architecture FIFO of STD_FIFO is
  
begin
  
  -- Memory Pointer Process
  fifo_proc : process (CLK)
    type FIFO_Memory is array (0 to fifo_depth - 1) of STD_LOGIC_VECTOR (len_data_bus - 1 downto 0);
    variable Memory : FIFO_Memory;
    
    variable Head : natural range 0 to fifo_depth - 1;
    variable Tail : natural range 0 to fifo_depth - 1;
    -- looped = true si head boucle, false si tail boucle
    variable Looped : boolean;
  begin
    if (clk='1' and clk'event) then --Rapport : utiliser rising_edge(clk) ne convient que pour des clk de 0 à 1
      if resetn = '0' then
        Head := 0;
        Tail := 0;
        
        Looped := false;
        
        Full  <= '0';
        Empty <= '1';
      else
        if (ReadEn = '1') then
          if ((Looped = true) or (Head /= Tail)) then
                                        -- Update data output
            DataOut <= Memory(Tail);
            
                                        -- Update Tail pointer as needed
            if (Tail = fifo_depth - 1) then
              Tail := 0;
              
              Looped := false;
            else
              Tail := Tail + 1;
            end if;
            
            
          end if;
        end if;
        
        if (WriteEn = '1') then
          if ((Looped = false) or (Head /= Tail)) then
                                        -- Write Data to Memory
            Memory(Head) := DataIn;
            
                                        -- Increment Head pointer as needed
            if (Head = fifo_depth - 1) then
              Head := 0;
              
              Looped := true;
            else
              Head := Head + 1;
            end if;
          end if;
        end if;
        
        -- Update Empty and Full flags
        if (Head = Tail) then
          if Looped then
            Full <= '1';
          else
            Empty <= '1';
          end if;
        else
          Empty	<= '0';
          Full	<= '0';
        end if;
      end if;
    end if;
  end process;
  
end FIFO;
