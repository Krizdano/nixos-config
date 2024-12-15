_: {

  imports = [
    # ./doas.nix
    ./pam.nix
    ./sudo.nix
  ];

  security.rtkit.enable = true;
  security.polkit.enable = true;
}
