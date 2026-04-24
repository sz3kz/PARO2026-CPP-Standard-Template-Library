{
  description = "PARO Biblioteka STL";

  # Define dependencies (like the unstable version of nix packages)
  inputs = {          
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Supported: Linux Intel / AMD, Linux ARM, MacOS Intel, Apple Silicon MacOS
      supportedArchitectures = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ]; 

      forAllSystems = nixpkgs.lib.genAttrs supportedArchitectures;

      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; } );
      
    in
    {
      devShells = forAllSystems (system: {
        default = nixpkgsFor.${system}.mkShell {
          buildInputs = with nixpkgsFor.${system}; [
            cmake
            gnumake
            clang
            valgrind
          ];
        };
      });

      packages = forAllSystems (system: {
        default = nixpkgsFor.${system}.stdenv.mkDerivation {
          src = ./.;
        };
      });
    };
}
