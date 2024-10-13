{ pkgs, config, ... }: {
  programs.nixvim = {
    enable = true;
    opts = {
      background = "dark";
      clipboard = "unnamedplus";
      list = true;
      langmap = "ΑA,BT,CX,DC,EK,FE,GG,HM,IL,JY,KN,LU,MH,NJ,O:,:P,PR,QQ,RS,SD,TF,UI,VV,WW,XZ,YO,ZB,aa,bt,cx,dc,ek,fe,gg,hm,il,jy,kn,lu,mh,nj,o:,pr,qq,rs,sd,tf,ui,vv,zb,ww,xz,yo";
      number = true;
      cmdheight = 0; # hide command line unless needed
      cursorline = true; # highlight the text line of the cursor
      relativenumber = true;
      shiftwidth = 2;
      foldenable = true; # enable fold for nvim-ufo;
      foldlevel = 99; # set high foldlevel for nvim-ufo;
      foldlevelstart = 99; # start with all code unfolded
      autochdir = true;
      ignorecase = true;
      showmode = false;
      smartindent = true;
      splitbelow = true;
      splitright = true;
      tabstop = 2;
      termguicolors = true;
      updatetime = 300;
      wrap = true;
    };

    highlight = {
      folded = {
        bg = "Background";
      };
      UfoFoldedEllipsis = {
        fg = "#585B70";
        bg = "Background";
      };
      UfoFoldedBg = {
        bg = "Background";
      };
      CursorLine = {
        fg = "#1b1c1e";
      };
      gitblame = {
        fg = "#585B70";
        bg = "#1b1c1e";
      };
    };

    globals = {
      mapleader = " ";
      qs_highlight_on_keys = [ "f" "F" "t" "T" ];
    };

    keymaps = [
      {
        key = "j";
        action = "gj";
      }

      {
        key = ";";
        action = "p";
      }

      {
        key = "k";
        action = "gk";
      }

      {
        key = "<Leader>j";
        action = ":bp<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>gl";
        action = ":Glow<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>k";
        action = ":bn<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>q";
        action = ":bd<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>z";
        action = ":ToggleTerm<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>t";
        action = ":NvimTreeToggle<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>n";
        action = ":e ~/Documents/journal/index.md<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>v";
        action = ":VimtexCompile<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>e";
        action = ":Telescope diagnostics<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>.";
        action = ":Telescope find_files<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<CR>";
        action = ":Telescope lsp_definitions<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>f";
        action = ":Telescope live_grep<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>gs";
        action = ":Gitsigns preview_hunk<CR>";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>w";
        action = ":<C-w>k";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>a";
        action = ":<C-w>h";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>s";
        action = ":<C-w>j";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>d";
        action = ":<C-w>l";
        options = {
          silent = true;
        };
      }

      {
        key = "<Leader>p";
        action = ":w !python<CR>";
        options = {
          silent = true;
        };
      }

      {
        mode = "t";
        key = "<Del>";
        action = "exit<CR>";
        options = {
          silent = true;
        };
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      git-blame-nvim
      quick-scope
      friendly-snippets
      glow-nvim
    ];

    extraPackages = with pkgs; [
      nil
      zls
    ];

    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          # color_overrides = {
          #   mocha = {
          #     base = "#161718";
          #   };
          # };
          dim_inactive = {
            enabled = true;
          };
          integrations = {
            cmp = true;
            nvimtree = true;
            telescope.enabled = true;
            treesitter = true;
            indent_blankline = {
              enabled = true;
            };
          };
        };
      };
    };

    extraConfigLuaPre = ''
                        vim.g.gitblame_date_format = '%r'
                        vim.g.gitblame_message_when_not_committed = '''
                        vim.opt.listchars:append "space:⋅"
                        vim.opt.listchars:append "eol:↴"
                        vim.notify = require("notify")

                        -- vim.cmd([[
                        --     augroup MyColors
                        --     autocmd!
                        --     autocmd ColorScheme * highlight Normal guibg=none
                        --     augroup end
                        -- ]])
    '';

    extraConfigLua = ''
                     require("lualine").setup {
                         tabline = {
                             lualine_a = {
                                 {
                                  "buffers",
                                  separator = { left = "", right = ""},
                                  right_padding = 5,
                                  top_padding = 5,
                                  symbols = { alternate_file = "" },
                                 },
                             },
                         },
                     }

                    vim.cmd('abb q Q')
                    vim.cmd('abb wq Wq')

                    vim.api.nvim_create_user_command('Wq',function(opt)
                        vim.cmd.write()
                        for _, ui in pairs(vim.api.nvim_list_uis()) do
                            if ui.chan and not ui.stdout_tty then
                                if opt.bang then
                                    vim.cmd { cmd = "bufdo", args = { "bdelete!" }, bang = true }
                                else
                                    vim.cmd { cmd = "bufdo", args = { "bdelete"} }
                                end
                                vim.fn.chanclose(ui.chan)
                            else
                                vim.cmd.quit()
                            end
                        end
                    end, { bang = true })

                    vim.api.nvim_create_user_command('Q',function(opt)
                        for _, ui in pairs(vim.api.nvim_list_uis()) do
                            if ui.chan and not ui.stdout_tty then
                                if opt.bang then
                                    vim.cmd { cmd = "bufdo", args = { "bdelete!" }, bang = true }
                                else
                                    vim.cmd { cmd = "bufdo", args = { "bdelete"} }
                                end
                                vim.fn.chanclose(ui.chan)
                            else
	                              vim.cmd.quit()
                            end
                        end
                    end, { bang = true })

                    require'lspconfig'.nil_ls.setup{}
                    require'lspconfig'.zls.setup{}

                    require("glow").setup({
                        width = 200,
                        border = "none",
                        width_ratio = 1,
                        height_ratio = 1,
                    })
    '';


    plugins = {
      treesitter = {
        enable = true;
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          asm
          bash
          gitcommit
          gitignore
          git_rebase
          markdown
          markdown_inline
          nix
          rust
          toml
          kotlin
          c
          norg
          lua
          yaml
          go
          latex
          zig
          vim
          vimdoc
        ];
        folding = true;
      };

      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
          float_opts = {
            border = "curved";
          };
        };
      };

      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
            settings = {
              caseMode = "smart_case";
              fuzzy = true;
            };
          };
        };
      };

      web-devicons.enable = true;

      notify = {
        enable = true;
        backgroundColour = "#000000";
      };

      mkdnflow = {
        enable = true;
        links = {
          conceal = true;
          transformExplicit = "
          function(text)
             -- Make lowercase, remove spaces, and reverse the string
             return string.lower(text:gsub(' ', '-'))
          end
         ";
        };
        mappings = {
          MkdnEnter = { modes = [ "n" "v" "i" ]; key = "<CR>"; };
          MkdnTab = { modes = [ "n" "v" ]; key = "<M-Tab>"; };
          MkdnSTab = { modes = [ "n" "v" ]; key = "<M-S-Tab>"; };
        };
        tables = {
          formatOnMove = true;
        };
      };

      cmp = {
        enable = true;
        settings = {
          mapping = {
            "<CR>" = "cmp.mapping.confirm({select = true})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          sources = [
            { name = "buffer"; }
            { name = "nvim_lsp"; }
            { name = "nvim_lsp_document_symbol"; }
            { name = "nvim_lsp_signature_help"; }
            { name = "treesitter"; }
            { name = "luasnip"; }
          ];
          snippet = {
            expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          };
        };
      };

      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-treesitter.enable = true;
      cmp_luasnip.enable = true;

      luasnip = {
        enable = true;
        fromVscode = [
          { }
          { lazyLoad = true; }
        ];
      };

      lsp = {
        enable = true;
        servers = {
          # rnix-lsp.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          # pylsp.enable = true;
          cssls.enable = true;
          clangd.enable = true;
        };
      };

      nvim-autopairs.enable = true;
      comment.enable = true;
      vim-surround.enable = true;
      gitsigns.enable = true;
      trouble.enable = true;
      nvim-ufo = {
        enable = true;
      };

      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            enabled = false;
          };
          indent = {
            tab_char = "▎";
          };
        };
      };

      nvim-tree = {
        enable = true;
        disableNetrw = true;
        hijackCursor = true;
        hijackNetrw = true;
        syncRootWithCwd = true;
        filesystemWatchers.enable = true;
        git = {
          enable = true;
          ignore = true;
        };
        updateFocusedFile = {
          enable = true;
        };
        view = {
          width = 25;
        };
        renderer = {
          indentMarkers.enable = true;
        };
      };

      lualine = {
        enable = true;
        settings = {
          globalstatus = true;
          componentSeparators = {
            left = "|";
            right = "|";
          };
          sectionSeparators = {
            left = "";
            right = "";
          };
          sections = {
            lualine_a = [{ separator = { left = ""; }; }];
            lualine_b = [ "filename" "branch" "diff" ];
            lualine_c = [ ];
            lualine_x = [ ];
            lualine_y = [ "filetype" "progress" ];
            lualine_z = [{ separator = { right = ""; }; }];
          };
          inactiveSections = {
            lualine_a = [ "filename" ];
            lualine_b = [ ];
            lualine_c = [ ];
            lualine_x = [ ];
            lualine_y = [ ];
            lualine_z = [ ];
          };
        };
      };
    };
  };
}
