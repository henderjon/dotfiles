package main

import (
	"flag"
)

type generalParams struct {
	debug bool
}

type allParams struct {
	general generalParams
}

func getParams() allParams {
	flag.Usage = Usage(Info{
		Bin:            binName,
		Version:        buildVersion,
		CompiledBy:     compiledBy,
		BuildTimestamp: buildTimestamp,
	})

	params := allParams{}
	flag.BoolVar(&params.general.debug, "debug", false, "noisy output")
	flag.Parse()

	return params
}
