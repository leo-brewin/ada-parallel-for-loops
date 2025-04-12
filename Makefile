SHELL = /bin/bash
#-------------------------------------------------------------------------------
.PHONY:	clean veryclean pristine github
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
github:
	@ make pristine
	@ (cd private/tex; pdflatex -halt-on-error -interaction=batchmode for-loop-tasking &> for-loop-tasking.texlog; cp -f for-loop-tasking.pdf ../../doc)
