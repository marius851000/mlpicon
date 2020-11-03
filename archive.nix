{ pkgs ? import <nixpkgs> {}}:

let
	sources = import ./sources.nix { inherit pkgs; };

	lib = pkgs.lib;

	commandToRun = lib.concatStringsSep "\n" (
			lib.mapAttrsToList (n: v: "ln -s ${v} $out/${v.name}")
		sources );
in
	pkgs.stdenv.mkDerivation {
		name = "mlpicon-archive";

		phases = [ "installPhase" ];

		installPhase = ''
			mkdir $out
			${commandToRun}
		'';
	}
