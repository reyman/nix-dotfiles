{ pkgs, ... }:

let
  sources = import ../../nix/sources.nix;
in

{
  imports = [
    ../../modules/cli.nix
    #../../modules/cuda.nix
    ../../modules/git.nix
    ../../modules/nix-utilities.nix
    # ../../modules/python.nix
    ../../modules/neovim.nix
    ../../modules/languages.nix
    ../../modules/emacs.nix
    ../../modules/ssh.nix
  ];

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "20.09";

  programs.man.enable = false;
  home.extraOutputsToInstall = [ "man" ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraBeforeCompInit = builtins.readFile ../../configs/zsh/fedora_zshrc.zsh;
    plugins = [{
      name = "powerlevel10k";
      src = pkgs.fetchFromGitHub {
        inherit (sources.powerlevel10k) owner repo rev sha256;
      };
    }];
  };

  xdg.configFile."alacritty/alacritty.yml".source = ../../configs/terminal/alacritty.yml;
  services.lorri.enable = true;

}
