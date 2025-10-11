57361u{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		python.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.python.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ 

			python3.withPackages(pypkgs: with pypkgs; [
				beautifulsoup4
				EbookLib
				mutagen
				openai
				requests
				edge-tts
				pydub
				wyoming
				gradio
				docker
				sentencex
				gradio_log
			])

		];		
	};	
}
