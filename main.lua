local ui = require("ui")
local game = require("game")

local deadClr = {0.2, 0.2, 0.2}
local deadHoverClr = {0.4, 0.4, 0.4}
local aliveClr = {0.75, 0.75, 0.75}
local aliveHoverClr = {0.6, 0.6, 0.6}

-- # of cells, horizontally + vertically, in grid
local gridCellWt = 16
local gridCellHt = 16

-- grid rendering properties
local cellLn = 16
local cellGap = 4
local gridX = love.graphics.getWidth() / 12
local gridY = 10 * love.graphics.getHeight() / 12 - gridCellHt * cellLn - (gridCellHt - 1) * cellGap

-- refs
local grid = nil
local btns = {}

function initializeGrid()
    grid = {} -- create the matrix
    for i = 1, gridCellWt do
        grid[i] = {} -- create a new row
        for j = 1, gridCellHt do
            local cellX = gridX + (i - 1) * cellLn + (i - 1) * cellGap
            local cellY = gridY + (j - 1) * cellLn + (j - 1) * cellGap
            grid[i][j] = ui.createCell({
                x = cellX,
                y = cellY,
                w = cellLn,
                h = cellLn,
                aliveColor = aliveClr,
                aliveHoverColor = aliveHoverClr,
                deadColor = deadClr,
                deadHoverColor = deadHoverClr
            })
        end
    end
end

function calcNextGen()
    game.stepConway(grid)
end

function initializeBtns()
    btns.advance = ui.createButton({
        text = "ADVANCE",
        x = gridX,
        y = 10 * love.graphics.getHeight() / 12 + 2 * cellGap,
        w = 4 * cellLn + 3 * cellGap,
        h = cellLn,
        onpressed = calcNextGen,
        color = aliveClr,
        hoverColor = aliveHoverClr,
        pressedColor = deadHoverClr
    })
end

function forEachCell(cb)
    for i, row in pairs(grid) do
        for j, cell in pairs(row) do
            cb(cell)
        end
    end
end

function love.load()
    initializeBtns()
    initializeGrid()
end

function love.mousemoved(x, y, dx, dy, isTouch)
    forEachCell(function(cell)
        cell.mousemoved(x, y)
    end)
    for _, btn in pairs(btns) do
        btn.mousemoved(x, y)
    end
end

function love.mousepressed(x, y, mouseBtn)
    forEachCell(function(cell)
        if mouseBtn == 1 then
            cell.toggle()
        end
    end)
    for _, btn in pairs(btns) do
        btn.mousepressed(mouseBtn)
    end
end

function love.draw()
    forEachCell(function(cell)
        cell.draw()
    end)
    for _, btn in pairs(btns) do
        btn.draw()
    end
end
