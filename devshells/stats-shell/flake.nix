{
  description = "General purpose nix shell with common statistics tools like R, Python and some of their libraries/packages";

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
          openpyxl
          jupyter
        ];
      in

      with pkgs;
      let
        R-with-my-packages = rWrapper.override{ packages = with rPackages; [ tidyverse prismatic quarto ];}; # R packages with proper settings to make sure both R and RStudio can acccess the packages.
        RStudio-with-my-packages = rstudioWrapper.override{ packages = with rPackages; [ tidyverse prismatic quarto ];};
      in
    {
      default = pkgs.mkShell {
        packages = [
          (pkgs.python3.withPackages my-python-packages)
          R-with-my-packages 
          RStudio-with-my-packages
          julia-bin
        ];
        shellHook = ''
            export NIX_SHELL_NAME="stats-shell"
            PS1="(stats-shell) \u@\h:\w\ $ "
            export PS1="\e[0;31m(stats-shell)\e[m [\u@\h: \w]\$ "
          '';
        
      };
      
    };  

  };
}

