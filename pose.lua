local Pose = {
    __tostring = function(p)
        return p.x .. "|" .. p.y.. "|" .. p.z.. "|" .. p.orientation
    end
}

Pose.__index = Pose


setmetatable(Pose, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})


function Pose:_init(x, y, z, orientation)
  self.x = x
  self.y = y
  self.z = z
  self.orientation = orientation
end


return Pose