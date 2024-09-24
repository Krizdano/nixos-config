{ pkgs, ... }: {
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    settings = {
      # general = {
      #  debug = true;
      # };
      server = {
        port = 8080;
        secret_key = "@SEARX_SECRET_KEY@";
        bind_address = "0.0.0.0";
      };
      search = {
        autocomplete = "google";
      };
      ui = {
        infinite_scroll = true;
      };
      result_proxy = {
        url = "http://localhost:3000/";
        proxify_results = true;
      };
      enabled_plugins = [
        "Open Access DOI rewrite"
        "Hash plugin"
        "Tracker URL remover"
      ];
      engines = [
        {
          name = "wikipedia";
          disabled = true;
        }

        {
          name = "wikidata";
          disabled = true;
        }

        {
          name = "qwant";
          disabled = true;
        }

        {
          name = "reddit";
          disabled = false;
        }

        {
          name = "duckduckgo";
          disabled = true;
        }

        {
          name = "brave";
          disabled = false;
        }

        {
          name = "bing";
          disabled = false;
        }

        {
          name = "qwant images";
          disabled = true;
        }

        {
          name = "qwant videos";
          disabled = true;
        }

        {
          name = "qwant news";
          disabled = true;
        }

        {
          name = "yahoo news";
          disabled = true;
        }
      ];
    };
  };

  services.morty = {
    enable = true;
  };
}
