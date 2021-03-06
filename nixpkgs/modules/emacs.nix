{ config, pkgs, libs, ... }:

let
  sources = import ../nix/sources.nix;
  nixos-unstable = import sources.nixos-unstable { };
in

{
  home.packages = with pkgs; [
      languagetool
      mu
      isync
      sqlite
      ispell
    ];

  programs.emacs = {
    enable = true;
    package = nixos-unstable.emacsGccPgtkWrapped;
    # extraPackages = (epkgs: [ epkgs.vterm ] );
  };

}
