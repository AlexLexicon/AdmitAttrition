pd = playdate
gfx = pd.graphics

pd.setNewlinePrinted(false)

local font = gfx.font.new("font/font-Cuberick-Bold")
gfx.setFont(font)

math.randomseed(pd.getSecondsSinceEpoch())