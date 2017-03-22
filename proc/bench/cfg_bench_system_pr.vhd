library lib_nanoproc_bench;
use lib_nanoproc_bench.all;
library lib_nanoproc_pr;
use lib_nanoproc_pr.all;

configuration cfg_bench_system_pr of lib_nanoproc_bench.bench_system is
  for a
    for U1: system use entity lib_nanoproc_pr.system( structure ); 	
    end for;	
  end for;
end configuration;	    	

