local module = {}
local noop = function()
end

function resetColor()
    love.graphics.setColor(love.graphics.getBackgroundColor())
end

function module.createButton(args)
    local x = args.x
    local y = args.y
    local w = args.w
    local h = args.h
    local text = args.text or ""
    local color = args.color
    local hoverColor = args.hoverColor
    local pressedColor = args.pressedColor
    local pressedColor = args.pressedColor
    local onpressed = args.onpressed or noop

    local btn = {}
    btn.hovered = false
    btn.pressed = false

    function btn.draw()
        local color = btn.hovered and hoverColor or btn.pressed and pressedColor or color
        love.graphics.setColor(color)
        love.graphics.rectangle("line", x, y, w, h)
        love.graphics.print(text, x, y)
        resetColor()
    end

    function btn.mousemoved(mx, my)
        btn.hovered = mx >= x and mx <= x + w and my >= y and my <= y + h
    end

    function btn.mousepressed(mx, my, mouseBtn)
        if not btn.hovered then
            return
        end

        onpressed()
    end

    return btn
end

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
        resetColor()
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
