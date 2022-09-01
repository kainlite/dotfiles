### Adopting and testing nvim lua configs

Make sure to have packer available:
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Symlink nvim's config from the dotfiles folder:
```
ln -s ~/.dotfiles/.nvim ~/.config/nvim
```

Install packages:
```
nvim +PackerSync
```

Inspired by https://github.com/simrat39/dotfiles
