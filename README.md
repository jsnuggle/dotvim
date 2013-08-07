vimfiles
========
This is the vim configuration I use daily, based on Vim 7.3 inside of a tmux
session.  It is heavily skewed towards PHP development, since that's what
I spend the majority of my time doing.

I steal heavily from [DeMarko](https://github.com/DeMarko/dotvim).
Thanks dude.

If you're just getting started, you might want to read more about how Pathogen works.  I recommend looking at [this guide](http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/).

I also found [this
article](http://stevelosh.com/blog/2010/09/coming-home-to-vim/) to be very helpful. Take it or leave it.

### how to install ###
this is the quickest way to install these files
    
    # these bits backup your current vim files and get them out of the way
    # skip if you don't have a config or have removed your own
    mv .vim vimfilesbackup
    mv .vimrc vimfilesbackup/vimrcbck

    # once we're clear, we can download and link my vimfiles
    git clone --recursive git://github.com/DeMarko/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc

### updating bundles ###

    git submodule foreach git pull origin master
