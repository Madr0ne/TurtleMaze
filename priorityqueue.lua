local priorityqueue = {}
priorityqueue.__index = priorityqueue


setmetatable(priorityqueue, {
  __call = function (cls)
    local self = setmetatable({}, cls)
    self:_init()
    return self
  end,
})


function priorityqueue:_init()
  self.size = 0
  self.heap = {}
  self.map = {}
end


local function parent(i)
    return math.floor(i/2)
end


local function left(i)
    return 2 * i
end


local function right(i)
    return 2 * i + 1
end


local function min(heap)
    return heap[1]
end


local function heapify(heap, size, i)
    local l, r, smallest
    l = left(i)
    r = right(i)
    if l <= size and heap[l] < heap[i] then
        smallest = l
    else
        smallest = i
    end

    if r <= size and heap[r] < heap[smallest] then
        smallest = r
    end

    if smallest ~= i then
        local tmp = heap[i]
        heap[i] = heap[smallest]
        heap[smallest] = tmp
        heapify(heap, size, smallest)
    end
end


local function decreaseKey(heap, i)
    while i > 1 and heap[parent(i)] > heap[i] do
        local tmp = heap[i]
        heap[i] = heap[parent(i)]
        heap[parent(i)] = tmp
        i = parent(i)
    end
end


function priorityqueue:dequeue()
    if self.size < 1 then
        return
    end

    local minvalue = min(self.heap)

    self.heap[1] = self.heap[self.size]
    self.size = self.size - 1

    heapify(self.heap, self.size, 1)
    return minvalue
end


function priorityqueue:enqueue(newValue)
    self.size = self.size + 1
    self.heap[self.size] = newValue

    self.map[tostring(newValue)] = true
    decreaseKey(self.heap, self.size)
end


function priorityqueue:contains(element)
    return self.map[tostring(element)]
end


return priorityqueue