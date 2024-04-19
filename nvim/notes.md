# Notes

## Target

- [ ] Omnisharp lsp - iron out
  - [ ] Set "log level" in omnisharp to Information to show logs maybe?
  - [ ] Enable package restore?

## Wishlist

- [ ] surround not including spaces
- [ ] Case sensitive substitute
- [ ] Treesitter injection
- [ ] Merge kickstart with current
  - [ ] Test out go debugger in kickstarter
- [ ] Smooth notes system
- [ ] treesitter highlighting for gotmpl
  - https://github.com/LunarVim/breadcrumbs.nvim
- [ ] fix folding
  - [ ] no folds in finder
  - [ ] doesn't reset on file reentry
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
- [ ] practice merge conflict resolution
  - [ ] lazygit?
- [ ] Understand filetype indent stuff: `help filetype.txt`
  - in the meantime, just use :Sleuth to match current file

## Reference
- Transparent background?
  ```lua
      return {
          "xiyaowong/transparent.nvim"
      }
  ```
- [x] Have harpoon on JKL;
  - macros on QWER
  - yanks on ASDF
  - global marks on UIOP

## Notes

### DAP

CSharp
- netcoredbg
  - (( redit post ))[https://www.reddit.com/r/csharp/comments/15ktebq/debugging_with_netcoredbg_in_neovim/]

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

## Process

- Upon each review:
  - Delete all completed tasks
  - Delete all irrelevant tasks
