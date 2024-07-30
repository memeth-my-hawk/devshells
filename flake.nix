{
  description = "Temporary, general purpose shells with R, Python, RStudio, Julia, pandoc and LaTeX, and PostgreSQL. Written in Nix using flakes.";

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
          openpyxl
        ];
      in

      with pkgs;
      let
        R-with-my-packages = rWrapper.override{ packages = with rPackages; [ tidyverse prismatic quarto IRkernel ];}; # R packages with proper settings to make sure both R and RStudio can acccess the packages.
        RStudio-with-my-packages = rstudioWrapper.override{ packages = with rPackages; [ tidyverse prismatic quarto ];}; # same R definition, only for RStudio environment.
      in
      
      { # Shell definitions start here.

        # Docs shell with pandoc and a small LaTeX subset to create nice PDFs and Word documents from markdown. I particularly like this one.
        docs-shell = pkgs.mkShell {
          buildInputs = with pkgs ; [
            pandoc
            texlive.combined.scheme-small
          ];
          shellHook = ''
            export NIX_SHELL_NAME="docs-shell"
            export PS1="\e[0;31m(docs-shell)\e[m [\u@\h: \w]\$ "
          '';
        };
        
        # A basic Julia shell. Not currently proficient at Julia, I'll get there.
        julia-shell = pkgs.mkShell {
          buildInputs = with pkgs; [
            julia-bin
          ];
          shellHook = ''
            export NIX_SHELL_NAME="julia-shell"
            export PS1="\e[0;31m(julia-shell)\e[m [\u@\h: \w]\$ "
          '';

        };

        # A Python shell with some popular statistics/datasci packages and Jupyter notebook. Might need another shell for vanilla Python itself to avoid downloading all those packages just to try basic stuff. See the package list at the top of the flake.
        py-shell = pkgs.mkShell {
          buildInputs = [
            (pkgs.python3.withPackages my-python-packages)
          ];
          shellHook = ''
            export NIX_SHELL_NAME="py-shell"
            export PS1="\e[0;31m(py-shell)\e[m [\u@\h: \w]\$ "
          '';
        };

        # R shell with some popular packages. Same with Python, might need a vanilla R shell. Also, I still haven't figured out how to use R with IRkernel on Jupyter on NixOS. 

        r-shell = pkgs.mkShell {
          buildInputs = [
            R-with-my-packages
          ];
          shellHook = ''
            export NIX_SHELL_NAME="r-shell"
            export PS1="\e[0;31m(r-shell)\e[m [\u@\h: \w]\$ "
          '';
        };

        # RStudio shell, similar to R shell.

        rstudio-shell = pkgs.mkShell {
          buildInputs = [
            RStudio-with-my-packages
          ];
          shellHook = ''
            export NIX_SHELL_NAME="rstudio-shell"
            export PS1="\e[0;31m(rstudio-shell)\e[m [\u@\h: \w]\$ "
          '';
          };

        # General purpose statistics shell, all in one. Pretty heavy stuff, not very convenient.  
        stats-shell = pkgs.mkShell {
          buildInputs = [
            (pkgs.python3.withPackages my-python-packages)
            R-with-my-packages
            RStudio-with-my-packages
            pkgs.julia-bin
          ];
          shellHook = ''
            export NIX_SHELL_NAME="stats-shell"
            export PS1="\e[0;31m(stats-shell)\e[m [\u@\h: \w]\$ "
          '';

        };

        # A friend of mine wanted to test Java capabilities of this flake as well :)
        java-shell = pkgs.mkShell {
          buildInputs = with pkgs; [
            jdk21_headless
          ];
          shellHook = ''
            export NIX_SHELL_NAME="java-shell"
            export PS1="\e[0;31m(java-shell)\e[m [\u@\h: \w]\$ "
          '';
        };



      }; # Shell definitions end here.
  };
}
