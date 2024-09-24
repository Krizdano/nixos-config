_: {
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij/config.kdl".text = ''
// If you'd like to override the default keybindings completely, be sure to change "keybinds" to "keybinds clear-defaults=true"
keybinds clear-defaults=true {
    normal {
        // uncomment this and adjust key if using copy_on_select=false
        // bind "Alt c" { Copy; }
    }
    locked {
        bind "Alt g" { SwitchToMode "Normal"; }
    }
    resize {
        bind "Alt p" { SwitchToMode "Normal"; }
        bind "m" "Left" { Resize "Increase Left"; }
        bind "n" "Down" { Resize "Increase Down"; }
        bind "e" "Up" { Resize "Increase Up"; }
        bind "i" "Right" { Resize "Increase Right"; }
        bind "M" { Resize "Decrease Left"; }
        bind "N" { Resize "Decrease Down"; }
        bind "E" { Resize "Decrease Up"; }
        bind "I" { Resize "Decrease Right"; }
        bind "=" "+" { Resize "Increase"; }
        bind "-" { Resize "Decrease"; }
    }
    pane {
        bind "Alt ;" { SwitchToMode "Normal"; }
        bind "m" "Left" { MoveFocus "Left"; }
        bind "i" "Right" { MoveFocus "Right"; }
        bind "n" "Down" { MoveFocus "Down"; }
        bind "e" "Up" { MoveFocus "Up"; }
        bind ";" { SwitchFocus; }
        bind "k" { NewPane "Right"; SwitchToMode "Normal"; }
        bind "s" { NewPane "Down"; SwitchToMode "Normal"; }
        bind "q" { CloseFocus; SwitchToMode "Normal"; }
        bind "t" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
        bind "x" { TogglePaneFrames; SwitchToMode "Normal"; }
        bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
        bind "f" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
        bind "p" { SwitchToMode "RenamePane"; PaneNameInput 0;}
    }
    move {
        bind "Alt h" { SwitchToMode "Normal"; }
        bind "k" "Tab" { MovePane; }
        bind ";" { MovePaneBackwards; }
        bind "m" "Left" { MovePane "Left"; }
        bind "n" "Down" { MovePane "Down"; }
        bind "e" "Up" { MovePane "Up"; }
        bind "i" "Right" { MovePane "Right"; }
    }
    tab {
        bind "Alt b" { SwitchToMode "Normal"; }
        bind "p" { SwitchToMode "RenameTab"; TabNameInput 0; }
        bind "m" "Left" "Up" "k" { GoToPreviousTab; }
        bind "i" "Right" "Down" "j" { GoToNextTab; }
        bind "k" { NewTab; SwitchToMode "Normal"; }
        bind "q" { CloseTab; SwitchToMode "Normal"; }
        bind "r" { ToggleActiveSyncTab; SwitchToMode "Normal"; }
        bind "z" { BreakPane; SwitchToMode "Normal"; }
        bind "]" { BreakPaneRight; SwitchToMode "Normal"; }
        bind "[" { BreakPaneLeft; SwitchToMode "Normal"; }
        bind "1" { GoToTab 1; SwitchToMode "Normal"; }
        bind "2" { GoToTab 2; SwitchToMode "Normal"; }
        bind "3" { GoToTab 3; SwitchToMode "Normal"; }
        bind "4" { GoToTab 4; SwitchToMode "Normal"; }
        bind "5" { GoToTab 5; SwitchToMode "Normal"; }
        bind "6" { GoToTab 6; SwitchToMode "Normal"; }
        bind "7" { GoToTab 7; SwitchToMode "Normal"; }
        bind "8" { GoToTab 8; SwitchToMode "Normal"; }
        bind "9" { GoToTab 9; SwitchToMode "Normal"; }
        bind "Tab" { ToggleTab; }
              }
    scroll {
        bind "Alt s" { SwitchToMode "Normal"; }
        bind "f" { EditScrollback; SwitchToMode "Normal"; }
        bind "r" { SwitchToMode "EnterSearch"; SearchInput 0; }
        bind "Ctrl d" { ScrollToBottom; SwitchToMode "Normal"; }
        bind "n" "Down" { ScrollDown; }
        bind "e" "Up" { ScrollUp; }
        bind "Ctrl t" "PageDown" "Right" "l" { PageScrollDown; }
        bind "Ctrl z" "PageUp" "Left" "h" { PageScrollUp; }
        bind "s" { HalfPageScrollDown; }
        bind "l" { HalfPageScrollUp; }
        // uncomment this and adjust key if using copy_on_select=false
        // bind "Alt c" { Copy; }
    }
    search {
        bind "Alt r" { SwitchToMode "Normal"; }
        bind "Ctrl d" { ScrollToBottom; SwitchToMode "Normal"; }
        bind "n" "Down" { ScrollDown; }
        bind "e" "Up" { ScrollUp; }
        bind "Ctrl t" "PageDown" "Right" "l" { PageScrollDown; }
        bind "Ctrl z" "PageUp" "Left" "h" { PageScrollUp; }
        bind "s" { HalfPageScrollDown; }
        bind "l" { HalfPageScrollUp; }
        bind "k" { Search "down"; }
        bind ";" { Search "up"; }
        bind "d" { SearchToggleOption "CaseSensitivity"; }
        bind "w" { SearchToggleOption "Wrap"; }
        bind "y" { SearchToggleOption "WholeWord"; }
    }
    entersearch {
        bind "Ctrl d" "Esc" { SwitchToMode "Scroll"; }
        bind "Enter" { SwitchToMode "Search"; }
    }
    renametab {
        bind "Ctrl d" { SwitchToMode "Normal"; }
        bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
    }
    renamepane {
        bind "Ctrl d" { SwitchToMode "Normal"; }
        bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
    }
    session {
        bind "Alt y" { SwitchToMode "Normal"; }
        bind "Ctrl r" { SwitchToMode "Scroll"; }
        bind "s" { Detach; }
        bind "w" {
            LaunchOrFocusPlugin "session-manager" {
                floating true
                move_to_focused_tab true
            };
            SwitchToMode "Normal"
        }
    }
    tmux {
        bind "[" { SwitchToMode "Scroll"; }
        bind "Ctrl b" { Write 2; SwitchToMode "Normal"; }
        bind "\"" { NewPane "Down"; SwitchToMode "Normal"; }
        bind "%" { NewPane "Right"; SwitchToMode "Normal"; }
        bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
        bind "c" { NewTab; SwitchToMode "Normal"; }
        bind "," { SwitchToMode "RenameTab"; }
        bind "p" { GoToPreviousTab; SwitchToMode "Normal"; }
        bind "n" { GoToNextTab; SwitchToMode "Normal"; }
        bind "Left" { MoveFocus "Left"; SwitchToMode "Normal"; }
        bind "Right" { MoveFocus "Right"; SwitchToMode "Normal"; }
        bind "Down" { MoveFocus "Down"; SwitchToMode "Normal"; }
        bind "Up" { MoveFocus "Up"; SwitchToMode "Normal"; }
        bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
        bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
        bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
        bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
        bind "o" { FocusNextPane; }
        bind "d" { Detach; }
        bind "Space" { NextSwapLayout; }
        bind "q" { CloseFocus; SwitchToMode "Normal"; }
              }
    shared_except "locked" {
        bind "Ctrl g" { SwitchToMode "Locked"; }
        bind "Ctrl q" { Quit; }
        bind "Alt k" { NewPane "Right"; }
        bind "Alt s" { NewPane "Down"; }
        bind "Alt u" { MoveTab "Left"; }
        bind "Alt y" { MoveTab "Right"; }
        bind "Alt m" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt i" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt n" "Alt Down" { MoveFocus "Down"; }
        bind "Alt e" "Alt Up" { MoveFocus "Up"; }
        bind "Alt q" { CloseFocus; }
        bind "Alt =" "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
        bind "Alt [" { PreviousSwapLayout; }
        bind "Alt ]" { NextSwapLayout; }
    }
    shared_except "normal" "locked" {
        bind "Enter" "Esc" { SwitchToMode "Normal"; }
    }
    shared_except "pane" "locked" {
        bind "Alt ;" { SwitchToMode "Pane"; }
    }
    shared_except "resize" "locked" {
        bind "Alt p" { SwitchToMode "Resize"; }
    }
    shared_except "scroll" "locked" {
        bind "Alt r" { SwitchToMode "Scroll"; }
    }
    shared_except "session" "locked" {
        bind "Alt y" { SwitchToMode "Session"; }
    }
    shared_except "tab" "locked" {
        bind "Alt b" { SwitchToMode "Tab"; }
    }
    shared_except "move" "locked" {
        bind "Alt h" { SwitchToMode "Move"; }
    }
    shared_except "tmux" "locked" {
        bind "Ctrl b" { SwitchToMode "Tmux"; }
    }
    }

plugins {
    tab-bar location="zellij:tab-bar"
    status-bar location="zellij:status-bar"
    strider location="zellij:strider"
    compact-bar location="zellij:compact-bar"
    session-manager location="zellij:session-manager"
    welcome-screen location="zellij:session-manager" {
        welcome_screen true
                                     }
    filepicker location="zellij:strider" {
        cwd "/"
                                    }
}

// Choose what to do when zellij receives SIGTERM, SIGINT, SIGQUIT or SIGHUP
// eg. when terminal window with an active zellij session is closed
// Options:
//   - detach (Default)
//   - quit
//
// on_force_close "quit"

//  Send a request for a simplified ui (without arrow fonts) to plugins
//  Options:
//    - true
//    - false (Default)
//
// simplified_ui true

// Choose the path to the default shell that zellij will use for opening new panes
// Default: $SHELL
//
// default_shell "fish"

// Choose the path to override cwd that zellij will use for opening new panes
//
// default_cwd ""

// Toggle between having pane frames around the panes
// Options:
//   - true (default)
//   - false
//
// pane_frames true

// Toggle between having Zellij lay out panes according to a predefined set of layouts whenever possible
// Options:
//   - true (default)
//   - false
//
// auto_layout true

// Whether sessions should be serialized to the cache folder (including their tabs/panes, cwds and running commands) so that they can later be resurrected
// Options:
//   - true (default)
//   - false
//
// session_serialization false

// Whether pane viewports are serialized along with the session, default is false
// Options:
//   - true
//   - false (default)
// serialize_pane_viewport true

// Scrollback lines to serialize along with the pane viewport when serializing sessions, 0
// defaults to the scrollback size. If this number is higher than the scrollback size, it will
// also default to the scrollback size. This does nothing if `serialize_pane_viewport` is not true.
//
// scrollback_lines_to_serialize 10000

// Define color themes for Zellij
// For more examples, see: https://github.com/zellij-org/zellij/tree/main/example/themes
// Once these themes are defined, one of them should to be selected in the "theme" section of this file
//
 themes {
default {
    bg "#585b70" // Surface2
    fg "#cdd6f4"
    red "#f38ba8"
    green "#a6e3a1"
    blue "#89b4fa"
    yellow "#f9e2af"
    magenta "#f5c2e7" // Pink
    orange "#fab387" // Peach
    cyan "#89dceb" // Sky
    black "#181825" // Mantle
    white "#cdd6f4"
}
 }

// Choose the theme that is specified in the themes section.
// Default: default
//
// theme "default"

// The name of the default layout to load on startup
// Default: "default"
//
// default_layout "compact"

// Choose the mode that zellij uses when starting up.
// Default: normal
//
// default_mode "locked"

// Toggle enabling the mouse mode.
// On certain configurations, or terminals this could
// potentially interfere with copying text.
// Options:
//   - true (default)
//   - false
//
// mouse_mode false

// Configure the scroll back buffer size
// This is the number of lines zellij stores for each pane in the scroll back
// buffer. Excess number of lines are discarded in a FIFO fashion.
// Valid values: positive integers
// Default value: 10000
//
// scroll_buffer_size 10000

// Provide a command to execute when copying text. The text will be piped to
// the stdin of the program to perform the copy. This can be used with
// terminal emulators which do not support the OSC 52 ANSI control sequence
// that will be used by default if this option is not set.
// Examples:
//
// copy_command "xclip -selection clipboard" // x11
   copy_command "wl-copy"                    // wayland
// copy_command "pbcopy"                     // osx

// Choose the destination for copied text
// Allows using the primary selection buffer (on x11/wayland) instead of the system clipboard.
// Does not apply when using copy_command.
// Options:
//   - system (default)
//   - primary
//
// copy_clipboard "primary"

// Enable or disable automatic copy (and clear) of selection when releasing mouse
// Default: true
//
// copy_on_select false

// Path to the default editor to use to edit pane scrollbuffer
// Default: $EDITOR or $VISUAL
//
// scrollback_editor "/usr/bin/vim"

// When attaching to an existing session with other users,
// should the session be mirrored (true)
// or should each user have their own cursor (false)
// Default: false
//
// mirror_session true

// The folder in which Zellij will look for layouts
//
// layout_dir "/path/to/my/layout_dir"

// The folder in which Zellij will look for themes
//
// theme_dir "/path/to/my/theme_dir"

// Enable or disable the rendering of styled and colored underlines (undercurl).
// May need to be disabled for certain unsupported terminals
// Default: true
//
// styled_underlines false

// Enable or disable writing of session metadata to disk (if disabled, other sessions might not know
// metadata info on this session)
// Default: false
//
// disable_session_metadata true
  '';
}