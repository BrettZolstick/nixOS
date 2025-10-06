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
			wireplumber.extraConfig."51-alsa-profiles" = {
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
		
	};
}
