# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load our dotfiles like ~/.bash_prompt, etc…
#   ~/.extra can be used for settings you don’t want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# vim
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# workspace
export WS="$HOME/Workspace"
alias ws="cd $WS"
alias labs="cd $WS/labs"

# chrome
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"