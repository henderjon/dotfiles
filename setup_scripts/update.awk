#!/usr/bin/env awk -f

BEGIN{

	homedir = ENVIRON["HOME"]
	if(homedir == ""){
		fatal("$HOME is undefined")
	}

	"pwd" | getline dotpath
	close("pwd")

	dtcmd = "date '+%Y.%m.%dT%H.%M.%S'" # -u for UTC
	dtcmd | getline dtstamp
	close(dtcmd)

	bkpath = dotpath "/bkups/" dtstamp
	mkDir(bkpath)

	vcs_settings_file="vcs-settings.json"
	cpFile(homedir "/Library/Application Support/Code/User/settings.json", bkpath "/" vcs_settings_file)

	subl_color_settings="Monokai22.sublime-color-scheme"
	cpFile(homedir "/Library/Application Support/Sublime Text/Packages/User/" subl_color_settings, bkpath "/" subl_color_settings)

	subl_settings_file="Preferences.sublime-settings"
	cpFile(homedir "/Library/Application Support/Sublime Text/Packages/User/" subl_settings_file, bkpath "/" subl_settings_file)

	stdout("brew bundle dump --file='" bkpath "/Brewfile'")

}
