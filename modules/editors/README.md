# Helix Setup

```bash
gc git@github.com:icecreammatt/helix.git
cargo install --locked --path helix-term
```

Checkoug the `tree_with_warnings` branch.  
This branch includes a PR that adds the file  
tree browser and inline warning messages

## Helix link runtime dir
This will fix things like LSP and Themes  
Which need these files configured when building  
from source.

```bash
cd ~/.config/helix
ln -s ~/Source/helix/runtime .
```