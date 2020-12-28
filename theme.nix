{ pkgs ? import <nixpkgs> {}}:

with builtins;

let
	sources = import ./sources.nix {inherit pkgs; };

	lib = pkgs.lib;

	stdenv = pkgs.stdenv;

	convert_image = transfo: image: name: stdenv.mkDerivation {
		inherit name;
		phases = [ "installPhase" ];
		installPhase = ''
			convert ${image} ${transfo} $out
		'';
		nativeBuildInputs = [ pkgs.imagemagick ];
	};

	unzip = source: pkgs.stdenv.mkDerivation {
		name = "unpacked-stuff";

		phases = [ "installPhase" ];

		installPhase = ''
			mkdir $out
			cd $out
			unzip ${source}
		'';

		nativeBuildInputs = [ pkgs.unzip ];
	};

	index = "
[Icon Theme]
Name=pony-icon
Comment=Pony Icon
Directories=apps/64,apps/256,apps/512
Inherits=Papirus-Dark,breeze-dark,hicolor

[apps/64]
Size=64
Context=Applications

[apps/256]
Size=256
Context=Applications
";

	LOIconPack = unzip sources.LOIconPack;

	pikmin789_icon_pack_v4 = unzip sources.pikmin789_icon_pack_v4;

	cropped_firefox = convert_image "-crop 1920x1920+150+279" sources.firefox_icon "firefox_icon_cropped.png";

	cropped_discord = convert_image "-crop 398x398+50+73" sources.discord_icon "discord_icon_cropped.png";

	cropped_golden_note = convert_image "-crop 1464x1464+56+54 -fuzz 10% -transparent 'rgb(11,11,11)'" sources.mlk_golden_note_avatar "golden_note_cropped.png";
in
pkgs.stdenv.mkDerivation {
	name = "ponyiconpack";

	phases = [ "buildPhase" "installPhase" ];
	buildPhase = ''
		mkdir pack
		cp ${builtins.toFile "index.theme" index} pack/index.theme
		mkdir -p pack/apps/256
		mkdir -p pack/apps/64
		mkdir -p pack/apps/512
		# libre office
		${lib.concatStringsSep "\n" (
			lib.mapAttrsToList (k: v: ''
				ln -s ${LOIconPack}/png/${k}.png pack/apps/256/${v}.png
				# resize to a more standard size
				ln -s ${convert_image "-resize 64x64!" (stdenv.mkDerivation {
					name = "non-resized-image";
					phases = "installPhase";
					installPhase = "cp ${LOIconPack}/png/${k}-*.png $out";
				}) "libreoffice-pony-${v}-resized.png"} pack/apps/64/${v}.png
			'')
			{
				Base = "base";
				Calc = "calc";
				Draw = "draw";
				Impress = "impress";
				LibreOffice = "startcenter";
				Math = "math";
				Writer = "writer";
			}
		)}

	# firefox
	ln -s ${sources.firefox_icon_fluttershy} pack/apps/256/firefox.png
	# discord
	ln -s ${convert_image "-resize 256x256!" cropped_discord "discord_icon_resized.png"} pack/apps/256/discord.png
	# pikmin789 icon pack v4
	${
		lib.concatStringsSep "\n" (
			lib.mapAttrsToList (k: v: ''
					ln -s ${convert_image "-resize 256x256!" "\"${pikmin789_icon_pack_v4}/MLP Icons/${v}\"\\[8]" "icon.png"} pack/apps/256/${k}.png
			'')
			{
				steam_icon_4000 = "gmod.ico";
				steam_icon_220 = "half life 2.ico";
				steam_icon_400 = "portal.ico";
				steam_icon_489830 = "skyrim.ico.ico";
				"osu!" = "osu!.ico";
			}
		)
	}

	# my little karaoke
	ln -s ${convert_image "-resize 512x512!" cropped_golden_note "golden_note_resized.png"} pack/apps/512/my-little-karaoke.png

	# embedded icon
	# steam, based on papirus-dark and the picture id 767915 on derpibooru
	ln -s ${./icon/steam.svg} pack/apps/256/steam.svg
	'';

	installPhase = ''
		mkdir -p $out/share/icons/ponyicon
		cp -r pack $out/share/icons/ponyicon
	'';
}
