return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "plenary"
  },

  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local action_layout = require("telescope.actions.layout")
    local open_with_trouble = require("trouble.sources.telescope").open

    local Layout = require("nui.layout")
    local Popup = require("nui.popup")

    local TSLayout = require("telescope.pickers.layout")

    local function make_popup(options)
      local popup = Popup(options)
      function popup.border:change_title(title)
        popup.border.set_text(popup.border, "top", title)
      end

      return TSLayout.Window(popup)
    end


    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
          }
        }
      },
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            size = {
              width = "75%",
              height = "75%",
            },
          },
          vertical = {
            size = {
              width = "100%",
              height = "100%",
            },
          },
        },
        mappings = {
          n = {
            ["<M-p>"] = action_layout.toggle_preview,
            ["<c-t>"] = open_with_trouble
          },
          i = {
            ["<C-u>"] = false,
            ["<c-t>"] = open_with_trouble,
            ["<M-p>"] = action_layout.toggle_preview
          },
        },
        file_ignore_patterns = {
          "node%_modules/.*",
          ".git/*",
          "*.lock",
          "public/.*",
          "static/.*",
          'assets/.*'

        },
        create_layout = function(picker)
          local border = {
            results = {
              top_left = "┌",
              top = "─",
              top_right = "┬",
              right = "│",
              bottom_right = "",
              bottom = "",
              bottom_left = "",
              left = "│",
            },
            results_patch = {
              minimal = {
                top_left = "┌",
                top_right = "┐",
              },
              horizontal = {
                top_left = "┌",
                top_right = "┬",
              },
              vertical = {
                top_left = "├",
                top_right = "┤",
              },
            },
            prompt = {
              top_left = "├",
              top = "─",
              top_right = "┤",
              right = "│",
              bottom_right = "┘",
              bottom = "─",
              bottom_left = "└",
              left = "│",
            },
            prompt_patch = {
              minimal = {
                bottom_right = "┘",
              },
              horizontal = {
                bottom_right = "┴",
              },
              vertical = {
                bottom_right = "┘",
              },
            },
            preview = {
              top_left = "┌",
              top = "─",
              top_right = "┐",
              right = "│",
              bottom_right = "┘",
              bottom = "─",
              bottom_left = "└",
              left = "│",
            },
            preview_patch = {
              minimal = {},
              horizontal = {
                bottom = "─",
                bottom_left = "",
                bottom_right = "┘",
                left = "",
                top_left = "",
              },
              vertical = {
                bottom = "",
                bottom_left = "",
                bottom_right = "",
                left = "│",
                top_left = "┌",
              },
            },
          }

          local results = make_popup({
            focusable = false,
            border = {
              style = border.results,
              text = {
                top = picker.results_title,
                top_align = "center",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal",
            },
          })

          local prompt = make_popup({
            enter = true,
            border = {
              style = border.prompt,
              text = {
                top = picker.prompt_title,
                top_align = "center",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal",
            },
          })

          local preview = make_popup({
            focusable = false,
            border = {
              style = border.preview,
              text = {
                top = picker.preview_title,
                top_align = "center",
              },
            },
          })

          local box_by_kind = {
            vertical = Layout.Box({
              Layout.Box(preview, { grow = 1 }),
              Layout.Box(results, { grow = 1 }),
              Layout.Box(prompt, { size = 3 }),
            }, { dir = "col" }),
            horizontal = Layout.Box({
              Layout.Box({
                Layout.Box(results, { grow = 1 }),
                Layout.Box(prompt, { size = 3 }),
              }, { dir = "col", size = "50%" }),
              Layout.Box(preview, { size = "50%" }),
            }, { dir = "row" }),
            minimal = Layout.Box({
              Layout.Box(results, { grow = 1 }),
              Layout.Box(prompt, { size = 3 }),
            }, { dir = "col" }),
          }

          local function get_box()
            local strategy = picker.layout_strategy
            if strategy == "vertical" or strategy == "horizontal" then
              return box_by_kind[strategy], strategy
            end

            local height, width = vim.o.lines, vim.o.columns
            local box_kind = "horizontal"
            if width < 100 then
              box_kind = "vertical"
              if height < 40 then
                box_kind = "minimal"
              end
            end
            return box_by_kind[box_kind], box_kind
          end

          local function prepare_layout_parts(layout, box_type)
            layout.results = results
            results.border:set_style(border.results_patch[box_type])

            layout.prompt = prompt
            prompt.border:set_style(border.prompt_patch[box_type])

            if box_type == "minimal" then
              layout.preview = nil
            else
              layout.preview = preview
              preview.border:set_style(border.preview_patch[box_type])
            end
          end

          local function get_layout_size(box_kind)
            return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
          end

          local box, box_kind = get_box()
          local layout = Layout({
            relative = "editor",
            position = "50%",
            size = get_layout_size(box_kind),
          }, box)

          layout.picker = picker
          prepare_layout_parts(layout, box_kind)

          local layout_update = layout.update
          function layout:update()
            local box, box_kind = get_box()
            prepare_layout_parts(layout, box_kind)
            layout_update(self, { size = get_layout_size(box_kind) }, box)
          end

          return TSLayout(layout)
        end,

      },
    })


    vim.keymap.set('n', '<leader>fw', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>F', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set("n", "<leader>q", function()
      builtin.marks()
    end, { desc = 'builtin majks' })
    vim.keymap.set('n', '<leader>eg', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ef',
      function()
        builtin.find_files({
          hidden = false
        })
      end, { desc = "find files" })
    vim.keymap.set('n', '<leader>el', function()
      builtin.live_grep()
    end, { desc = "live grep" })
    vim.keymap.set('n', '<leader>er', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "grep string" })
    vim.keymap.set('n', '<leader>eb', function()
      builtin.buffers()
    end, { desc = "current buffers" })
    vim.keymap.set('n', '<leader>eh', function()
      builtin.help_tags()
    end, { desc = " help tags" })
    vim.keymap.set('n', '<leader>ee', function()
      builtin.resume()
    end, { desc = "resume" })
    vim.keymap.set('n', '<leader>ls', function()
      builtin.lsp_document_symbols()
    end, { desc = "symbols" })
    vim.keymap.set("n", "<leader>lw", function()
      builtin.lsp_workspace_symbols()
    end, { desc = 'workspace symbol' })

    require("telescope").load_extension("ui-select")
  end

}
