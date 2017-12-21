#!/bin/bash
set -e

function print_help {
	printf "Available Commands:\n";
	awk -v sq="'" '/^function run_([a-zA-Z0-9-]*)\s*/ {print "-e " sq NR "p" sq " -e " sq NR-1 "p" sq }' make.sh \
		| while read line; do eval "sed -n $line make.sh"; done \
		| paste -d"|" - - \
		| sed -e 's/^/  /' -e 's/function run_//' -e 's/#//' -e 's/{/	/' \
		| awk -F '|' '{ print "  " $2 "\t" $1}' \
		| expand -t 30
}

function run_build { #build docker container
	docker build -t nerdalize/openfoam .
	docker tag nerdalize/openfoam nerdalize/openfoam:`cat VERSION`
}

function run_buildpush { #build and push docker container
	run_build
	docker push nerdalize/openfoam
	docker push nerdalize/openfoam:`cat VERSION`
}

case $1 in
	"build") run_build ;;
	"buildpush") run_buildpush ;;
	*) print_help ;;
esac
