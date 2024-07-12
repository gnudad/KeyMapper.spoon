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
  self.filter = nil
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
  if self.filter then
    self.filter:resume()
  else
    for app, modal in pairs(self.modals) do
      if app == "default" then
        modal:enter()
      else
        self.filter = hs.window.filter.new(app)
        self.filter:subscribe(hs.window.filter.windowFocused, function() modal:enter() end)
        self.filter:subscribe(hs.window.filter.windowUnfocused, function() modal:exit() end)
      end
    end
  end
  return self
end

function obj:stop()
  self.filter:pause()
  return self
end

return obj
