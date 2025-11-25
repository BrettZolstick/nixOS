{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		fish.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.fish.enable {
		# Actual content of the module goes here:
		programs.fish = {
			enable = true;

			plugins = [
				{
					name = "tide";
					src = pkgs.fishPlugins.tide;
				}
			];

			interactiveShellInit = ''
				set -U fish_greeting ""
			'';

			functions = {
				copypartyJournal = "sudo journalctl -u copyparty.service --since=@$(stat -c %Y /run/current-system) -f";
				ethanServerSSH = "ssh ethan@192.168.68.67";
				rbs = "sudo nixos-rebuild switch --flake ~/nixOS#$hostname --impure --show-trace";
			};
		};
	};	
}
