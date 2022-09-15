local function load(modulename)
  local errmsg = ""
  for path in string.gmatch(package.path, "([^;]+)") do
    local filename = string.gsub(path, "%?", modulename)
    local file = io.open(filename, "rb")
    if file then
      -- Compile and return the module
      return assert(loadstring(assert(file:read("*a")), filename))
    end
    errmsg = errmsg.."\n\tno file '"..filename.."' (checked with custom loader)"
  end
  return errmsg
end

table.insert(package.loaders, 2, load)

require("kbario")
