{ config, pkgs, lib, ... }: {

	# This is wrapped in an option so that it can be easily toggled elsewhere.
	options = {
		freecad.enable = lib.mkOption {
			default = false;	
		};
	};
	
	config = lib.mkIf config.freecad.enable {
		# Actual content of the module goes here:
		home.packages = with pkgs; [ freecad ];	

		xdg.desktopEntries."org.freecad.FreeCAD" = {
					name = "FreeCAD";
					exec = "env QT_QPA_PLATFORM=xcb FreeCAD - --single-instance %F";
					icon = "org.freecad.FreeCAD";
					comment = "Feature based Parametric Modeler";
					terminal = false;
					mimeType = [
						"application/x-extension-fcstd"
						"model/obj"
						"image/vnd.dwg"
						"image/vnd.dxf"
						"model/vnd.collada+xml"
						"application/iges"
						"model/iges"
						"model/step"
						"model/step+zip"
						"model/stl"
						"application/vnd.shp"
						"model/vrml"
					];
					categories = [ 
						"Graphics"
						"Science"
						"Education"
						"Engineering"
						"X-CNC"
					 ];
					startupNotify = true;
				};	
	};	
}
