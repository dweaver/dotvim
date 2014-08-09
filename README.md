Vim Plug-in Management with Pathogen and Git
--------------------------------------------
(via http://mirnazim.org/writings/vim-plugins-i-use/)

0.) Setup a new machine
```
$ cd ~
$ git clone --recursive git@github.com:dweaver/dotvim.git .vim
$ ln -s .vim/.vimrc .vimrc
$ ln -s .vim/Xresources .Xresources
```

1.) Add a new plugin

```
$ mv /path/to/plugin ~/.vim/bundle/plugin_name 
$ cd ~/.vim
$ git submodule add git://github.com/tpope/vim-fugitive.git bundle/fugitive
$ git submodule init && git submodule update
```

2.) Pull latest upstream changes to plugins
```
$ git submodule foreach git pull
```

3.) Remove a plugin
    (via http://stackoverflow.com/questions/1260748/how-do-i-remove-a-git-submodule)
    1. Delete the relevant line from .gitmodules file
    2. Delete the relevant section from .git/config
    3. Run git rm --cached path_to_submodule (no trailing slash)
    4. Commit and delete the now untracked submodule files

