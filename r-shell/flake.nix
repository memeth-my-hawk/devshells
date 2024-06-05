{
  description = "General purpose R shell with common, popular libraries like tidyverse and quarto.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }: {

    
    devShells.x86_64-linux =
      let
        
        pkgs = import nixpkgs { system = "x86_64-linux";}; # packages definition.
        
      in
      
      with pkgs;
      let
        jupyter = pkgs.jupyter;
        R-with-my-packages = rWrapper.override{ packages = with rPackages; [ tidyverse prismatic quarto IRkernel ];}; # R packages with proper settings to make sure both R and RStudio can acccess the packages.
      in
    {
      default = pkgs.mkShell {
        packages =  [
          R-with-my-packages
          jupyter
        ];
        shellHook = ''
            export NIX_SHELL_NAME="r-shell"
            export PS1="\e[0;31m(r-shell)\e[m [\u@\h: \w]\$ "
          '';
        
      };
      
    };  

  };
}

