#!/usr/bin/env awk -f

BEGIN{

 	"uname" | getline ostype
	close("uname")

	if(ostype ~ /^[Dd]arwin/){
		notice("# ------ macos dictionary")
		fpath = dotpath "/resources/macos/LocalDictionary"
		lpath = homedir "/Library/Spelling/LocalDictionary"
		bkupFile(fpath)
		rmSymLink(fpath)
		mkSymlink(fpath, lpath)

		whichBrew = "which brew"
		whichBrew | getline brewPath
		if(!is_exec(brewPath)){
			notice("# ------ brew")
			stdout("/usr/bin/env bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"")
		}

		notice("# ------ brew bundle")
		stdout("brew bundle --file='" homedir "/resources/brew/Brewfile'")

		notice("# ------ vscode")
		stdout("code --install-extension '" dotpath "/resources/vscode/monokai22-1.0.0.vsix'")

		hpath = homedir "/Library/Application Support/Code/User/settings.json"
		dfpath = dotpath "/resources/vscode/vcs-settings.json"
		bkupFile(hpath)
		rmSymLink(hpath)
		cpFile(dfpath, hpath)

		notice("# ------ finder")
		# Finder: show path bar
		stdout("defaults write com.apple.finder ShowPathbar -bool true")

		# Finder: show status bar
		stdout("defaults write com.apple.finder ShowStatusBar -bool true")

		# Always show scrollbars
		stdout("defaults write NSGlobalDomain AppleShowScrollBars -string \"Always\"")

		# Use column view in all Finder windows by default
		# Four-letter codes for the other view modes: `icnv`, `Nlsv`, `clmv`, `Flwv`
		stdout("defaults write com.apple.finder FXPreferredViewStyle -string \"clmv\"")

		# Quick look doesn't allow text selection by default, enable it!
		stdout("defaults write com.apple.finder QLEnableTextSelection -bool TRUE")

		stdout("killall Dock")
		stdout("killall Finder")

	}

}
