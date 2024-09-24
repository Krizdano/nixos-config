{
  # disable about:config warning
  "browser.aboutConfig.showWarning" = {
    Value = false;
    Status = "locked";
  };

  # clear default topsites
  "browser.newtabpage.activity-stream.default.sites" = {
    Value = "";
    Status = "locked";
  };

  # disable using the OS's geolocation service
  "geo.provider.use_geoclue" = { # only for linux (geo.provider.ms-windows-location (for windows) geo.provider.use_corelocation (for mac))
    Value = false;
    Status = "locked";
  };

  # disable recommendation pane in about:addons (uses Google Analytics)
  "extensions.getAddons.showPane" = {
    Value = false;
    Status = "locked";
  };

  # disable recommendations in about:addons' Extensions and Themes pane
  "extensions.htmlaboutaddons.recommendations.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable personalized Extension Recommendations in about:addons
  "browser.discovery.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable shopping experience
  # https://bugzilla.mozilla.org/show_bug.cgi?id=1840156#c0
  "browser.shopping.experience2023.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable telemetry
  "toolkit.telemetry.unified" = {
    Value = false;
    Status = "locked";
  };

  "toolkit.telemetry.enabled" = {
    Value = false;
    Status = "locked";
  };

  "toolkit.telemetry.server" = {
    Value = "data:,";
    Status = "locked";
  };

  "toolkit.telemetry.newProfilePing.enabled" = {
    Value = false;
    Status = "locked";
  };

  "toolkit.telemetry.shutdownPingSender.enabled" = {
    Value = false;
    Status = "locked";
  };

  "toolkit.telemetry.updatePing.enabled" = {
    Value = false;
    Status = "locked";
  };

  "toolkit.telemetry.bhrPing.enabled" = {
    Value = false;
    Status = "locked";
  };

  "toolkit.telemetry.firstShutdownPing.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable Telemetry Coverage
  "toolkit.telemetry.coverage.opt-out" = {
    Value = true;
    Status = "locked";
  };

  "toolkit.coverage.opt-out" = {
    Value = true;
    Status = "locked";
  };

  "toolkit.coverage.endpoint.base" = {
    Value = true;
    Status = "locked";
  };

  # disable Firefox Home (Activity Stream) telemetry
  "browser.newtabpage.activity-stream.feeds.telemetry" = {
    Value = false;
    Status = "locked";
  };

  "browser.newtabpage.activity-stream.telemetry" = {
    Value = false;
    Status = "locked";
  };

  # disable Studies
  "app.shield.optoutstudies.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable Normandy/Shield
  # Shield is a telemetry system that can push and test "recipes"
  "app.normandy.enabled" = {
    Value = false;
    Status = "locked";
  };

  "app.normandy.api_url" = {
    Value = "";
    Status = "locked";
  };

  # disable Crash Reports
  "breakpad.reportURL" = {
    Value = "";
    Status = "locked";
  };

  "browser.tabs.crashReporting.sendReport" = {
    Value = false;
    Status = "locked";
  };

  # enforce no submission of backlogged Crash Reports
  "browser.crashReports.unsubmittedCheck.autoSubmit2" = {
    Value = false;
    Status = "locked";
  };

  # disable Captive Portal detection
  "captivedetect.canonicalURL" = {
    Value = "";
    Status = "locked";
  };

  "network.captive-portal-service.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable Network Connectivity checks
  "network.connectivity-service.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable Safe Browsing checks for downloads
  "browser.safebrowsing.downloads.remote.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable link prefetching
  "network.prefetch-next" = {
    Value = false;
    Status = "locked";
  };

  # disable predictor / prefetching
  "network.predictor.enabled" = {
    Value = false;
    Status = "locked";
  };

  "network.predictor.enable-prefetch" = {
    Value = false;
    Status = "locked";
  };

  # disable link-mouseover opening connection to linked server
  "network.http.speculative-parallel-limit" = {
    Value = 0;
    Status = "locked";
  };

  # disable mousedown speculative connections on bookmarks and history
  "browser.places.speculativeConnect.enabled" = {
    Value = false;
    Status = "locked";
  };

  # set the proxy server to do any DNS lookups when using SOCKS
  "network.proxy.socks_remote_dns" = {
    Value = true;
    Status = "locked";
  };

  # disable using UNC (Uniform Naming Convention) paths
  "network.file.disable_unc_paths" = {
    Value = true;
    Status = "locked";
  };

  # disable GIO as a potential proxy bypass vector
  "network.gio.supported-protocols" = {
    Value = "";
    Status = "locked";
  };

  # disable location bar making speculative connections
  "browser.urlbar.speculativeConnect.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable urlbar trending search suggestions
  "browser.urlbar.trending.featureGate" = {
    Value = false;
    Status = "locked";
  };

  # disable urlbar suggestions
  "browser.urlbar.addons.featureGate" = {
    Value = false;
    Status = "locked";
  };

  "browser.urlbar.mdn.featureGate" = {
    Value = false;
    Status = "locked";
  };

  "browser.urlbar.pocket.featureGate" = {
    Value = false;
    Status = "locked";
  };

  "browser.urlbar.weather.featureGate" = {
    Value = false;
    Status = "locked";
  };

  "browser.urlbar.yelp.featureGate" = {
    Value = false;
    Status = "locked";
  };

  # disable search and form history
  "browser.formfill.enable" = {
    Value = false;
    Status = "locked";
  };

  # disable auto-filling username & password form fields
  "signon.autofillForms" = {
    Value = false;
    Status = "locked";
  };

  # disable formless login capture for Password Manager
  "signon.formlessCapture.enabled" = {
    Value = false;
    Status = "locked";
  };

  # limit (or disable) HTTP authentication credentials dialogs triggered by sub-resources
  "network.auth.subresource-http-auth-allow" = {
    Value = 1;
    Status = "locked";
  };

  # disable disk cache
  "browser.cache.disk.enable" = {
    Value = false;
    Status = "locked";
  };

  # disable media cache from writing to disk in Private Browsing
  "browser.privatebrowsing.forceMediaMemoryCache" = {
    Value = true;
    Status = "locked";
  };

  "media.memory_cache_max_size" = {
    Value = 65536;
    Status = "locked";
  };

  # disable storing extra session data
  "browser.sessionstore.privacy_level" = {
    Value = 2;
    Status = "locked";
  };

  # require safe negotiation
  "security.ssl.require_safe_negotiation" = {
    Value = true;
    Status = "locked";
  };

  # disable TLS1.3 0-RTT (round-trip time)
  "security.tls.enable_0rtt_data" = {
    Value = false;
    Status = "locked";
  };

  # set OCSP fetch failures to hard-fail
  # [SETUP-WEB] SEC_ERROR_OCSP_SERVER_ERROR
  # When a CA cannot be reached to validate a cert, Firefox just continues the connection (=soft-fail)
  # Setting this pref to true tells Firefox to instead terminate the connection (=hard-fail)
  # It is pointless to soft-fail when an OCSP fetch fails: you cannot confirm a cert is still valid (it
  # could have been revoked) and/or you could be under attack (e.g. malicious blocking of OCSP servers)
  "security.OCSP.require" = {
    Value = true;
    Status = "locked";
  };

  # enable strict PKP (Public Key Pinning)
  "security.cert_pinning.enforcement_level" = {
    Value = 2;
    Status = "locked";
  };

  # enable CRLite
  # [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1429800,1670985,1753071
  # [2] https://blog.mozilla.org/security/tag/crlite/ ***/
  "security.remote_settings.crlite_filters.enabled" = {
    Value = true;
    Status = "locked";
  };

  "security.pki.crlite_mode" = {
    Value = 2;
    Status = "locked";
  };

  # disable HTTP background requests
  "dom.security.https_only_mode_send_http_background_request" = {
    Value = false;
    Status = "locked";
  };

  # display warning on the padlock for "broken security"
  "security.ssl.treat_unsafe_negotiation_as_broken" = {
    Value = true;
    Status = "locked";
  };

  # display advanced information on Insecure Connection warning pages
  "browser.xul.error_pages.expert_bad_cert" = {
    Value = true;
    Status = "locked";
  };

  # control the amount of cross-origin information to send
  "network.http.referer.XOriginTrimmingPolicy" = {
    Value = 2;
    Status = "locked";
  };

  # enable Container Tabs and its UI setting
  "privacy.userContext.enabled" = {
    Value = true;
    Status = "locked";
  };

  "privacy.userContext.ui.enabled" = {
    Value = true;
    Status = "locked";
  };

  # force WebRTC inside the proxy
  "media.peerconnection.ice.proxy_only_if_behind_proxy" = {
    Value = true;
    Status = "locked";
  };

  # force a single network interface for ICE candidates generation
  "media.peerconnection.ice.default_address_only" = {
    Value = true;
    Status = "locked";
  };

  # prevent scripts from moving and resizing open windows
  "dom.disable_window_move_resize" = {
    Value = true;
    Status = "locked";
  };

  # disable UITour backend
  "browser.uitour.enabled" = {
    Value = false;
    Status = "locked";
  };

  # reset remote debugging to disabled
  "devtools.debugger.remote-enabled" = {
    Value = false;
    Status = "locked";
  };

  # remove special permissions for certain mozilla domains
  "permissions.manager.defaultsUrl" = {
    Value = "";
    Status = "locked";
  };

  # remove webchannel whitelist
  "webchannel.allowObject.urlWhitelist" = {
    Value = "";
    Status = "locked";
  };

  # use Punycode in Internationalized Domain Names to eliminate possible spoofing
  "network.IDN_show_punycode" = {
    Value = true;
    Status = "locked";
  };

  # enforce PDFJS, disable PDFJS scripting
  "pdfjs.disabled"  = {
    Value = false;
    Status = "locked";
  };

  "pdfjs.enableScripting" = {
    Value = false;
    Status = "locked";
  };

  # disable middle click on new tab button opening URLs or searches using clipboard
  "browser.tabs.searchclipboardfor.middleclick" = {
    Value = false;
    Status = "locked";
  };

  # disable downloads panel opening on every download
  "browser.download.alwaysOpenPanel" = {
    Value = false;
    Status = "locked";
  };

  # disable adding downloads to the system's "recent documents" list
  "browser.download.manager.addToRecentDocs" = {
    Value = false;
    Status = "locked";
  };

  # enable user interaction for security by always asking how to handle new mimetypes
  "browser.download.always_ask_before_handling_new_types" = {
    Value = true;
    Status = "locked";
  };

  # disable bypassing 3rd party extension install prompts
  "extensions.postDownloadThirdPartyPrompt" = {
    Value = false;
    Status = "locked";
  };

  # enable Enhanced Tracking Protection Strict Mode
  "browser.contentblocking.category" = {
    Value = "strict";
    Status = "locked";
  };

  # enable Resist Fingerprinting
  "privacy.resistFingerprinting" = {
    Value = true;
    Status = "locked";
  };

  # set RFP new window size max rounded values
  "privacy.window.maxInnerWidth" =  {
    Value = 1600;
    Status = "locked";
  };

  "privacy.window.maxInnerHeight" =  {
    Value = 900;
    Status = "locked";
  };

  #enable letterboxing
  "privacy.resistFingerprinting.letterboxing" = {
    Value = true;
    Status = "locked";
  };

  # use en-US locale regardless of the system or region locale
  "javascript.use_us_english_locale" = {
    Value = true;
    Status = "locked";
  };

  # enforce links targeting new windows to open in a new tab instead
  "browser.link.open_newwindow" = {
    Value = 3;
    Status = "locked";
  };

  "browser.link.open_newwindow.restriction" = {
    Value = 0;
    Status = "locked";
  };

  # disable WebGL (Web Graphics Library)
  "webgl.disabled" = {
    Value = true;
    Status = "locked";
  };

  # enforce Firefox blocklist
  "extensions.blocklist.enabled" = {
    Value = true;
    Status = "locked";
  };

  # enforce no referer spoofing
  "network.http.referer.spoofSource" = {
    Value = false;
    Status = "locked";
  };

  # enforce a security delay on some confirmation dialogs such as install, open/save
  "security.dialog_enable_delay" = {
    Value = 1000;
    Status = "locked";
  };

  # enforce no First Party Isolation
  # [WARNING] Replaced with network partitioning (FF85+) and TCP (2701), and enabling FPI
  # disables those. FPI is no longer maintained except at Tor Project for Tor Browser's config ***/
  "privacy.firstparty.isolate" = {
    Value = false;
    Status = "locked";
  };

  # enforce SmartBlock shims (about:compat)
  # https://blog.mozilla.org/security/2021/03/23/introducing-smartblock/
  "extensions.webcompat.enable_shims" = {
    Value = true;
    Status = "locked";
  };

  # enforce no TLS 1.0/1.1 downgradesenforce no TLS 1.0/1.1 downgrades
  "security.tls.version.enable-deprecated" = {
    Value = false;
    Status = "locked";
  };

  # enforce Quarantined Domains
  "extensions.quarantinedDomains.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable welcome notices
  "browser.startup.homepage_override.mstone" = {
    Value = "ignore";
    Status = "locked";
  };

  # disable search terms
  "browser.urlbar.showSearchTerms.enabled" = {
    Value = false;
    Status = "locked";
  };


  # "browser.tabs.firefox-view" = {
  #   Value = false;
  #   Status = "locked";
  # };

  # remove temp files opened from non-PB windows with an external application
  "browser.download.start_downloads_in_tmp_dir" = {
    Value = true;
    Status = "locked";
  };

  "browser.helperApps.deleteTempFileOnExit" = {
    Value = true;
    Status = "locked";
  };

  # disable website control over browser right-click context menu
  "dom.event.contextmenu.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable Clipboard API
  "dom.event.clipboardevents.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable datacollection by default
  "dom.private-attribution.submission.enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable webextension restrictions on certain mozilla domains (also need to disable mozAddonManger Web API)
  "extensions.webextensions.restrictedDomains" = {
    Value = "";
    Status = "locked";
  };

  # disable mozAddonManager Web API
  "privacy.resistFingerprinting.block_mozAddonManager" = {
    Value = true;
    Status = "locked";
  };

  "extensions.recommendations.themeRecommendationUrl" = {
    Value = "";
    Status = "locked";
  };

  # control when to send a cross-origin referer
  # 0=always (default), 1=only if base domains match, 2=only if hosts match
  # Will cause breakage: older modems/routers and some sites e.g banks, vimeo, icloud, instagram
  "network.http.referer.XOriginPolicy" = {
    Value = 2;
  };

  # disable skipping DoH when parental controls are enabled
  "network.dns.skipTRR-when-parental-control-enabled" = {
    Value = false;
    Status = "locked";
  };

  # disable webrtc (Web Real-Time Communication)
  "media.peerconnection.enabled" = {
    Value = false;
    Status = "locked";
  };

  "startup.homepage_welcome_url.additional" = {
    Value = "";
    Status = "locked";
  };

  "intl.accept_languages" = {
    Value = "en-US, en";
    Status = "locked";
  };
}
