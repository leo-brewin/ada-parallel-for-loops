SHELL = /bin/bash
#-------------------------------------------------------------------------------
.PHONY:	clean veryclean pristine
#-------------------------------------------------------------------------------
all:
	@ (cd examples; build.sh)
#-------------------------------------------------------------------------------
clean:
	@ :
veryclean:
	@ make clean
pristine:
	@ make veryclean
	@ (cd examples; rm -rf bin obj)
	@ (cd examples/lwt/examples; rm -rf bin obj)
