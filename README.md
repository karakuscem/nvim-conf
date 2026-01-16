# Neovim Configuration

Personal Neovim configuration with full Java/Spring Boot development support.

> **Leader key:** `<Space>`

---

## � Getting Started (For Beginners)

### Understanding Vim Modes

Neovim/Vim is a **modal editor**, meaning it has different modes for different tasks. This is what makes it powerful!

| Mode | Purpose | How You Know You're In It |
|------|---------|---------------------------|
| **Normal** | Navigate, delete, copy, paste commands | Default mode, no indicator or `NORMAL` in statusline |
| **Insert** | Type text like a regular editor | `-- INSERT --` in statusline |
| **Visual** | Select text | `-- VISUAL --` in statusline |
| **Command** | Run commands (save, quit, search) | `:` appears at bottom of screen |

### How to Change Modes

```
                     i, a, o, s, c
              ┌─────────────────────────┐
              │                         ▼
        ┌─────┴─────┐            ┌───────────┐
        │  NORMAL   │◄───Esc─────│  INSERT   │
        └─────┬─────┘            └───────────┘
              │
         v, V, Ctrl+v
              │
              ▼
        ┌───────────┐
        │  VISUAL   │────Esc────► NORMAL
        └───────────┘
```

#### Entering Insert Mode (from Normal)

| Key | What it does |
|-----|--------------|
| `i` | Insert before cursor |
| `I` | Insert at beginning of line |
| `a` | Insert after cursor |
| `A` | Insert at end of line |
| `o` | Open new line below and insert |
| `O` | Open new line above and insert |

#### Entering Visual Mode (from Normal)

| Key | What it does |
|-----|--------------|
| `v` | Select characters |
| `V` | Select whole lines |
| `Ctrl+v` | Select a block/column |

#### Back to Normal Mode (from any mode)

| Key | What it does |
|-----|--------------|
| `Esc` | Return to Normal mode |
| `Ctrl+c` | Return to Normal mode (same as Esc in this config) |
| `Ctrl+[` | Return to Normal mode (alternative) |

> 💡 **Tip:** If you're ever lost or stuck, press `Esc` a few times to get back to Normal mode!

---

### How to Read Keybinds

This config uses standard Vim notation for keybinds:

| Notation | What to Press | Example |
|----------|---------------|---------|
| `<C-x>` | Hold `Ctrl` and press `x` | `<C-d>` = Ctrl + d |
| `<S-x>` | Hold `Shift` and press `x` | `<S-Tab>` = Shift + Tab |
| `<A-x>` or `<M-x>` | Hold `Alt` and press `x` | `<A-j>` = Alt + j |
| `<leader>` | Press `Space` (in this config) | `<leader>ff` = Space, then f, then f |
| `<CR>` | Press `Enter` | |
| `<Esc>` | Press `Escape` | |
| `<Tab>` | Press `Tab` | |
| `<F2>` | Press the F2 function key | |
| `gg` | Press `g` twice quickly | |
| `gd` | Press `g` then `d` quickly | |

#### Examples

| Keybind | How to Actually Press It |
|---------|--------------------------|
| `<C-d>` | Hold Ctrl, press d |
| `<C-u>` | Hold Ctrl, press u |
| `<leader>ff` | Press Space, then f, then f |
| `<leader>jo` | Press Space, then j, then o |
| `<S-Tab>` | Hold Shift, press Tab |
| `<C-Space>` | Hold Ctrl, press Space |
| `gd` | Press g, then d |
| `gi` | Press g, then i |

---

### Basic Survival Commands

| What You Want | Keys to Press | Mode |
|---------------|---------------|------|
| Save file | `:w` then Enter | Normal |
| Quit | `:q` then Enter | Normal |
| Save and quit | `:wq` then Enter | Normal |
| Quit without saving | `:q!` then Enter | Normal |
| Undo | `u` | Normal |
| Redo | `Ctrl+r` | Normal |
| Search for text | `/searchterm` then Enter | Normal |
| Next search result | `n` | Normal |
| Previous search result | `N` | Normal |

---

### Basic Movement (Normal Mode)

| Key | Movement |
|-----|----------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |
| `w` | Next word |
| `b` | Previous word |
| `0` | Beginning of line |
| `$` | End of line |
| `gg` | Beginning of file |
| `G` | End of file |
| `Ctrl+d` | Half page down |
| `Ctrl+u` | Half page up |

---

## �📦 Plugins

- **Plugin Manager:** lazy.nvim
- **LSP:** nvim-lspconfig, nvim-jdtls (Java)
- **Completion:** nvim-cmp
- **Fuzzy Finder:** telescope.nvim
- **File Navigation:** harpoon
- **Syntax:** nvim-treesitter
- **Debugging:** nvim-dap, nvim-dap-ui
- **Git:** vim-fugitive
- **Statusline:** lualine.nvim
- **Theme:** tokyonight.nvim

---

## ⌨️ Keybinds

### General / Navigation

| Mode | Keybind | Action |
|------|---------|--------|
| n | `<leader>cd` | Open file explorer (netrw) |
| n | `J` | Join lines (cursor stays in place) |
| n | `<C-d>` | Page down (centered) |
| n | `<C-u>` | Page up (centered) |
| n | `n` | Next search result (centered) |
| n | `N` | Previous search result (centered) |
| n | `Q` | Disabled (no Ex mode) |
| i | `<C-c>` | Escape insert mode |

### Moving Lines

| Mode | Keybind | Action |
|------|---------|--------|
| v | `J` | Move selected lines down |
| v | `K` | Move selected lines up |

### Clipboard / Yank

| Mode | Keybind | Action |
|------|---------|--------|
| x | `<leader>p` | Paste without replacing clipboard |
| n, v | `<leader>d` | Delete to black hole register |
| n | `<leader>y` | Yank with OSC52 (works over SSH) |
| v | `<leader>y` | Yank selection with OSC52 |

### Quickfix List

| Mode | Keybind | Action |
|------|---------|--------|
| n | `<C-j>` | Next quickfix item |
| n | `<C-k>` | Previous quickfix item |
| n | `<leader>cn` | Next quickfix item |
| n | `<leader>cp` | Previous quickfix item |
| n | `<leader>co` | Open quickfix list |
| n | `<leader>cl` | Close quickfix list |

### Location List

| Mode | Keybind | Action |
|------|---------|--------|
| n | `<leader>k` | Next location item |
| n | `<leader>j` | Previous location item |

### Utilities

| Mode | Keybind | Action |
|------|---------|--------|
| n | `<leader>s` | Replace word under cursor (on line) |
| n | `<leader>x` | Make file executable |
| n | `<leader>rl` | Reload Neovim config |
| n | `<leader>u` | Toggle Undotree |
| n | `<leader>mm` | Run `:make` |
| n | `<leader><leader>` | Source current file |
| n | `<leader>dg` | Generate documentation (DoGe) |
| n | `<leader>cc` | PHP CS Fixer on current file |
| n | `<leader>li` | LSP health check |

---

### 🔭 Telescope (Fuzzy Finder)

| Mode | Keybind | Action |
|------|---------|--------|
| n | `<leader>ff` | Find files |
| n | `<leader>fo` | Find old/recent files |
| n | `<leader>fq` | Find in quickfix |
| n | `<leader>fh` | Find help tags |
| n | `<leader>fb` | Find buffers |
| n | `<leader>fg` | Grep search (enter pattern) |
| n | `<leader>fc` | Find current filename in files |
| n | `<leader>fs` | Find string under cursor |
| n | `<leader>fi` | Find files in nvim config |

**Inside Telescope:**

| Mode | Keybind | Action |
|------|---------|--------|
| i | `<C-k>` | Move to previous result |
| i | `<C-j>` | Move to next result |
| i | `<C-q>` | Send to quickfix list |

---

### 🎯 Harpoon (Quick File Switching)

| Mode | Keybind | Action |
|------|---------|--------|
| n | `<leader>a` | Add file to Harpoon list |
| n | `<C-e>` | Toggle Harpoon quick menu |
| n | `<leader>fl` | Open Harpoon list in Telescope |
| n | `<C-p>` | Previous Harpoon file |
| n | `<C-n>` | Next Harpoon file |

---

### ✏️ Completion (nvim-cmp)

| Mode | Keybind | Action |
|------|---------|--------|
| i | `<CR>` | Confirm completion |
| i | `<C-e>` | Abort completion |
| i | `<C-Space>` | Trigger completion manually |
| i | `<C-n>` | Next completion item |
| i | `<C-p>` | Previous completion item |
| i | `<C-f>` | Scroll docs down |
| i | `<C-u>` | Scroll docs up |
| i, s | `<Tab>` | Next completion item |
| i, s | `<S-Tab>` | Previous completion item |

---

### 🔧 LSP (Language Server Protocol)

| Mode | Keybind | Action |
|------|---------|--------|
| n | `K` | Hover documentation |
| n | `gd` | Go to definition |
| n | `gD` | Go to declaration |
| n | `gi` | Go to implementation |
| n | `go` | Go to type definition |
| n | `gr` | Find references |
| n | `gs` | Signature help |
| n | `gl` | Show diagnostics float |
| n | `<F2>` | Rename symbol |
| n, x | `<F3>` | Format code |
| n | `<F4>` | Code actions |

---

### ☕ Java-Specific (in .java files)

| Mode | Keybind | Action |
|------|---------|--------|
| n | `<leader>jo` | Organize imports |
| n | `<leader>jv` | Extract variable |
| v | `<leader>jv` | Extract variable (selection) |
| n | `<leader>jc` | Extract constant |
| v | `<leader>jc` | Extract constant (selection) |
| v | `<leader>jm` | Extract method |
| n | `<leader>jt` | Test nearest method |
| n | `<leader>jT` | Test class |
| n | `<leader>ju` | Update project config |

---

### 🐛 Debugging (DAP)

| Mode | Keybind | Action |
|------|---------|--------|
| n | `<leader>db` | Toggle breakpoint |
| n | `<leader>dB` | Conditional breakpoint |
| n | `<leader>dc` | Continue / Start debugging |
| n | `<leader>di` | Step into |
| n | `<leader>do` | Step over |
| n | `<leader>dO` | Step out |
| n | `<leader>dr` | Toggle REPL |
| n | `<leader>dl` | Run last debug config |
| n | `<leader>dt` | Terminate debug session |
| n | `<leader>du` | Toggle debug UI |

---

## 📝 Mode Legend

- `n` = **Normal mode** - For navigation and commands (press `Esc` to enter)
- `i` = **Insert mode** - For typing text (press `i`, `a`, or `o` to enter)
- `v` = **Visual mode** - For selecting text (press `v` to enter)
- `x` = **Visual block mode** - For column selection (press `Ctrl+v` to enter)
- `s` = **Select mode** - Similar to visual (rarely used)

> 💡 **Remember:** Most keybinds in this config work in Normal mode. If a keybind isn't working, press `Esc` first!

---

## 🛠️ LSP Servers Installation

### Managed by Mason (`:Mason`)
- **jdtls** - Java Language Server
- **java-debug-adapter** - Java debugging
- **java-test** - Java test runner

### Manual Installation

1. **lua-language-server**
   ```bash
   # Arch Linux
   pacman -S lua-language-server
   ```

2. **CSS/HTML Language Server**
   ```bash
   npm install -g vscode-langservers-extracted
   ```

3. **PHP (Intelephense)**
   ```bash
   npm install -g intelephense
   ```

4. **TypeScript/JavaScript**
   ```bash
   npm install -g typescript-language-server typescript
   ```

5. **Rust Analyzer**
   ```bash
   rustup component add rust-analyzer
   ```

6. **Zig Language Server**
   ```bash
   # Install zls from your package manager or build from source
   ```

7. **Nix Language Server**
   ```bash
   nix-env -iA nixpkgs.nil
   ```

8. **Haskell Language Server**
   ```bash
   ghcup install hls
   ```

---

## ☕ Java/Spring Boot Development

### Requirements
- Java 17+ (JAVA_HOME must be set)
- Maven or Gradle

### Features
- Full LSP support (completion, diagnostics, refactoring)
- Debugging with breakpoints
- Test runner integration
- Spring Boot annotations support
- Auto-import organization

### Commands
- `:LspInfo` - Show attached LSP clients
- `:Mason` - Open Mason package manager
- `:JdtCompile` - Compile the project
- `:JdtUpdateConfig` - Reload project configuration

---

## 🆘 Quick Reference Card

### I want to...

| Task | Keys | Mode to Start In |
|------|------|------------------|
| **Save my file** | `:w` Enter | Normal |
| **Quit Neovim** | `:q` Enter | Normal |
| **Find a file** | Space f f | Normal |
| **Search in project** | Space f g | Normal |
| **Go to definition** | g d | Normal |
| **See documentation** | K (shift+k) | Normal |
| **Rename variable** | F2 | Normal |
| **Format code** | F3 | Normal |
| **Quick fix / actions** | F4 | Normal |
| **Toggle file explorer** | Space c d | Normal |
| **Add file to quick list** | Space a | Normal |
| **Open quick list** | Ctrl e | Normal |
| **Set breakpoint** | Space d b | Normal |
| **Start debugging** | Space d c | Normal |
| **Organize imports (Java)** | Space j o | Normal |
| **Run test (Java)** | Space j t | Normal |

---

## 💡 Tips for Beginners

1. **Don't panic!** Press `Esc` multiple times if you're stuck
2. **Practice the basics first:** `h j k l` for movement, `i` to type, `Esc` to stop
3. **Use `:w` often** to save your work
4. **Leader key is Space** - many commands start with pressing Space
5. **Commands are composable:** `d` = delete, `w` = word, so `dw` = delete word
6. **Run `:Tutor`** for an interactive Vim tutorial built into Neovim

