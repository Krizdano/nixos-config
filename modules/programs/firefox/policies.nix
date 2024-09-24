{
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
    Search = false;
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
  SanitizeOnShutdown = {
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

  Homepage = {
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
      "uBlock0@raymondhill.net".adminSettings = builtins.readFile ./extension-settings/my-ublock-settings.txt;
      "treestyletab@piro.sakura.ne.jp" = builtins.readFile ./extension-settings/treestyle-tab-config.json;
      "vimium-c@gdh1995.cn" = builtins.readFile ./extension-settings/vimium-c-settings.json;
    };
  };

  ExtensionSettings = {
    # vimium c
    "vimium-c@gdh1995.cn" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
    };

    # darkreader
    "addon@darkreader.org" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
    };

    # tree style tabs
    "treestyletab@piro.sakura.ne.jp" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi";
    };

    # ublock origin
    "uBlock0@raymondhill.net" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    };

    # imagus (image enlarger)
    "{00000f2a-7cde-4f20-83ed-434fcb420d71}" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/imagus/latest.xpi";
    };

    # keepassxc
    "keepassxc-browser@keepassxc.org" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
    };

    # multi-account-containers
    "@testpilot-containers" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
    };

  };

  Preferences = import ./preferences.nix;
}
