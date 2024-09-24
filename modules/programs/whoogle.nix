_: {
  virtualisation = {
    oci-containers = {
      backend = "podman";
      containers.whoogle-search = {
        image = "benbusby/whoogle-search";
        autoStart = true;
        ports = [ "5000:5000" ];
        environment = {
          WHOOGLE_CONFIG_STYLE = ":root{--whoogle-logo:#c4a7e7;--whoogle-page-bg:#faf4ed;--whoogle-element-bg:#f2e9e1;--whoogle-text:#575279;--whoogle-contrast-text:#1f1d2e;--whoogle-secondary-text:#797593;--whoogle-result-bg:#faf4ed;--whoogle-result-title:#d7827e;--whoogle-result-url:#286983;--whoogle-result-visited:#907aa9;--whoogle-dark-logo:#c4a7e7;--whoogle-dark-page-bg:#191724;--whoogle-dark-element-bg:#1f1d2e;--whoogle-dark-text:#e0def4;--whoogle-dark-contrast-text:#e0def4;--whoogle-dark-secondary-text:#908caa;--whoogle-dark-result-bg:#393552;--whoogle-dark-result-title:#9ccfd8;--whoogle-dark-result-url:#3e8fb0;--whoogle-dark-result-visited:#c4a7e7}#whoogle-w{fill:#eb6f92}#whoogle-h{fill:#f6c177}#whoogle-o-1{fill:#ebbcba}#whoogle-o-2{fill:#31748f}#whoogle-g{fill:#9ccfd8}#whoogle-l{fill:#c4a7e7}#whoogle-e{fill:#908caa}";
          WHOOGLE_ALT_TW = "farside.link/nitter";
          WHOOGLE_ALT_YT = "www.youtube.com";
          WHOOGLE_ALT_IG = "farside.link/bibliogram/u";
          WHOOGLE_ALT_RD = "farside.link/libreddit";
          WHOOGLE_ALT_MD = "farside.link/scribe";
          WHOOGLE_ALT_TL = "farside.link/lingva";
          WHOOGLE_ALT_IMG = "farside.link/rimgo";
          WHOOGLE_ALT_WIKI = "farside.link/wikiless";
          WHOOGLE_ALT_IMDB = "farside.link/libremdb";
          WHOOGLE_ALT_QUORA = "farside.link/quetre";
          WHOOGLE_CONFIG_ALTS = "1";
          WHOOGLE_CONFIG_VIEW_IMAGE = "1";
          WHOOGLE_RESULTS_PER_PAGE = "20";
        };
      };
    };
  };
}
