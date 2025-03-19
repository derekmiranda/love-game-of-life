local ui = require("ui")

local deadClr = {0.2, 0.2, 0.2}
local hoverClr = {0.4, 0.4, 0.4}
local aliveClr = {0.75, 0.75, 0.75}

-- # of cells, horizontally + vertically, in grid
local gridCellWt = 24
local gridCellHt = 24

-- grid rendering properties
local cellLn = 16
local cellGap = 4

local grid = nil

function initializeGrid()
    grid = {} -- create the matrix
    for i = 1, gridCellWt do
        grid[i] = {} -- create a new row
        for j = 1, gridCellHt do
            local cellX = i * cellLn + (i - 1) * cellGap
            local cellY = j * cellLn + (j - 1) * cellGap
            grid[i][j] = ui.createButton(cellX, cellY, cellLn, cellLn, deadClr, hoverClr)
        end
    end
end

function forEachCell(cb)
    for i, row in pairs(grid) do
        for j, cell in pairs(row) do
            cb(cell)
        end
    end
end

function love.load()
    initializeGrid()
end

function love.mousemoved(x, y, dx, dy, isTouch)
    forEachCell(function(cell)
        cell.mousemoved(x, y)
    end)
end

function love.draw()
    forEachCell(function(cell)
        cell.draw()
    end)
end
