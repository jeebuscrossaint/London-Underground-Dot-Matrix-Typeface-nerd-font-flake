{
  description = "London Underground Dot Matrix Patched Nerd Fonts Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.london-underground-dot-matrix-fonts = 
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.stdenv.mkDerivation {
        pname = "london-underground-dot-matrix-fonts";
        version = "1.0.0";
        src = ./font;
        installPhase = ''
          install -Dm644 $src/*.{ttf,otf} -t $out/share/fonts/truetype
        '';
        meta = with pkgs.lib; {
          description = "London Underground Dot Matrix Patched Nerd Fonts";
          license = licenses.ofl;
        };
      };

    # For home-manager or system-wide use
    homeManagerModules.default = { config, ... }: {
      fonts.fonts = [ self.packages.x86_64-linux.london-underground-dot-matrix-fonts ];
    };
  };
}