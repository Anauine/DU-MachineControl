local json = require('dkjson')
local params = json.decode(getInput()) or {}
message = params.message or '[ "It is all NQ-Deckard\'s fault."]'
fontSize = params.fontSize or 30
color = params.color or {r=1.0,g=1.0,b=0.3}
click = getCursorPressed()
local rslib = require('rslib')
rslib.drawQuickImage("assets.prod.novaquark.com/57941/0a5e1a46-e984-4bfa-81ba-9123b9255763.jpg")

--------------------------------------------------------------------------------

 font = loadFont('Play-Bold', 25)
 rx, ry = getResolution()
 layer = createLayer()
 cx, cy = getCursor()

local sx, sy = getTextBounds(font, message)
setDefaultStrokeColor(layer, Shape_Line, 1, 1, 1, 0.5)
--setNextShadow(layer, 64, color.r, color.g, color.b, 0.4)
setNextFillColor(layer, color.r, color.g, color.b, 1.0)
addBoxRounded(layer, (rx-sx-16)/15, (ry-sy-16)/1.1, sx+16, sy+16, 8)
setNextFillColor(layer, 0, 0, 0, 1)
setNextTextAlign(layer, AlignH_Center, AlignV_Middle)
addText(layer, font, message, rx/4.5,ry/1.135)

--------------------------------------------------------------------------------

local fontCache = {}
function getFont (font, size)
    local k = font .. '_' .. tostring(size)
    if not fontCache[k] then fontCache[k] = loadFont(font, size) end
    return fontCache[k]
end

function drawUsage ()
    local font = getFont('FiraMono', 16)
   setNextTextAlign(layer, AlignH_Center, AlignV_Top)
    addText(layer, font, "Activate for an exciting new message!", rx/2, ry - 32)
end

function drawCursor ()
    if cx < 0 then return end
    if getCursorDown() then
        setDefaultShadow(layer, Shape_Line, 32, color.r, color.g, color.b, 0.5)
    end
    addLine(layer, cx - 12, cy - 12, cx + 12, cy + 12)
    addLine(layer, cx + 12, cy - 12, cx - 12, cy + 12)
end

--function drawCursor ()
--    if cx < 0 then return end
--    addLine(layer, cx - 12, cy - 12, cx + 12, cy + 12)
--    addLine(layer, cx + 12, cy - 12, cx - 12, cy + 12)
--end

function prettyStr (x)
    if type(x) == 'table' then
        local elems = {}
        for k, v in pairs(x) do
            table.insert(elems, string.format('%s = %s', prettyStr(k), prettyStr(v)))
        end
        return string.format('{%s}', table.concat(elems, ', '))
    else
        return tostring(x)
    end
end

function drawParams ()
    local font = getFont('RobotoMono', 25)
    setNextTextAlign(layer, AlignH_Left, AlignV_Bottom)
    addText(layer, font, "Machine Control", 30, 30)
    local y = 70
    for k, v in pairs(params) do
        setNextTextAlign(layer, AlignH_Left, AlignV_Bottom)
        addText(layer, font, k .. ' = ' .. prettyStr(v), 30, y)
        y = y + 26
    end
    local y = 70    
--    for k, v in pairs(params2) do
--        setNextTextAlign(layer, AlignH_Left, AlignV_Bottom)
--        addText(layer, font, k .. ' = ' .. prettyStr(v), 300, y)
  --      y = y + 26
 --   end
end
--------------------------------------------------------------------------------
--new shit


if not Button then
    local mt = {}
    mt.__index = mt
    function Button (text, x, y)
        return setmetatable({
            text = text,
            x = x,
            y = y,
        }, mt)
    end

    function mt:draw ()
        local sx, sy = self:getSize()
        local x0 = self.x - sx/2
        local y0 = self.y - sy/2
        local x1 = x0 + sx
        local y1 = y0 + sy
        
        local r, g, b = 0.3, 0.7, 1.0
        if cx >= x0 and cx <= x1 and cy >= y0 and cy <= y1 then
            r, g, b = 1.0, 0.0, 0.4
            if click then setOutput(self.text) end
        end
        
--        setNextShadow(layer, 64, r, g, b, 0.3)
        setNextFillColor(layer, 0.1, 0.1, 0.1, 1)
        setNextStrokeColor(layer, r, g, b, 1)
        setNextStrokeWidth(layer, 2)
        addBoxRounded(layer, self.x - sx/2, self.y - sy/2, sx, sy, 4)
        setNextFillColor(layer, 1, 1, 1, 1)
        setNextTextAlign(layer, AlignH_Center, AlignV_Middle)
        addText(layer, font, self.text, self.x, self.y)
    end

    function mt:getSize ()
        local sx, sy = getTextBounds(font, self.text)
        return sx + 32, sy + 16
    end

    function mt:setPos (x, y)
        self.x, self.y = x, y
    end
end

function drawFree (elems)
    for i, v in ipairs(elems) do v:draw() end
end

function drawListV (elems, x, y)
    for i, v in ipairs(elems) do
        local sx, sy = v:getSize()
        v:setPos(x, y)
        v:draw()
        y = y + sy + 4
    end
end


--------------------------------------------------------------------------------

local buttons = {
    Button('Start Alt+3', 915, 378),
    Button('Hard Stop Alt+2', 885, 430),
    Button('Soft Stop Alt+1', 885, 485),
    Button('Update Item & Start Alt+6', 825, 540),
    
}
--end new shit

--drawUsage()
drawCursor()
drawParams()
drawFree(buttons)

requestAnimationFrame(1)