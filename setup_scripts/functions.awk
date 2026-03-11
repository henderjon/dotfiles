#!/usr/bin/awk -f


function notice(string) {
	stderr(sprintf("\033[01;36m%s\033[00;00m", string))
}

function stderr(string){
	print string > "/dev/stderr"
}

function fatal(string){
	stderr(string)
	exit 1
}

function stdout(string){
	print string
	# print string > "/dev/stdout"
}

function esc(string){
	gsub(/'/, "'\\''", string)
	return string
}

function prompt(msg, default,    answer, tty) {
	if (default != "") {
		printf "%s [%s]: ", msg, default
	} else {
		printf "%s: ", msg
	}

	tty = "/dev/tty"

	# /dev/stdin might have been redirected
	if ((getline answer < tty) > 0 && answer != "") {
		close(tty)
		return answer
	}

	close(tty)
	return default
}

function confirm(msg,     answer){
	answer = prompt(msg, "y/n")
	return (answer ~ /^[Yy]/)
}

function file_exists(path) {
	return !system("test -e '" esc(path) "'")
}

function is_file(path) {
	return !system("test -f '" esc(path) "'")
}

function is_dir(path) {
	return !system("test -d '" esc(path) "'")
}

function is_symlink(path) {
	return !system("test -h '" esc(path) "'")
}

function is_exec(path) {
	return !system("test -x '" esc(path) "'")
}

function envVarExists(string){
	return string in ENVIRON
}

function envVarIsEmpty(string){
	return ENVIRON[string] == ""
}

function bkupFile(fname,     dtcmd, dtstamp){
	if( (is_file(fname) || is_dir(fname)) && !is_symlink(fname) ){
		dtcmd = "date '+%Y.%m.%dT%H.%M.%S'" # -u for UTC
		dtcmd | getline dtstamp
		close(dtcmd)

		fname = esc(fname)
		stdout(sprintf("mv '%s' '%s.bkup.%s'", esc(fname), esc(fname), dtstamp))
	}
}

function rmSymLink(fname){
	if( (is_file(fname) || is_dir(fname)) && is_symlink(fname) ){
		stdout(sprintf("rm '%s' ", esc(fname)))
	}
}

function mkSymlink(fname, lname){
	stdout(sprintf("ln -s '%s' '%s'", esc(fname), esc(lname)))
}

function mkDir(dname){
	stdout(sprintf("mkdir -p '%s'", esc(dname)))
}

function cpFile(oldpath, newpath){
	stdout(sprintf("cp '%s' '%s' ", esc(oldpath), esc(newpath)))
}
