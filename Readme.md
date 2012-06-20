HuffShell
====================

HuffShell is a gem for optimizing your ZSH aliases, programmatically.

The gems looks at your history which can be automatically stored and generates aliases based on your usage. Your history is used to determine what you use the most and generate the shortest commands based on usage.

For example, you use 'git' 500 times and you use 'ls -l' 100 times. You should add aliases that are 'g' and 'll'. It could save you hundreds of keystrokes.

In order to do that, huffshell generates stats of your usage and gives them to you, as you might hope.

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
# install the gem
gem install huffshell

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

Many people have some form of deduplication on their ZSH history. That is a gret feature but will prevent you from getting all of the benifits of alias generation. If you are curious and want to see a better picture of your shell usage, here is a zsh configuration which remove deduping and creates a more accurate picture.

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
