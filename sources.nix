{ pkgs }:

let
	gallery-dl-download = pkgs.callPackage ./gallery-dl.nix {};
in
{
	LOIconPack = ./downloaded_from_deviantart/LOIconPack.zip; /*gallery-dl-download {
		url = "https://www.deviantart.com/nyan-ptx/art/LibreOffice-Pony-icon-pack-Derpy-icon-added-417587196";
		name = "LOIconPack.zip";
		sha256 = "UyHc0O56AEkJbn1A7MZ+tCG9hOgiGDnVnEq5r1XZ7Ws=";
	};*/

	firefox_icon = ./downloaded_from_deviantart/firefox_icon.png; /*gallery-dl-download {
		url = "https://www.deviantart.com/noreasontohope/art/My-Little-Browser-Firefox-260640031";
		name = "firefox_icon.png";
		sha256 = "Y1M4e4u1xpNggRG7tVHUdpbWLCmEBlTKyYcBzPMtTk4=";
	};*/

	firefox_icon_fluttershy = ./downloaded_from_deviantart/firefox_icon_fluttershy.png; /*gallery-dl-download {
		url = "https://www.deviantart.com/razorphoenix/art/Flutterfox-Icon-417718230";
		name = "firefox_icon_flutterhsy.png";
		sha256 = "JQ7q/W+3lFTID0gVdgZg7ielh3iE3PNNVHs2TFvIFfE=";
	};*/

	discord_icon = gallery-dl-download {
		url = "https://derpicdn.net/img/download/2016/3/22/1114219.png";
		name = "discord_icon.png";
		sha256 = "Sc9RKCGYjWea+sbPZ2vXM+LrVoQE1PQ6vp3I0xYviwM=";
	};

	pikmin789_icon_pack_v4 = ./downloaded_from_deviantart/pikmin789_icon_pack_v4.zip; /*gallery-dl-download {
		url = "https://www.deviantart.com/pikmin789/art/My-Little-Pony-Windows-Icons-v4-316011226";
		name = "pikmin789_icon_pack_v4.zip";
		sha256 = "mprdfasVr8Sav4tujMcEsnyQcpy477y8+/atQ5ByN2A=";
	};*/

	mlk_golden_note_avatar = ./downloaded_from_deviantart/mlk_golden_note_avatar.png; /*gallery-dl-download {
		url = "https://www.deviantart.com/strykarispeeder/art/Golden-Notes-OC-Avatar-596817002";
		name = "mlk_golden_note_avatar.png";
		sha256 = "jzlCbkGfsm34al6YHhhHKaMh4GxgUtFyY37lpBCYff0=";
	};*/

	vlc_icon = pkgs.fetchurl {
		url = "https://derpicdn.net/img/download/2012/10/11/119760.png";
		name = "vlc_icon.png";
		sha256 = "3eH7ArRYV/LAagYtET3udgNKFZ0f2lNel3KNAe9g6mk=";
	};
}
