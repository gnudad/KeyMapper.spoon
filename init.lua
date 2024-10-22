local obj = {}
obj.__index = obj

-- Metadata
obj.name = "KeyMapper"
obj.version = "0.1"
obj.author = "gnudad <gnudad@icloud.com>"
obj.homepage = "https://github.com/gnudad/KeyMapper.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
  self.modals = {}
  self.watcher = hs.application.watcher.new(function(name, event, app)
    if self.modals[name] == nil then return end
    if (event == hs.application.watcher.activated) then
      self.modals[name]:enter()
    elseif (event == hs.application.watcher.deactivated) then
      self.modals[name]:exit()
    end
  end)
  return self
end

function obj:bindHotkeys(mapping)
  for app, maps in pairs(mapping) do
    local modal = hs.hotkey.modal.new()
    for lhs, rhs in pairs(maps) do
      local pressedfn = function()
        hs.eventtap.keyStroke(rhs[1], rhs[2], 0)
      end
      local repeatfn = nil
      if rhs[3] then repeatfn = pressedfn end
      modal:bind(lhs[1], lhs[2], pressedfn, nil, repeatfn)
    end
    self.modals[app] = modal
  end
  return self
end

function obj:start()
  self.modals["default"]:enter()
  self.watcher:start()
  return self
end

function obj:stop()
  self.modals["default"]:exit()
  self.watcher:stop()
  return self
end

return obj
