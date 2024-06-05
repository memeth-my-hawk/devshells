{
  description = "General purpose Julia shell written in Nix, with flakes.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }: {

    
    devShells.x86_64-linux =
      let
        
        pkgs = import nixpkgs { system = "x86_64-linux";}; # packages definition.
        
      in

    {
      default = pkgs.mkShell {
        packages = with pkgs; [
          julia-bin
        ];
        shellHook = ''
            export NIX_SHELL_NAME="julia-shell"
            export PS1="\e[0;31m(julia-shell)\e[m [\u@\h: \w]\$ "
          '';
        
      };
      
    };  

  };
}

