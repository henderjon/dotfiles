#!/usr/bin/env awk -f

function confirm(    answer){
	printf "Are you sure? (y/n): " > "/dev/stderr"
	getline answer < "/dev/tty"

	if (answer == "y" || answer == "Y") {
		return 1
	} else {
		return 0
	}
}

BEGIN{
	# prList = "unset CLICOLOR_FORCE; gh search prs --owner capdig --state open --author app/dependabot --json repository,number"
	# jqCmd = "jq -r '.[] | \"\\(.repository.nameWithOwner)\\t\\(.number)\"'"
	# cmd = prList " | " jqCmd
	# while ((cmd | getline line) > 0) {

	prList = "gh search prs --owner capdig --state open --author app/dependabot"
	system(prList)
	close(prList)

	if(!confirm()){
		exit 1
	}

	cmd = "unset CLICOLOR_FORCE; " prList " --json repository,number | jq -r '.[] | \"\\(.repository.nameWithOwner)\\t\\(.number)\"'"
	print cmd > "/dev/stderr"

	while ((cmd | getline line) > 0) {
		split(line, parts, "\t")
		repo = parts[1]
		prNum = parts[2]
		approveCmd = "gh pr review " prNum " --approve --repo \"" repo "\""
		print approveCmd
		# Uncomment the next line to actually execute the approval:
		# system(approveCmd)
	}

	close(cmd)
	exit 0
}
END{
	# destruct
}
