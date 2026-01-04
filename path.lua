local path = {
    __eq = function (path1, path2)
        return path1:_cost() == path2:_cost()
    end,
    __lt = function (path1, path2)
        return path1:_cost() < path2:_cost()
    end,
    __le = function (path1, path2)
        return path1:_cost() <= path2:_cost()
    end,
    __tostring = function(p)
        return tostring(p.pose)
    end
}
path.__index = path


setmetatable(path, {
    __call = function (cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})


function path:_init(pose)
    self.pose = pose
    self.stepcost = 0
    self.steps = ""
end


function path:nextStep(newPose, step, stepcost)
    local newPath = path(newPose)
    newPath.stepcost = self.stepcost + (stepcost or 1)
    newPath.steps = self.steps .. step
    return newPath
end


function path:_cost()
    return self.stepcost
end


return path