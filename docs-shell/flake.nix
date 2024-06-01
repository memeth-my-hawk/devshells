{
  description = "General purpose nix shell with pandoc and LaTeX to edit and create beautiful documents.";

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
        packages = with pkgs ; [
          pandoc
          texlive.combined.scheme-small
        ];
        shellHook = ''
            export NIX_SHELL_NAME="docs-shell"
            PS1="(docs-shell) \u@\h:\w\ $ "
            export PS1="\e[0;31m(docs-shell)\e[m [\u@\h: \w]\$ "
          '';
        
      };
      
    };  

  };
}

