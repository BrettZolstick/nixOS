hl.window_rule({
  name = "ignoreAllMaximizeRequests",
  match = { class = ".*", },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "noFirefoxTransparency",
  match = { class = "firefox", },
  opacity = "1.0 override 1.0 override",
})

hl.window_rule({
  name = "forcePrismLauncherTransparency",
  match = { class = "org.prismlauncher.PrismLauncher", },
  opacity = "0.93 override 0.91 override",
})

hl.window_rule({
  name = "forceFurnaceTransparency",
  match = { class = "org.tildearrow.furnace", },
  opacity = "0.93 override 0.91 override",
})

hl.window_rule({
  name = "disableVideosTransparency",
  match = { content = "video", },
  opacity = "1.0 override 1.0 override",
})

hl.window_rule({
  name = "disableDiscordTransparency",
  match = { class = "(vesktop|discord)", },
  opacity = "1.0 override 1.0 override",
})

hl.window_rule({
  name = "enableTearingOsu",
  match = { class = "osu!", },
  immediate = true,
})   

hl.window_rule({
  name = "enableTearingGlobal",
  match = { class = ".*", },
  immediate = true,
})

hl.window_rule({
  name = "wofi",
  match = { class = "wofi", },
  rounding = 10,
  rounding_power = 2,
  border_size = 4,
})

hl.window_rule({
  name = "workspaceTwoApps",
  match = { class = "(vesktop|discord|Todoist)", },
  workspace = "2",
})

hl.window_rule({
  name = "openSteamGamesInWorksapceOne",
  match = { class = "^(steam_app_[0-9]+)$", },
  workspace = "1",
  fullscreen = true,
})

hl.window_rule({
  name = "noFullscreenForRailWindows",
  match = { class = "^(RAIL:.*)$", },
  suppress_event = "fullscreen maximize fullscreenoutput",
})
