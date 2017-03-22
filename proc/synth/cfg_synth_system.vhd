library lib_nanoproc;
use lib_nanoproc.all;

configuration cfg_synth_system of lib_nanoproc.system is
  for a	
    for U1 : system_proc use entity lib_nanoproc.system_proc( a );
      for a	
        for U3 : rom use entity lib_nanoproc.rom( arch_prog_0 );
        end for;
      end for;  
    end for;
  end for;
end configuration;	    	

