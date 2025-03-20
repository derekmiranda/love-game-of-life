local module = {}
local noop = function()
end

function resolveAlive(grid, i, j)
    return grid[i] and grid[i][j] and grid[i][j].alive and 1 or 0
end

function getNumAliveNeighbors(grid, i, j)
    local nbrs = { --
    resolveAlive(grid, i - 1, j - 1), --
    resolveAlive(grid, i - 1, j), --
    resolveAlive(grid, i - 1, j + 1), --
    resolveAlive(grid, i, j - 1), --
    resolveAlive(grid, i, j + 1), --
    resolveAlive(grid, i + 1, j - 1), --
    resolveAlive(grid, i + 1, j), --
    resolveAlive(grid, i + 1, j + 1) --
    }

    local numAlive = 0
    for i = 1, #nbrs do
        numAlive = numAlive + nbrs[i]
    end

    return numAlive
end

function module.stepConway(grid)
    for i, row in pairs(grid) do
        for j, cell in pairs(row) do
            local numAlive = getNumAliveNeighbors(grid, i, j)
            cell.alive = numAlive == 3 or cell.alive and numAlive == 2
        end
    end
end

return module
