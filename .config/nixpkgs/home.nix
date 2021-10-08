{ config, pkgs, ... }:

{
  # allow non-free software
  nixpkgs.config.allowUnfree = true;

  # for now just install these pkgs, do not use home-manager
  # to manage my dotfiles

  home.packages = with pkgs; [
    # terminal
    alacritty

    # CLI
    curl
    ffmpeg
    git
    htop
    imagemagick
    neofetch
    mpv
    openssl
    ripgrep
    sqlite
    tmux
    tokei
    wget
    youtube-dl
    zsh		# macOS zshell seems trashy

    # C/C++
    #clang_12
    #gcc11

    # clojure
    openjdk16
    clojure
    leiningen

    # editors
    neovim

    # javascript
    nodejs-16_x

  ];

  nixpkgs.overlays = [
    # Import emacs-overlay
    (import (builtins.fetchTarball {
      #Then you can replace the word `master' in there (which is the branch name)
      #with a commit id (for exapmle 3c649677294bdedb776ec69b14719b7171666a8a
      #which is the latest commit on master as of writing).
      #url = https://github.com/nix-community/emacs-overlay/archive/f2c57ef22b058a9a8ffdc746259cbbcea7595e95.tar.gz;
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
    # Apply patch to emacsGit (in emacs-overlsy)
    # (self: super: {
    #   emacsGit = super.emacsGit.overrideAttrs (oldAttrs: rec {
    #     patches = oldAttrs.patches ++ [ ./no-titlebar.patch ];
    #   });
    # })
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit-nox;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "errelin";
  home.homeDirectory = "/Users/errelin";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

}
