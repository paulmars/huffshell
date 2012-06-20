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

You need to have zsh_history stored at this location: '~/.zsh_history'. If this code outputs a lot of junk, you are probably setup.

```script
cat ~/.zsh_history
```

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

Fixes
---------------------

Things don't look right? Change your zsh history to these settings to allow your history to save dups and store a lot of entries. You need dups so that we can figure out what to optimize out with aliases and the larger the history, the better the data will be.

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
