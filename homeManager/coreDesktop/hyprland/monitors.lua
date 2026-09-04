
local host = require("host")

local hosts = {

  ethanDesktop = {
    monitors = {    
      {
        output = "DP-1",
        mode = "2560x1440@239.97",
        position = "1920x0",
        scale = "1",
        vrr = 2,
      },
      {
        output = "DP-2",
        mode = "1920x1080@60.0",
        position = "6400x0",
        scale = "1",
      },
      {
        output = "DP-3",
        mode = "1920x1080@60.0",
        position = "0x0",
        scale = "1",
      },
      {
        output = "HDMI-A-1",
        mode = "1920x1080@60.0",
        position = "4480x0",
        scale = "1",
      },
    },

    workspaces = {
      {
        workspace = "1",
        monitor = "DP-1",
        default = true,
      },
      {
        workspace = "2",
        monitor = "DP-3",
        default = true,
      },
      {
        workspace = "3",
        monitor = "HDMI-A-1",
        default = true,
      },
      {
        workspace = "4",
        monitor = "DP-2",
        default = true,
      },
    },
  },



  ethanLaptop = {
    monitors = {
      {
        output = "eDP-1",
        mode = "1920x1080@144",
        position = "0x0",
        scale = "1", 
      },
    },

    workspaces = {
      {        
        workspace = "1",
        monitor = "eDP-1",
        default = true,
      },
    },
  },
  


  ethanServer = {
    monitors = {
      {
        output = "DP-1",
        mode = "1920x1080@60",
        position = "0x0",
        scale = "1", 
      },
    },

    workspaces = {
      {
        workspace = "1",
        monitor = "DP-1",
        default = true,
      },
    },
  },
  


  cg = {
    monitors = {
      {
        output = "HDMI-A-1",
        mode = "1920x1080@75.0",
        position = "0x0",
        scale = "1", 
      },
    },
    
    workspaces = {
      {
        workspace = "1",
        monitor = "HDMI-A-1",
        default = true,
      },
    },
  },

  


  plexus = {
    monitors = {
      {
        output = "eDP-1",
        mode = "1920x1080@60",
        position = "0x0",
        scale = "1", 
      },
    
      {
        output = "DP-3",
        mode = "1920x1080@60",
        position = "1920x0",
        scale = "1", 
      },
    
      {
        output = "HDMI-A-1",
        mode = "1920x1080@60",
        position = "3840x0",
        scale = "1", 
      },
    
      {
        output = "DP-2",
        mode = "1920x1080@60",
        position = "5760x0",
        scale = "1", 
      },
    },

    workspaces = {
      {
        workspace = "3",
        monitor = "eDP-1",
        default = true,
      },
      {
        workspace = "2",
        monitor = "DP-3",
        default = true,
      },
      {
        workspace = "1",
        monitor = "HDMI-A-1",
        default = true,
      },
      {
        workspace = "4",
        monitor = "DP-2",
        default = true,
      },
    },
  },
}

local currentHost = hosts[host]

for _, monitor in ipairs(currentHost.monitors) do
  hl.monitor(monitor)
end

for _, workspace in ipairs(currentHost.workspaces) do
  hl.workspace_rule(workspace)
end

