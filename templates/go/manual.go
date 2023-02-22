package main

import (
	"bytes"
	"flag"
	"os"
	"text/template"
)

// Tmpl is a basic man page[-ish] looking template
const Tmpl = `
{{define "manual"}}
NAME
  {{.Bin}} - a pithy one line description

SYNOPSIS
  $ {{.Bin}}
  $ {{.Bin}} [-h|help]

DESCRIPTION
  {{.Bin}} a lengthier multi-line description goes here so that other people
  know how to use your program

EXAMPLES
  $ {{.Bin}} -h

OPTIONS
{{.Options}}
VERSION
  version:  {{.Version}}
  compiled: {{.CompiledBy}}
  built:    {{.BuildTimestamp}}

{{end}}
`

// Info represents the infomation used in the default Tmpl string
type Info struct {
	Tmpl           string
	Bin            string
	Version        string
	CompiledBy     string
	BuildTimestamp string
	Options        string
}

// Usage wraps a set of `Info` and creates a flag.Usage func
func Usage(info Info) func() {
	if len(info.Tmpl) == 0 {
		info.Tmpl = Tmpl
	}

	t := template.Must(template.New("manual").Parse(info.Tmpl))

	return func() {
		var def bytes.Buffer
		flag.CommandLine.SetOutput(&def)
		flag.PrintDefaults()

		info.Options = def.String()
		t.Execute(os.Stdout, info)
	}
}
