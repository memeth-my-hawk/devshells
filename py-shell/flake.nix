{
  description = "General purpose Python shell with common, popular packages, written in nix, utilizing Nix flakes.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }: {

    
    devShells.x86_64-linux =
      let
        
        pkgs = import nixpkgs { system = "x86_64-linux";}; # packages definition.
        
        my-python-packages = p: with p; [ # my python packages as a neat, tidy list.
          pandas
          seaborn
          matplotlib
          numpy
          jupyter
          scipy
        ];
      in

    {
      default = pkgs.mkShell {
        packages = [
          (pkgs.python3.withPackages my-python-packages)
        ];
        shellHook = ''
            export NIX_SHELL_NAME="py-shell"
            export PS1="\e[0;31m(py-shell)\e[m [\u@\h: \w]\$ "
          '';
        
      };
      
    };  

  };
}

