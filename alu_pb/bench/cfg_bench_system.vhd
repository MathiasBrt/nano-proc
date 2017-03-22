library lib_nanoproc_bench;
use lib_nanoproc_bench.all;
library lib_nanoproc;
use lib_nanoproc.all;

configuration cfg_bench_system of lib_nanoproc_bench.bench_system is
  for a
    for inst_system: system use entity lib_nanoproc.system( arch_fct ); 	
    end for;	
  end for;
end configuration;	    	

