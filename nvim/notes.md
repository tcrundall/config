# Notes

## Tips

Open nvim with kickstart config using following command:
```bash
  NVIM_APPNAME=nvim-kickstart nvim .
```

## Wishlist

- [ ] less aggressive link hiding in markdown files
- [ ] azure pipelines LSP
- [ ] replace/configure tms better
- [ ] Merge kickstart with current 
  - [x] Split plugins into parts
  - [x] Integrate own plugins
  - [x] Integrate custom mappings and settings
  - [x] Set up lsps
  - [ ] Test out go debugger in kickstarter
- [ ] Smooth notes system
- [ ] Set up incremental selection
- [x] Fancier C# setup
  - [x] code action mapping
  - [x] https://github.com/dense-analysis/ale
    - Don't need ale
  - [ ] Keep eye on [issue for not decompiling type defs](https://github.com/Hoffs/omnisharp-extended-lsp.nvim/issues/26)
    - decompiling yields different "file name" for go-to-definition and go-to-type-definition. Related?
  - [ ] Set "log level" in omnisharp to Information to show logs maybe?
- [ ] advanced grep with filename filtering
- [ ] treesitter highlighting for gotmpl
- [ ] breadcrumbs
  - https://github.com/LunarVim/breadcrumbs.nvim
- [x] git signs
- [ ] azure link
- [ ] fix folding
  - [ ] no folds in finder
  - [ ] doesn't reset on file reentry
- [x] fix nvim tree default width
- [ ] Fancy nested notes system
- [x] Open links in browser
- [x] Don't replace yanked group when pasting
  - [x] Steal from Primeagen's nvim config
- [ ] Write plugin for mapstack as exercise


## TODO
- [ ] read through lsp-zero.txt
- [ ] practice quickfix list
- [ ] practice merge conflict resolution
  - [ ] lazygit?

## Done

- [x] jump to definition from within show definition pane
  - [x] use `go`
  - [x] not imlemented for cs language server....
  - [x] use omnisharp, setup like they suggest
- [x] set up version control on work laptop
