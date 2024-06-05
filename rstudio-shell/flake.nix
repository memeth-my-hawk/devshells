{
  description = "General purpose RStudio shell with common R tools like tidyverse and quarto.";

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
        RStudio-with-my-packages = rstudioWrapper.override{ packages = with rPackages; [ tidyverse prismatic quarto ];};
      in
    {
      default = pkgs.mkShell {
        packages = [
          RStudio-with-my-packages
        ];
        shellHook = ''
            export NIX_SHELL_NAME="rstudio-shell"
            export PS1="\e[0;31m(rstudio-shell)\e[m [\u@\h: \w]\$ "
          '';
        
      };
      
    };  

  };
}

