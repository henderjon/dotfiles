# dotfiles

This is my dotfiles repo.

I put stuff here so that I don't have to try to remember it all.

If you're going to try to install this, try running `bash bootstrap.sh`
from the top level of this repo. This is a simple wrapper to see if
you're in a GH codespace or not. If not, it'll check to see if you've
run it before. To simply see what `bootstrap.sh` does, try running `bash
setup_scripts/instructions.sh` from the top level of this repo. Doing so
will produce a list of commands to run (or you can pipe it to `sh`).

To see specific bits that might not have run, you can view the files in
the "setup_scripts" dir.

As a last step in the installation, I recommend creating a branch and
committing your customizations. To stay up to date, you can run `git
fetch && git rebase origin/dev`. This should apply any of my changes,
but keep your customizations on top. If something goes drastically wrong,
diff origin/dev file by file.
