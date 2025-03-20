local module = {}

function module.createCell(cellArgs)
    local x = cellArgs.x
    local y = cellArgs.y
    local w = cellArgs.w
    local h = cellArgs.h
    local deadColor = cellArgs.deadColor
    local deadHoverColor = cellArgs.deadHoverColor
    local aliveColor = cellArgs.aliveColor
    local aliveHoverColor = cellArgs.aliveHoverColor

    local cell = {}

    cell.hovered = false
    cell.alive = false

    function cell.draw()
        local color = cell.hovered and (cell.alive and aliveHoverColor or deadHoverColor) or
                          (cell.alive and aliveColor or deadColor)
        love.graphics.setColor(color)
        love.graphics.rectangle("fill", x, y, w, h)
        love.graphics.setColor(love.graphics.getBackgroundColor())
    end

    function cell.mousemoved(mx, my)
        cell.hovered = mx >= x and mx <= x + w and my >= y and my <= y + h
    end

    function cell.toggle()
        if not cell.hovered then
            return
        end

        cell.alive = not cell.alive
    end

    return cell
end

return module
