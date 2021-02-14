# dotfiles-config

A version control of my dotfiles (feel free to use this set up if you wish). Using [dotbot](https://github.com/anishathalye/dotbot) for easy installing.

## Instructions 
(mostly for myself, for a more thorough intro refer to [this excellent blog post by the author of dotbot](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/)

To install, run `git clone --recurse-submodules git@github.com:kristian-georgiev/dotfiles-config.git; cd dotfiles-config; ./install`.

For setup-specific configs, I am using a somewhat hacky solution - simply have a `local` subdir with all the additional configs and load all of the files in the main config file; 
to avoid loading the wrong configs I keep dummy empty files corresponding to the other systems in each system, and `dotbot` is nice enough to not overwrite non-symlink files.

I have few systems for which I have separate additional configs, so this works for me. For a more robust solution, you might want a separate repo with local configs, as suggested in the blog post.
