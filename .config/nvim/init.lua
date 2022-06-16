local vim_config_root = vim.fn.expand("<sfile>:p:h")
local pack_path = vim.fn.stdpath("data") .. "/site/pack"

function ensure(user, repo, branch, commit)
  local install_path = pack_path .. "/packer/start/" .. repo
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({"git", "clone", "--depth", "1", "--branch", branch, "https://github.com/" .. user .. "/" .. repo, install_path})
    if commit ~= nil then
      vim.fn.system({"git", "--git-dir", install_path .. "/.git", "reset", "--hard", commit})
    end
    vim.api.nvim_command(string.format("packadd %s", repo))
  end
end

ensure("wbthomason", "packer.nvim", "master")
ensure("Olical", "aniseed", "master")
ensure("lewis6991", "impatient.nvim", "main")

require("impatient")
vim.g["aniseed#env"] = {compile = true}
