HuffShell
====================

HuffShell is a gem for optimizing your ZSH aliases, programtically.

The gems looks at your history which can be automatically stored and generates aliases based on your usage. Your history is used to determine what you use the most and generate the shortest commands based on usage.

For example, you use 'git' 500 times and you use 'ls -l' 100 times. You should add aliases that are 'g' and 'll'. It could save you hundreds of keystokes.

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
# install it
gem install huffman

# need to be able to access this from the gem
alias > ~/.aliases.cache
huffshell

# cleanup
alias > ~/.aliases.cache
```