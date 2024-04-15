# Notes

## Target

- [ ] Omnisharp lsp - iron out
  - [ ] Set "log level" in omnisharp to Information to show logs maybe?
  - [x] Set up commands for reattaching to current buffer
    - this is just :e, or insert some text change and :w
  - [ ] Enable package restore?
- [x] azure link

## Wishlist

- [ ] Have harpoon on JKL;
  - macros on QWER
  - yanks on ASDF
  - global marks on UIOP
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
- [x] Harpoon
  - [x] hotkeys
  - [x] Update to v2
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


## Process

- Upon each review:
  - Delete all completed tasks
  - Delete all irrelevant tasks
