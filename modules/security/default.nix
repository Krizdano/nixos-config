_: {

  imports = [
    ./doas.nix
    ./pam.nix
  ];

  security.rtkit.enable = true;
  security.polkit.enable = true;
}
