let
  nixpkgs = builtins.fetchTarball https://github.com/nixos/nixpkgs/archive/7508490770ba490ad767d230241822129da70672.tar.gz;
  pkgs = import nixpkgs {};
  nixopsSrc = pkgs.fetchFromGitHub {
    owner = "andir";
    repo = "nixops";
    rev = "c7eba12e4efff0af5310734f0eecf900025764fd";
    sha256 = "1vlxa8k6hpipql02lcf03nvzsa9p164f2rvgifd5ckxjp156yk71";
  };

  nixops = (import (nixopsSrc + "/release.nix") { nixpkgs = pkgs.path; });
in
pkgs.mkShell {
  buildInputs = [ nixops.build.x86_64-linux ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${pkgs.path}"
  '';
}
