# Notes

Go to [waiting for](#waiting-for)

## Target

- [ ] Omnisharp lsp - iron out
  - [ ] Set "log level" in omnisharp to Information to show logs maybe?
  - [ ] Enable package restore?

## Wishlist

- [ ] Smart imports for go
- [ ] Extend link follower to follow file names
- [ ] Get conceal behaving nicely in markdown
- [x] Jump to linked markdown header
- [ ] Add zz after ( or )
- [ ] Set up error format and mappings for dotnet test
- [ ] Force LSP to reload all open buffers (e.g. what I expect with `e!`)
- [ ] surround not including spaces
- [ ] Fix cmp suggestion not being top of list
- [ ] Treesitter injection
- [ ] Smooth notes system
- [ ] treesitter highlighting for gotmpl
  - https://github.com/LunarVim/breadcrumbs.nvim
- [ ] commentary
  - don't auto inject comments below or above?
- [ ] Fix testing
  - [x] Get it working
    - Configure nvim with -u /path/to/init.lua
    - Configure test with, e.g.:
    ```bash
      -c "PlenaryBustedDirectory /path/to/tests/ {minimal_init = '/path/to/init.lua'}"
    ```
  - [ ] Set up keymaps and central minimal init

## TODO
- [ ] Understand filetype indent stuff: `help filetype.txt`
  - in the meantime, just use :Sleuth to match current file
- [ ] Look into [searching all buffers](https://stackoverflow.com/questions/2450887/vim-searching-through-all-existing-buffers)

## Reference
- Transparent background?
  ```lua
      return {
          "xiyaowong/transparent.nvim"
      }
  ```
- Standardized registers
  - harpoon on <meta> JKL;
  - macros on QWER
  - yanks on ASDF
  - local marks on asdf
  - global marks on ASDF

## Waiting for

- [ ] Project to upgrade to dotnet 8.0 so I can use csharp-ls

## Notes

### DAP

Go to [waitingfor](#waiting-for)

CSharp
- netcoredbg
  - [redit post](https://www.reddit.com/r/csharp/comments/15ktebq/debugging_with_netcoredbg_in_neovim/)
  - [blogpost](https://aaronbos.dev/posts/debugging-csharp-neovim-nvim-dap)

go
1. set a break point in test
2. set nvim root where go.mod is
3. Start test:
  - go: <F5> and choose debug (go.mod)
  - python: <leader>dm for method, or <leader>dc for class


To give attach privileges... but doesnt' seem to attach anyway
```bash
 sudo echo "0" > /proc/sys/kernel/yama/ptrace_scope
```

Manually debugging a test can be done so:
1. Start the test in debug mode
```bash
VSTEST_HOST_DEBUG=1 dotnet test path/to/*dll
```
2. Wait for the PID to be displayed, substitute as <pid> below
```bash
netcoredbg -ex "break src/App/Program.cs:50" --attach <pid>
```

Another example
```bash
VSTEST_HOST_DEBUG=1 dotnet test --filter "FullyQualifiedName~ResourceConfigSuccessfullyParsesValidOrMissingEnvironmentVariables" path/to/*.dll
netcoredbg -ex "break UnitTests/Resource/ResourceConfigTest.cs:30" --attach 20985
```
2 commands
Trigger test, then send a netcoredbg command with appropriate ID

## Process

- Upon each review:
  - Delete all completed tasks
  - Delete all irrelevant tasks

### Csharp LSP

csharp_ls seems more stable, but only works for .NET 8
when finally viable, can also use extended lsp just like omnisharp:
[csharpls-extended](https://github.com/Decodetalkers/csharpls-extended-lsp.nvim)

## Getting links to work

Go to [waiting for](#waiting-for)
- [tflint](https://github.com/terraform-linters/tflint#installation)
go to [file](../tmux/notes.md)
go to [pdf](~/Google_Drive/ECKRZV.pdf)
go to [png](~/Pictures/algorithms.png)
go to [jpg](~/Pictures/australian_media_ bias copy.jpg)
file with [spaces](../some file.txt)

- [dotnet-sdk](https://dotnet.microsoft.com/download) (see [global.json](https://dev.azure.com/cmd-sw/Discoverer/_git/chimerys?path=%2Fglobal.json&_a=contents) for required version)

* In the main directory, log in to the nuget feed with `dotnet restore --interactive`. If it fails, you might need to (re-)install the [Azure Artifacts credential provider](https://dev.azure.com/cmd-sw/Discoverer/_artifacts/feed/discoverer-nuget/connect) and/or run `dotnet tool restore`.


### Handling edge cases

#### Case 1
Inside square brackets
             ↓
...(...)...[.█.](...)....

#### Case 2
Inside round brackets
                  ↓
...(...)...[...](l█ink)....)

#### Case 3
Before square brackets
         ↓
...(...).█.[...](mylink)....

#### Case 4
Between two links
           ↓
[...](...).█.[...](...)....

#### Case 5
Before unrelated round brackets
 ↓
.█.(...)...[...](...)....

#### Case 6
Inside unrelated round brackets
              ↓
(.[...](...)..█.)



1. Find ")" on the right closest to cursor
2. Find closest "(" to the left of ")"
3. If "(" is not preceeded by "]", then start again

- (re-)ins [link](https://dev.azure.com/cmd-sw/Discoverer/) 
- asdf (sdf) asdf
- asdfas ) as;fdlksaj
(see [global.json](https://dev.azure.com/cmd-sw/Discoverer/2) for required version) ns [link](https://dev.azure.com/cmd-sw/Discoverer/3) )
