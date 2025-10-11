{ config, pkgs, lib, ... }: 
let
	rdpScript = pkgs.writeShellScriptBin "rdp-ethan-server" ''
		#!/usr/bin/env bash

		# make this file, leave the server password in it, and chmod 600 it
		PW="$(cat $HOME/nixOS/homeManager/additionalApps/freerdp-servertron9000.pass)"

		exec ${pkgs.freerdp}/bin/xfreerdp \
		/v:192.168.68.63 \
		/u:'servertron9000' \
		/p:"$PW" \
		/cert:ignore \
		/f /rfx /clipboard
	'';
in
{

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		freerdp.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.freerdp.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ freerdp rdpScript ];	

		xdg.desktopEntries."Ethan-Server" = {
			name = "Ethan Server (RDP)";
			exec = "rdp-ethan-server";
			terminal = false;
		};
		
	};	
}
