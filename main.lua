local ui = require("ui")
local game = require("game")

local deadClr = {0.2, 0.2, 0.2}
local deadHoverClr = {0.4, 0.4, 0.4}
local aliveClr = {0.75, 0.75, 0.75}
local aliveHoverClr = {0.6, 0.6, 0.6}

-- # of cells, horizontally + vertically, in grid
local gridCellWt = 8
local gridCellHt = 8

-- grid rendering properties
local cellLn = 32
local cellGap = 8
local gridHt = gridCellHt * cellLn + (gridCellHt - 1) * cellGap
local gridLeft = love.graphics.getWidth() / 12
local gridBtm = 10 * love.graphics.getHeight() / 12
local gridTop = gridBtm - gridHt

-- refs
local grid = nil
local btns = {}

function initializeGrid()
    grid = {} -- create the matrix
    for i = 1, gridCellWt do
        grid[i] = {} -- create a new row
        for j = 1, gridCellHt do
            local cellX = gridLeft + (i - 1) * cellLn + (i - 1) * cellGap
            local cellY = gridTop + (j - 1) * cellLn + (j - 1) * cellGap
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

function clearGrid()
    forEachCell(function(cell)
        cell.alive = false
    end)
end

function initializeBtns()
    btns.advance = ui.createButton({
        text = "ADVANCE",
        x = gridLeft,
        y = gridBtm + cellGap,
        w = 2 * cellLn + cellGap,
        h = 16,
        onpressed = calcNextGen,
        color = aliveClr,
        hoverColor = aliveHoverClr,
        pressedColor = deadHoverClr
    })
    btns.clear = ui.createButton({
        text = "CLEAR",
        x = gridLeft + 2 * cellLn + 2 * cellGap,
        y = gridBtm + cellGap,
        w = 2 * cellLn + cellGap,
        h = 16,
        onpressed = clearGrid,
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
