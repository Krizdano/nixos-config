{lib, cfg}: {
  DontCheckDefaultBrowser = true;
  DisableFirefoxAccounts = true;
  DisablePocket = true;
  DisableTelemetry = true;
  DisplayBookmarksToolbar = "never";
  HttpsOnlyMode = "force_enabled";
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
  };

  FirefoxHome = {
    Search = lib.mkIf (cfg.hardened) false;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    SponsoredPocket = false;
    Snippets = false;
    Locked = true;
  };

  FirefoxSuggest = {
    WebSuggestions = false;
    SponsoredSuggestions = false;
    ImproveSuggest = false;
    Locked = true;
  };

  UserMessaging = {
    WhatsNew = false;
    ExtensionRecommendations = false;
    FeatureRecommendations = false;
    UrlbarInterventions = false;
    SkipOnboarding = true;
    MoreFromMozilla = false;
  };

  Cookies = {
    Behaviour = "reject-tracker-and-partition-foreign";
  };

  # clear all data on exit
  SanitizeOnShutdown = lib.mkIf (cfg.hardened) {
    Cache = true;
    Cookies = true;
    History = true;
    Sessions = true;
    SiteSettings = true;
    FormData = true;
    Downloads = true;
    OfflineApps = true;
    Locked = true;
  };

  NoDefaultBookmarks = true;
  OfferToSaveLogins = false;
  SearchSuggestEnabled = false;
  StartDownloadsInTempDirectory = true;
  HardwareAcceleration = true;
  OverrideFirstRunPage = "";
  OverridePostUpdatePage = "";
  NetworkPrediction = false; #Disable DNS prefetching
  PasswordManagerEnabled = false;
  PromptForDownloadLocation = true;

  Homepage = lib.mkIf (cfg.hardened) {
    URL = "https://Krizdano.github.io/browser-home-page/";
    StartPage = "homepage";
    Locked = true;
  };

  Containers = {
    Default = [
      { name = "personal";
        icon = "chill";
        color = "blue";
      }

      { name = "private";
        icon = "fingerprint";
        color = "red";
      }

      { name = "research";
        icon = "briefcase";
        color = "pink";
      }

    ];
  };

  "3rdparty" = {
    Extensions = {
      "uBlock0@raymondhill.net".adminSettings = lib.mkIf (cfg.hardened) (builtins.readFile ./extension-settings/my-ublock-settings.txt);
      "treestyletab@piro.sakura.ne.jp" = builtins.readFile ./extension-settings/treestyle-tab-config.json;
      "vimium-c@gdh1995.cn" = builtins.readFile ./extension-settings/vimium-c-settings.json;
    };
  };

  ExtensionSettings = {
    # vimium c
    "vimium-c@gdh1995.cn" = lib.mkIf (cfg.enableVimSupport) {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
    };

    # darkreader
    "addon@darkreader.org" = lib.mkIf (cfg.enableDarkMode) {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
    };

    # ublock origin
    "uBlock0@raymondhill.net" = lib.mkIf (cfg.enableAdBlock) {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    };

    # multi-account-containers
    "@testpilot-containers" = lib.mkIf (cfg.enableContainers) {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
    };

    # bitwarden
    "446900e4-71c2-419f-a6a7-df9c091e268b" = lib.mkIf (cfg.enableBitWarden) {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
    };

    # imagus (image enlarger)
    "{00000f2a-7cde-4f20-83ed-434fcb420d71}" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/imagus/latest.xpi";
    };

    # keepassxc
    "keepassxc-browser@keepassxc.org" = lib.mkIf (cfg.enableKeepass) {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
    };
  };

  Preferences = lib.mkIf (cfg.hardened) (import ./preferences.nix);
}
