{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		pipewire.enable = lib.mkOption {
			default = true;	
		};
	};
	
	config = lib.mkIf config.pipewire.enable {
		# Actual content of the module goes here:

		security.rtkit.enable = true;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
			wireplumber.enable = true;
			wireplumber.extraConfig = {
				"10-alsa-midi" = {
					"wireplumber.settings" = {"monitor.alsa-midi" = true; };
				};
				
				"51-alsa-profiles" = {
					"monitor.alsa.rules" = [
						# Force Clarett+ 2Pre to Pro Audio
						{
							matches = [ { "device.nick" = "Clarett+ 2Pre"; } ];
							actions = {
								update-props = { "device.profile" = "pro-audio"; };
							};
						}

						# Turn off Navi 31 HDMI/DP
						{
							matches = [ { "device.nick" = "Navi 31 HDMI/DP Audio"; } ];
							actions = {
								update-props = { "device.profile" = "off"; };
							};
						}
					];
				};
			};
			wireplumber.configPackages = [
				(pkgs.writeTextDir "share/wireplumber/main.lua.d/99-alsa-lowlatency.lua" ''
					alsa_monitor.rules = {
						{
							matches = {{{ "node.name", "matches", "alsa_output.*" }}};
							apply_properties = {
								["audio.format"] = "S32LE",
								["audio.rate"] = "96000", -- for USB soundcards it should be twice your desired rate
								["api.alsa.period-size"] = 2, -- defaults to 1024, tweak by trial-and-error
								-- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
							},
						},
					}
				'')
			];


			extraConfig.pipewire."92-low-latency" = {
				"context.properties" = {
					"default.clock.rate" = 48000;
					"default.clock.quantum" = 128;
					"default.clock.min-quantum" = 128;
					"default.clock.max-quantum" = 128;
				};
			};	
		};
	};		
}
