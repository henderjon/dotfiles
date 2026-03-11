#!/usr/bin/awk -f

BEGIN{
	homedir = ENVIRON["HOME"]
	if(homedir == ""){
		fatal("$HOME is undefined")
	}

	"pwd" | getline dotpath
	close("pwd")

	envName = prompt("Please give me a name")
	if(envName == ""){
		stderr("You forgot a name.")
		exit 1
	}else{
		stderr(sprintf("Hello, %s\n", envName))
	}

	# ------ zsh
	notice("# ------ zsh")
	stdout("chsh -s /bin/zsh")

	# ------ git
	notice("# ------ gitconfig")
	stdout("git config --global --replace-all include.path \"" dotpath "/conf/git/gitconfig\"")
	stdout("git config --global --add include.path \"" dotpath "/conf/git/gitgpg\"")

	notice("# !----- edit signing key and email in gitconfig & gitgpg")
	stderr("git config --global user.email \"\"")
	stderr("git config --global user.signingkey \"\"")
	stderr("git config --global core.excludesfile = \"\"")

	# ------ ln -s the RC files
	notice("# ----- creating rc file links")
	cmd = "ls -1 " dotpath "/rc"
	while((cmd | getline fname) > 0) {
		fpath = dotpath "/rc/" fname
		lpath = homedir "/." fname

		bkupFile(fpath)
		rmSymLink(fpath)
		mkSymlink(fpath, lpath)
	}
	close(cmd)

	# ------ ln -s the config dir contents
	notice("# ----- creating config file links")
	cmd = "ls -1 " dotpath "/config"
	while((cmd | getline fname) > 0) {
		fpath = dotpath "/config/" fname
		lpath = homedir "/.config/" fname

		bkupFile(fpath)
		rmSymLink(fpath)
		mkSymlink(fpath, lpath)
	}
	close(cmd)

	# ------ zshenv
	notice("# ------ zshenv")
	stdout(sprintf("echo 'export _LOCAL_ENV_NAME=%s' >> '%s/.zshenv'", envName, homedir))

	# ------ bin files
	notice("# ------ bin files")
	mkDir(homedir "/bin")

	# ------ ssh keys
	notice("# ------ ssh")
	mkDir(homedir "/.ssh")
	stdout("curl -L 'https://github.com/henderjon.keys' >> '" homedir "/.ssh/authorized_keys'")

}
