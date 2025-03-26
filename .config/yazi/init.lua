require("full-border"):setup()
require("starship"):setup()
require("fuse-archive"):setup({
	smart_enter = true,
})
Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)
