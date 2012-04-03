This plugin will hold various tools I can think of for dealing with coffeescript. For now, there are a couple of these:

  - A "live preview" feature that's a bit different from the one in the official [coffeescript runtime files](https://github.com/kchmck/vim-coffee-script).
  - A "delete and dedent" mapping that deletes the current line and fixes anything that's indented below it.
  - An "open line above and indent" mapping that indents the visually selected area and opens up a new line above.
  - A pair of "paste" mappings to paste some code, maintaining the level of indentation of the current line.
  - A function text object, providing mappings like "cif" and "vaf" to
    easily manipulate functions
  - Some minor syntax extensions

Since it's a work in progress, it's not published on vim.org and has no documentation for now. If you feel like using it, and you encounter any problems, please open an issue on github's bugtracker.
