import naylib, entities, std/[random, strutils]

const screenWidth* = 1280
const screenHeight* = 960
const tileRadius*: float32 = 50

proc loadMapImages*(): array[6, Texture] =
    var diceImages: array[6, Texture]
    let pip1 = loadImage("assets/pip1.png")
    diceImages[0] = loadTextureFromImage(pip1)
    let pip2 = loadImage("assets/pip2.png")
    diceImages[1] = loadTextureFromImage(pip2)
    let pip3= loadImage("assets/pip3.png")
    diceImages[2] = loadTextureFromImage(pip3)
    let pip4 = loadImage("assets/pip4.png")
    diceImages[3] = loadTextureFromImage(pip4)
    let pip5 = loadImage("assets/pip5.png")
    diceImages[4] = loadTextureFromImage(pip5)
    let pip6 = loadImage("assets/pip6.png")
    diceImages[5] = loadTextureFromImage(pip6)

    return diceImages


proc diceRoll(): int = 
    let roll = rand(0..5)
    return roll
        
   

proc createBoard*(): (seq[Tile], array[4, Rectangle]) = 
    var board: seq[Tile] = @[]
    var tileType: int
    var buttons: array[4, Rectangle]
    let button: Rectangle = Rectangle(x: 125'f32, y: 720'f32, width: 150'f32, height: 50'f32)
    buttons[0] = button

    var center = Vector2(x: screenWidth/2.float32, y: 100)
    var k: int = 0
    for i in 0..5:
        
        k += 1
        center.x = (screenWidth/2 - tileRadius * 2) - ((i).float32 * tileRadius * 2)
        for j in 1..k:
           tileType = rand(3) 
           board.add(Tile( center: Vector2(x: center.x + float32(j) * ((tileRadius - 7'f32) * 2) + float(i) * (tileRadius), y: center.y + float32(i) * (tileRadius + 20'f32)), sides: 6'i32, radius: tileRadius, rotation: 90'f32, thickness: 5'f32, color: Black, occupied: false, kind: TileKind(tileType)))
           

    center.y = 520
    k = 5
    for h in 0..5:
        k -= 1
        center.x = (screenWidth/2 - tileRadius) - ((h).float32 * tileRadius * 2) + 175
        for j in 0..k:
            tileType = rand(3)
            board.add(Tile(center: Vector2(x: center.x - float32(j) * ((tileRadius - 7'f32) * 2) + float(h) * (tileRadius), y: center.y + float32(h) * (tileRadius + 20'f32)), sides: 6'i32, radius: tileRadius, rotation: 90'f32, thickness: 5'f32, color: Black, occupied:false, kind: TileKind(tileType)))
    for tile in board:
         case tile.kind:
                of farm:
                    tile.production = rand(Tile.harvest) + 1
                of mine:
                    tile.production = rand(Tile.mining) + 1
                of military:
                    tile.production = rand(Tile.recruitment) + 1
                of forest:
                    tile.production = rand(Tile.logging) + 1
    return (board, buttons)

proc drawBoard*(board: var seq[Tile]) = 
    for tile in board: 
        drawPolyLines(Vector2(x: tile.center.x, y: tile.center.y), tile.sides, tile.radius, tile.rotation, tile.thickness, tile.color)

proc update*(board: var seq[Tile], images: array[6, Texture], index: var seq[int], buttons: array[4, Rectangle], player: Player) = 
    
    var mousePosition = getMousePosition()

    if isMouseButtonPressed(Left):
        for tile in mitems(board):
            if checkCollisionPointCircle(Vector2(x: mousePosition.x, y: mousePosition.y), Vector2(x: tile.center.x, y: tile.center.y), tile.radius) and player.action1 > 0:
                tile.color = Red
                tile.thickness = 20
                player.action1 -= 1
    if isMouseButtonDown(Right):
        for tile in mitems(board):
            if checkCollisionPointCircle(Vector2(x: mousePosition.x, y: mousePosition.y), Vector2(x: tile.center.x, y: tile.center.y), tile.radius):
                drawText($(tile.kind), 50'i32, 500'i32, 40'i32,  Black)
                drawText($(tile.production), 50'i32, 550'i32, 40'i32, Black)

    if isMouseButtonPressed(Left):
        for button in buttons:
            if checkCollisionRecs(button, Rectangle(x: mousePosition.x, y: mousePosition.y, width: 10, height: 10)) and player.action1 == 0:
                index[0] = diceRoll()
                index[1] = diceRoll()
                index[2] = diceRoll()
                player.action1 = index[0] + 1
                player.action2 = index[1] + 1
                player.action3 = index[2] + 1
    drawRectangle(buttons[0], Blue)    
    drawText("Roll", buttons[0].x.int32 + 40'i32, buttons[0].y.int32 + 10'i32, 40'i32, Black)        
    drawTexture(images[index[0]], Vector2(x: 50, y: 600), White)
    drawTexture(images[index[1]], Vector2(x: 150, y: 600), White)
    drawTexture(images[index[2]], Vector2(x: 250, y: 600), White)
               

        
