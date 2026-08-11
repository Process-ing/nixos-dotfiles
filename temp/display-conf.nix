{ pkgs, ... }:

{
  # Install arandr and autorandr
  environment.systemPackages = with pkgs; [
    pkgs.arandr
    pkgs.autorandr
  ];
}