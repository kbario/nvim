--[[ local function load_two(modulename)
  local errmsg = ""
    local filename = string.format("./Users/kylebario/luaProjects/%s", modulename)
    local file = io.open(filename, "rb")
    if file then
      -- Compile and return the module
      return assert(loadstring(assert(file:read("*a")), filename))
    end
    errmsg = errmsg.."\n\tno file '"..filename.."' (checked with custom loader)"
    return errmsg
  end

table.insert(package.loaders, 2, load_two) ]]

require("kbario")
