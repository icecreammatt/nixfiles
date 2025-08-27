local wezterm = require 'wezterm'
local act = wezterm.action

local theme_config = require 'theme'
local background_color = theme_config.background_color
local foreground_color = theme_config.foreground_color
local theme = theme_config.theme
local opacity = 0.85

_G.ENABLE_EDITOR_CTRL_NAV = false



local config = {
  -- For gaming pc
  -- webgpu_preferred_adapter={
  --   backend="Vulkan",
  --   device=8726,
  --   device_type="DiscreteGpu",
  --   driver="NVIDIA",
  --   driver_info="545.29.06",
  --   name="NVIDIA GeForce RTX 3080",
  --   vendor=4318,
  -- },
  -- front_end = 'WebGpu',
  front_end = 'OpenGL',
  alternate_buffer_wheel_scroll_speed = 1;
  adjust_window_size_when_changing_font_size = false,
  font_size = 18.0,
  command_palette_font_size = 18.0,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",
  color_scheme = theme,
  scrollback_lines = 10000,
  enable_kitty_keyboard = true,
  check_for_updates_interval_seconds = 1209600,
  use_fancy_tab_bar = false,
  -- font = wezterm.font_with_fallback {
  -- { family = 'CaskaydiaCove Nerd Font Mono', weight = 'Regular' },
  -- { family = 'JetBrains Mono', harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, },
  -- 'Noto Color Emoji',
  -- },

  -- Allow swapping bwteeen panes in whatever editor is open
  -- This will currently trap nav to that editor till a way
  -- to escape without using ALT NEIO/HJKL is figured out
  wezterm.on('triggerWindowNavE', function(window, pane)
    if _G.ENABLE_EDITOR_CTRL_NAV then
        window:perform_action( act.SendKey({key = 'e', mods = 'CTRL'}), pane )
      else
        window:perform_action( act.ActivatePaneDirection 'Down', pane )
    end
  end);
  wezterm.on('triggerWindowNavN', function(window, pane)
    if _G.ENABLE_EDITOR_CTRL_NAV then
        window:perform_action( act.SendKey({key = 'n', mods = 'CTRL'}), pane )
      else
        window:perform_action( act.ActivatePaneDirection 'Left', pane )
    end
  end);
  wezterm.on('triggerWindowNavI', function(window, pane)
    -- if _G.ENABLE_EDITOR_CTRL_NAV then
      window:perform_action( act.SendKey({key = 'i', mods = 'CTRL'}), pane )
    --   else
      -- window:perform_action( act.ActivatePaneDirection 'Right', pane )
    -- end
  end);
  wezterm.on('triggerAltI', function(window, pane)
      window:perform_action( act.SendKey({key = 'i', mods = 'ALT'}), pane )
  end);
  wezterm.on('triggerWindowNavU', function(window, pane)
    if _G.ENABLE_EDITOR_CTRL_NAV then
        window:perform_action( act.SendKey({key = 'u', mods = 'CTRL'}), pane )
      else
        window:perform_action( act.ActivatePaneDirection 'Up', pane )
    end
  end);
  wezterm.on('update-right-status', function(_, pane)
    local title = pane:get_title()
    if string.find(title, "EDITOR") or string.find(title, "hx") then
      _G.ENABLE_EDITOR_CTRL_NAV = true
    else
      _G.ENABLE_EDITOR_CTRL_NAV = false
    end
  end);

  wezterm.on('toggle-opacity', function(window, _)
    local overrides = window:get_config_overrides() or {}

    if not overrides.window_background_opacity then
      overrides.window_background_opacity = opacity
      overrides.text_background_opacity = opacity
    else
      overrides.window_background_opacity = nil
      overrides.text_background_opacity = nil
    end

    window:set_config_overrides(overrides)
  end);

  ssh_domains = {
    {
      name = "mini",
      remote_address = "192.168.88.164",
      username = "matt",
    }
  },

  -- https://wezfurlong.org/wezterm/config/appearance.html#retro-tab-bar-appearance
  colors = {
    tab_bar = {
      -- The color of the strip that goes along the top of the window
      -- (does not apply when fancy tab bar is in use)
      background = background_color,

      -- The active tab is the one that has focus in the window
      active_tab = {
        -- The color of the background area for the tab
        bg_color = background_color,
        -- The color of the text for the tab
        fg_color = foreground_color,

        -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
        -- label shown for this tab.
        -- The default is "Normal"
        intensity = 'Normal',

        -- Specify whether you want "None", "Single" or "Double" underline for
        -- label shown for this tab.
        -- The default is "None"
        underline = 'None',

        -- Specify whether you want the text to be italic (true) or not (false)
        -- for this tab.  The default is false.
        italic = false,

        -- Specify whether you want the text to be rendered with strikethrough (true)
        -- or not for this tab.  The default is false.
        strikethrough = false,
      },

      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        bg_color = background_color,
        fg_color = '#4C566A',

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        bg_color = background_color,
        fg_color = '#4C566A',
        italic = true,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab_hover`.
      },

      -- The new tab button that let you create new tabs
      new_tab = {
        bg_color = background_color,
        fg_color = background_color,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over the new tab button
      new_tab_hover = {
        bg_color = background_color,
        fg_color = '#4C566A',
        italic = true,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab_hover`.
      },
    },
  },

  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key = ',', mods = 'CTRL', timeout_milliseconds = 1000 },

  keys = {
    { key='c', mods='CTRL|ALT',
    			action = wezterm.action_callback(function(win, pane)
  				local lines = pane:get_lines_as_text(1000000) -- same as `scrollback_lines`
  				win:copy_to_clipboard(lines, 'Clipboard')
          end),
        },
    { key="l", mods="LEADER", action=wezterm.action{QuickSelectArgs={
            patterns={
              "http?://\\S+",
              "https?://\\S+",
              "localhost:[0-9]+",
              "localhost",
            },
            action = wezterm.action_callback(function(window, pane)
               local url = window:get_selection_text_for_pane(pane)
               local pattern = "local"
               if url:find(pattern) then
                  if string.find(url, "http") == false then
                    url = string.format("http://%s", url)
                  end
               end
              wezterm.open_with(url)
            end)
          } }
    },

      -- Detaches the domain associated with the current pane
    { key = 'd', mods = 'SUPER', action = act.DetachDomain 'CurrentPaneDomain', },
    { key = 'n', mods = 'LEADER', action = act.PaneSelect {  alphabet = 'arstneio' } },
    { key = 'B', mods = 'ALT', action = wezterm.action.EmitEvent 'toggle-opacity', },
    { key = 'Delete', mods = 'NONE', action = wezterm.action.SendKey({key = 'Delete', mods = 'NONE'}), },
    { key = 'l', mods = 'SUPER', action = wezterm.action.EmitEvent 'toggle-opacity', },
    { key = 's', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = 'v', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = "Space", mods = "LEADER", action = wezterm.action.ShowLauncher },
    { key = 's', mods = 'SHIFT|SUPER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = 'v', mods = 'SHIFT|SUPER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = '{', mods = 'SHIFT|ALT', action = act.MoveTabRelative(-1) },
    { key = '}', mods = 'SHIFT|ALT', action = act.MoveTabRelative(1) },
    { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
    { key = '!', mods = 'CTRL', action = act.ActivateTab(0) },
    { key = '!', mods = 'SHIFT|CTRL', action = act.ActivateTab(0) },
    { key = '"', mods = 'ALT|CTRL', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    { key = '"', mods = 'SHIFT|ALT|CTRL', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    { key = '#', mods = 'CTRL', action = act.ActivateTab(2) },
    { key = '#', mods = 'SHIFT|CTRL', action = act.ActivateTab(2) },
    { key = '$', mods = 'CTRL', action = act.ActivateTab(3) },
    { key = '$', mods = 'SHIFT|CTRL', action = act.ActivateTab(3) },
    { key = '%', mods = 'CTRL', action = act.ActivateTab(4) },
    { key = '%', mods = 'SHIFT|CTRL', action = act.ActivateTab(4) },
    { key = '%', mods = 'ALT|CTRL', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    { key = '%', mods = 'SHIFT|ALT|CTRL', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    { key = '&', mods = 'CTRL', action = act.ActivateTab(6) },
    { key = '&', mods = 'SHIFT|CTRL', action = act.ActivateTab(6) },
    { key = "'", mods = 'SHIFT|ALT|CTRL', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    { key = '(', mods = 'CTRL', action = act.ActivateTab(-1) },
    { key = '(', mods = 'SHIFT|CTRL', action = act.ActivateTab(-1) },
    { key = ')', mods = 'CTRL', action = act.ResetFontSize },
    { key = ')', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
    { key = '*', mods = 'CTRL', action = act.ActivateTab(7) },
    { key = '*', mods = 'SHIFT|CTRL', action = act.ActivateTab(7) },
    { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '+', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
    { key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize },
    { key = '0', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
    { key = '0', mods = 'SUPER', action = act.ResetFontSize },
    { key = '1', mods = 'SHIFT|CTRL', action = act.ActivateTab(0) },
    { key = '1', mods = 'SUPER', action = act.ActivateTab(0) },
    { key = '2', mods = 'SHIFT|CTRL', action = act.ActivateTab(1) },
    { key = '2', mods = 'SUPER', action = act.ActivateTab(1) },
    { key = '3', mods = 'SHIFT|CTRL', action = act.ActivateTab(2) },
    { key = '3', mods = 'SUPER', action = act.ActivateTab(2) },
    { key = '4', mods = 'SHIFT|CTRL', action = act.ActivateTab(3) },
    { key = '4', mods = 'SUPER', action = act.ActivateTab(3) },
    { key = '5', mods = 'SHIFT|CTRL', action = act.ActivateTab(4) },
    { key = '5', mods = 'SHIFT|ALT|CTRL', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    { key = '5', mods = 'SUPER', action = act.ActivateTab(4) },
    { key = '6', mods = 'SHIFT|CTRL', action = act.ActivateTab(5) },
    { key = '6', mods = 'SUPER', action = act.ActivateTab(5) },
    { key = '7', mods = 'SHIFT|CTRL', action = act.ActivateTab(6) },
    { key = '7', mods = 'SUPER', action = act.ActivateTab(6) },
    { key = '8', mods = 'SHIFT|CTRL', action = act.ActivateTab(7) },
    { key = '8', mods = 'SUPER', action = act.ActivateTab(7) },
    { key = '9', mods = 'SHIFT|CTRL', action = act.ActivateTab(-1) },
    { key = '9', mods = 'SUPER', action = act.ActivateTab(-1) },
    { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '=', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = '@', mods = 'CTRL', action = act.ActivateTab(1) },
    { key = '@', mods = 'SHIFT|CTRL', action = act.ActivateTab(1) },
    { key = 'C', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'F', mods = 'CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'F', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'H', mods = 'CTRL', action = act.HideApplication },
    { key = 'H', mods = 'SHIFT|CTRL', action = act.HideApplication },
    { key = 'K', mods = 'CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
    { key = 'K', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' },

    -- { key = 'L', mods = 'CTRL', action = act.ShowDebugOverlay },
    -- { key = 'L', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },

    { key = 'M', mods = 'CTRL', action = act.Hide },
    { key = 'M', mods = 'SHIFT|CTRL', action = act.Hide },
    { key = 'N', mods = 'SUPER', action = act.SpawnWindow },
    -- { key = 'N', mods = 'SHIFT|SUPER', action = act.SpawnWindow },
    -- { key = 'N', mods = 'CTRL', action = act.SpawnWindow },
    -- { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    { key = 'P', mods = 'CTRL', action = act.ActivateCommandPalette },
    { key = 'P', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
    { key = 'Q', mods = 'CTRL', action = act.QuitApplication },
    { key = 'Q', mods = 'SHIFT|CTRL', action = act.QuitApplication },
    { key = 'R', mods = 'CTRL', action = act.ReloadConfiguration },
    { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
    { key = 'T', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'T', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },

 --   { key = 'U', mods = 'CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },

    -- { key = 'U', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    -- { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'W', mods = 'CTRL', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'W', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'X', mods = 'CTRL', action = act.ActivateCopyMode },
    { key = 'X', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
    { key = 'Z', mods = 'CTRL', action = act.TogglePaneZoomState },
    { key = 'Z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
    { key = 'F12', mods = 'NONE', action = act.TogglePaneZoomState },
    { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
    { key = 'f', mods = 'LEADER', action = act.TogglePaneZoomState },
    { key = 'f', mods = 'SHIFT|SUPER', action = act.TogglePaneZoomState },
    { key = 'x', mods = 'LEADER', action = act.TogglePaneZoomState },
    { key = '[', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(-1) },
    { key = ']', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(1) },
    { key = '^', mods = 'CTRL', action = act.ActivateTab(5) },
    { key = '^', mods = 'SHIFT|CTRL', action = act.ActivateTab(5) },
    { key = '_', mods = 'CTRL', action = act.DecreaseFontSize },
    { key = '_', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
    { key = 'f', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'f', mods = 'SUPER', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'h', mods = 'SHIFT|CTRL', action = act.HideApplication },
    { key = 'h', mods = 'SUPER', action = act.HideApplication },
    { key = 'k', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
    { key = 'k', mods = 'SUPER', action = act.ClearScrollback 'ScrollbackOnly' },

    -- { key = 'l', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },

    { key = 'm', mods = 'SHIFT|CTRL', action = act.Hide },
    { key = 'm', mods = 'SUPER', action = act.Hide },
    -- { key = 'n', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
    { key = 'q', mods = 'SHIFT|CTRL', action = act.QuitApplication },
    { key = 'q', mods = 'SUPER', action = act.QuitApplication },
    { key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
    { key = 'r', mods = 'SUPER', action = act.ReloadConfiguration },
    { key = 't', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 't', mods = 'SUPER', action = act.SpawnTab 'CurrentPaneDomain' },
    -- { key = 'u', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
    { key = 'w', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'w', mods = 'SUPER', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'x', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
    { key = 'z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
    { key = '{', mods = 'SUPER', action = act.ActivateTabRelative(-1) },
    { key = '{', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(-1) },
    { key = '}', mods = 'SUPER', action = act.ActivateTabRelative(1) },
    { key = '}', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(1) },
    { key = 'c', mods = 'LEADER', action = act.QuickSelect },
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'U', mods = 'SHIFT|CTRL', action = act.ScrollByPage(-1) },
    { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'PageUp', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
    { key = 'E', mods = 'SHIFT|CTRL', action = act.ScrollByPage(1) },
    { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'PageDown', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
    { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
    { key = 'LeftArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
    { key = 'RightArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
    { key = 'UpArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },
    { key = 'DownArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Down', 1 } },

    { key = 'LeftArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'RightArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'UpArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'DownArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Down', 1 } },

    { key = 'LeftArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'RightArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'UpArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'DownArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Down', 1 } },
    { key = 'n', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'i', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'u', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'e', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Down', 1 } },

    { key = 'n', mods = 'SUPER|ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'i', mods = 'SUPER|ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'u', mods = 'SUPER|ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'e', mods = 'SUPER|ALT', action = act.ActivatePaneDirection 'Down' },

    -- { key = 'n', mods = 'CTRL', action = act.EmitEvent 'triggerWindowNavN' },
    { key = 'i', mods = 'CTRL', action = act.EmitEvent 'triggerWindowNavI' },
    { key = 'i', mods = 'ALT', action = act.EmitEvent 'triggerAltI' },
    -- { key = 'u', mods = 'CTRL', action = act.EmitEvent 'triggerWindowNavU' },
    -- { key = 'e', mods = 'CTRL', action = act.EmitEvent 'triggerWindowNavE' },

    { key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
    { key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },
  },

  key_tables = {
    copy_mode = {
      { key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'Tab', mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'Space', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
      { key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = ',', mods = 'NONE', action = act.CopyMode 'JumpReverse' },
      { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = ';', mods = 'NONE', action = act.CopyMode 'JumpAgain' },
      { key = 'F', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
      { key = 'F', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
      { key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
      { key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
      -- { key = 'L', mods = 'NONE', action = act.CopyMode 'MoveToViewportBottom' },
      -- { key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'M', mods = 'NONE', action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'O', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'O', mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'T', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
      { key = 'T', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
      { key = 'V', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Line' } },
      { key = 'V', mods = 'SHIFT', action = act.CopyMode{ SetSelectionMode =  'Line' } },
      { key = 'x', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Line' } },
      { key = '^', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
      { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'd', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (0.5) } },
      { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },
      { key = 'f', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = false } } },
      { key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
      { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
      { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
      { key = 'g', mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'n', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'u', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'i', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'm', mods = 'ALT', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
      { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 't', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = true } } },
      { key = 'l', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (-0.5) } },
      { key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
      { key = 'v', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Block' } },
      { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'y', mods = 'NONE', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'LeftArrow', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'RightArrow', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
     },

      search_mode = {
        { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
        { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
        { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
        { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
        { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
        { key = 'l', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
        { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
        { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
        { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
        { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
      },
    },

    hyperlink_rules = {
      -- Linkify things that look like URLs and the host has a TLD name.
      -- Compiled-in default. Used if you don't specify any hyperlink_rules.
      {
        regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
        format = '$0',
      },

      -- linkify email addresses
      -- Compiled-in default. Used if you don't specify any hyperlink_rules.
      -- {
      --   regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
      --   format = 'mailto:$0',
      -- },

      -- file:// URI
      -- Compiled-in default. Used if you don't specify any hyperlink_rules.
      -- {
      --   regex = [[\bfile://\S*\b]],
      --   format = '$0',
      -- },

      -- Linkify things that look like URLs with numeric addresses as hosts.
      -- E.g. http://127.0.0.1:8000 for a local development server,
      -- or http://192.168.1.1 for the web interface of many routers.
      {
        regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
        format = '$0',
      },

      -- Make localhost links clickable
      -- Orders seems to matter here so check for localhost without
      -- http first since in the second scenario since wezterm wont
      -- open a url without a prefix
      {
        regex = [[(localhost)+(:?[0-9]{1,9})?]],
        format = 'http://$1$2',
      },
      {
        regex = [[(http+s?://)?(localhost)+(:?[0-9]{1,9})?]],
        format = '$1$2$3',
      },

      -- Make task numbers clickable
      -- The first matched regex group is captured in $1.
      -- {
      --   regex = [[\b[tT](\d+)\b]],
      --   format = 'https://example.com/tasks/?t=$1',
      -- },

      -- Make username/project paths clickable. This implies paths like the following are for GitHub.
      -- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
      -- As long as a full URL hyperlink regex exists above this it should not match a full URL to
      -- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
      -- {
      --   regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
      --   format = 'https://www.github.com/$1/$3',
      -- },
    },

}

for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
  if gpu.backend == 'Vulkan' and gpu.device_type == 'IntegratedGpu' then
    config.webgpu_preferred_adapter = gpu
    -- config.front_end = 'WebGpu'
    break
  end
end

return config
