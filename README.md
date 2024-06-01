# My personal `neovim` configuration

# Installation
1. Install `nvim`:
    - MacOS:
        ```bash
        brew install nvim
        ```
    - Arch Linux:
        ```bash
        sudo pacman -S nvim
        ```
    - Ubuntu:
        ```bash
        sudo apt install nvim
        ```
    - Fedora:
        ```bash
        sudo dnf install nvim
        ```

2. Clone this repository to `~/.config/nvim`:
    ```bash
    git clone https://github.com/mtcsla/nvim.git ~/.config
    ```

3. Install `packer.nvim`:


    - Linux/macOS:
        ```bash
        git clone --depth 1 https://github.com/wbthomason/packer.nvim\
        ~/.local/share/nvim/site/pack/packer/start/packer.neovim
        ```
    - Windows (PowerShell):
        ```powershell
        git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
        ```
4. Open `nvim` and run the following:
    1. `:source ~/.config/nvim/init.lua`
    2. `:PackerSync`
    3. `:PackerCompile`

    Skip all of the errors encountered by pressing `Enter`/`Return`, they do not affect the installation.

5. Restart `nvim` and enjoy!


