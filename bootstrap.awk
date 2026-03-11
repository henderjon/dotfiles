#!/usr/bin/env awk -f

BEGIN{

	files[0] = "functions.awk"
	# files[1] = "setup.awk"
	# files[2] = "macos.awk"
	# files[3] = "cleanup.awk"
	files[4] = "update.awk"

	cmd = "awk "
	for(n = 0; n < length(files); n++){
		cmd = cmd " -f 'setup_scripts/" files[n] "'"
	}

	print cmd
}
