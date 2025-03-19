local module = {}

function module.createButton(x, y, w, h, color, hoverColor)
    -- TODO: event handlers
    -- defaults
    color = color == nil and {1, 1, 1} or color
    hoverColor = hoverColor == nil and {1, 1, 1} or hoverColor

    local btn = {}
    local hovered = false

    -- TODO: draw rect fn
    function btn.draw()
        love.graphics.setColor(hovered and hoverColor or color)
        love.graphics.rectangle("fill", x, y, w, h)
        love.graphics.setColor(love.graphics.getBackgroundColor())
    end

    function btn.mousemoved(mx, my)
        hovered = mx >= x and mx <= x + w and my >= y and my <= y + h
    end

    return btn
end

return module
