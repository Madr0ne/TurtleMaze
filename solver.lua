local PriorityQueue = require("priorityqueue")
local Path = require("path")
local Pose = require("pose")
local Orientations = require("orientations")

local Moves = {
        FORWARD = 0,
        TURNRIGHT = 1,
        BACKWARD = 2,
        TURNSLEFT = 3
    }

local solver = {}

solver.__index = solver

setmetatable(solver, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})


function solver:_init()
    self.movequeue = PriorityQueue()
    self.movequeue:enqueue(Path(Pose(0, 0, 0, Orientations.NORTH)))
end


--- Get list of possibilites for next movement
-- Return an array with keys for positions that can be reached in one move
-- and values that are the movement needed to reach the matching position
-- @param pose the current pose for this turtle
-- @return a table of position move pairs
local function _getPossibleMoves(pose)
    local moveList = {}

    -- Handle moves forward and back based on current orientation
    if pose.direction == Orientations.NORTH then
        moveList[Pose(pose.x, pose.y, pose.z-1, pose.direction)] = Moves.FORWARD
        moveList[Pose(pose.x, pose.y, pose.z+1, pose.direction)] = Moves.BACKWARD

    elseif pose.direction == Orientations.SOUTH then
        moveList[Pose(pose.x, pose.y, pose.z+1, pose.direction)] = Moves.FORWARD
        moveList[Pose(pose.x, pose.y, pose.z-1, pose.direction)] = Moves.BACKWARD
    end

    -- Verticle moves
    moveList[Pose(pose.x, pose.y+1, pose.z, pose.direction)] = Moves.UP
    moveList[Pose(pose.x, pose.y-1, pose.z, pose.direction)] = Moves.DOWN

    -- Spinning around
    moveList[Pose(pose.x, pose.y, pose.z, (pose.direction+1)%4)] = Moves.TURNRIGHT
    moveList[Pose(pose.x, pose.y, pose.z, (pose.direction-1)%4)] = Moves.TURNLEFT

    return moveList
end

return solver
