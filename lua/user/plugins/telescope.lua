local telescope = require "telescope"
telescope.setup {
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {},
		},
	},
}

require("user/keymaps").telescope_keys(require "telescope.builtin")

local function ptelescope_load_extension(extension)
	local ok, _ = pcall(telescope.load_extension, extension)
	if not ok then
		print("Error[Telescope]: Failed to load " .. extension .. " extension")
	end
end

ptelescope_load_extension "fzy_native"
ptelescope_load_extension "ui-select"
