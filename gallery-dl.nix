{ stdenv, gallery-dl }:

{
	url,
	sha256 ? "",
	name ? "gallery-dl-download",
}:

stdenv.mkDerivation {
	inherit name sha256;

	phases = [ "buildPhase" "installPhase" ];

	buildPhase = ''
		gallery-dl ${url} -o .
	'';

	installPhase = ''
		touch $out
		echo mv $(find gallery-dl -type f) $out
		mv "$(find gallery-dl -type f)" $out
	'';

	nativeBuildInputs = [ gallery-dl ];

	outputHashAlgo = "sha256";
	outputHash = sha256;
	outputHashMode = "flat";
}
