# Tmux notes

## TODOs

- [ ] Set copy selection conditionally for mac/linux?
  - Currently copy to clipboard doesn't work on linux.
  - I suspect it's because I'm using a mac only clipboard name
  - [SO Post](https://superuser.com/questions/539595/tmux-configuration-conditional-to-os)
- [ ] Set pane jumping keys for other modes
  - One already exists for copy mode. Do similar for other tmux mode
- [x] Send panes to full width/height
- [x] Command for copying current command in shell
- [ ] Smarter moving of pane to far side
- [ ] Lower timeout so I can wait out accidental prefix press
  - [ ] or, use ESC, and bind new key to enter copy mode
    

## Fresh commands

Note: prefix is implicit
- c           Create new window
- n           jump to Next window
- p           jump to Previous window
- )           jump to Next session 
- !           break pane to new window
-             rename current window
- M-left      resize pane by 5

## Issues

- Cannot choose preset arrangment with M-1, M-2, .. M-5

## Tidbits

Tmux server and clients comunicate through a socket in /tmp

## Questions

### Syntax
Case example:
```tmux
  %if "#{==:#{host},myhost}"
  set -g status-style bg=red
  %elif "#{==:#{host},myotherhost}"
  set -g status-style bg=green
  %else
  set -g status-style bg=blue
  %endif
```
Q: What syntax is this in the conditionals? What is the significance of the `#`?
A: FORMATS
The `#{...}` syntax denotes a format string.
The `==:str1,str2` is a string comparison syntax

Can I somehow print the `host` (and other) values?
Q: How to echo?
A: :display "#{host}"

## Command

list-commands         -- list all commands
list-commands lscm    -- show syntax of specific command `lscm`


```tmux
:select-pane -t "{top-right}"
:select-pane -t top-right
```
Identify target with -t flag. Use token to reference pane

### Playing with panes

choose-tree           -- go into tree mode
select-pane -M        -- mark pane
break-pane            -- breaks pane into it's own window
join-pane -s !        -- moves the previous pane into current window
join-pane [-h]        -- moves the marked pane into current window with stacked horizontally


## Formats

Token examples:
- pane_title    #T

Usage:
:display "#{pane_title}"
:display "#T"

## Options

An example of setting pane options to a specific target pane
```tmux
  set -w window-style bg=red
  set -pt:.0 window-style bg=blue
```

