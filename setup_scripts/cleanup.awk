#!/usr/bin/env awk -f

BEGIN{

	notice("# ------ cleanup; avoids clobbering on fetch/pull")
	stdout("git checkout -b '" envName "'")

	notice("# ------ you might consider creating an ssh key pair")
	dtcmd = "date '+%FT%T%z'"
	dtcmd | getline dtstamp
	close(dtcmd)

	stderr("ssh-keygen -t ed25519 -C 'henderjon; " envName "; " dtstamp "'")

}
