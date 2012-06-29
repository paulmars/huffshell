Huffshell
====================

Huffshell is a gem for suggesting new aliases, programmatically.

Huffshell looks at your shell history and suggests aliases based on your typical usage. Memorable and short commands are suggested for the most common things you type to save you the most keystrokes.

For example, if you type 'git' 500 times and 'ls -l' 100 times, good aliases might be 'g' and 'll'. It could save you hundreds of keystrokes.

Additionally, huffshell prints out stats on what your usage for people who are just curious.

No changes are made to your shell. Only recommendations are printed to screen.

Features
---------------------

* Alias suggestion based on history.
* Examines your system for binaries and aliases and avoids reassigning them.
* Huffman inspired symbol generation.
* Handy gem packaging.
* Works out of the box with oh-my-zsh.

Installation
---------------------

Here is how you install the gem.

```script
# install the gem (sudo is optional)
sudo gem install huffshell

# need to be able to access this from the gem
alias > ~/.aliases.cache
huffshell

# Optional cleanup
alias > ~/.aliases.cache
```

Update
---------------------

```script
gem update huffshell
````

De-duplication
---------------------

Many people have some form of de-duplication on their ZSH history. That is a great feature but will prevent you from getting all of the benefits of alias generation. If you are curious and want to see a better picture of your shell usage, here is a zsh configuration which remove de-duping and creates a more accurate picture.

```script
## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

setopt append_history
setopt extended_history
# setopt hist_expire_dups_first
# setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
# setopt share_history # share command history data
```
