import naylib, entities, std/random

const screenWidth* = 1280
const screenHeight* = 960
const tileRadius*: float32 = 50


proc diceRoll(): int = 
    var image: Texture
    let roll = rand(6)
    case roll:
    of 1: 
        return 0
    of 2: 
        return 1
    of 3:
        return 2
    of 4:
        return 3
    of 5:
        return 4
    of 6: 
        return 5
    else:
        discard
        
    drawTexture(image, Vector2(x: 100, y: 600), White)

proc createBoard*(): seq[Tile] = 

    var board: seq[Tile] = @[]

    var center = Vector2(x: screenWidth/2.float32, y: 100)
    var k: int = 0
    for i in 0..5:
        k += 1
        center.x = (screenWidth/2 - tileRadius * 2) - ((i).float32 * tileRadius * 2)
        for j in 1..k:
           board.add(Tile( center: Vector2(x: center.x + float32(j) * ((tileRadius - 7'f32) * 2) + float(i) * (tileRadius), y: center.y + float32(i) * (tileRadius + 20'f32)), sides: 6'i32, radius: tileRadius, rotation: 90'f32, thickness: 5'f32, color: Black, occupied: true, kind: Kind.military))

    center.y = 520
    k = 5
    for h in 0..5:
        k -= 1
        center.x = (screenWidth/2 - tileRadius) - ((h).float32 * tileRadius * 2) + 175
        for j in 0..k:
            board.add(Tile(center: Vector2(x: center.x - float32(j) * ((tileRadius - 7'f32) * 2) + float(h) * (tileRadius), y: center.y + float32(h) * (tileRadius + 20'f32)), sides: 6'i32, radius: tileRadius, rotation: 90'f32, thickness: 5'f32, color: Black, occupied:false, kind: Kind.farm))

    return board

proc drawBoard*(board: var seq[Tile]) = 
    for tile in board: 
        drawPolyLines(Vector2(x: tile.center.x, y: tile.center.y), tile.sides, tile.radius, tile.rotation, tile.thickness, tile.color)

proc update*(board: var seq[Tile], images: array[6, Texture], index: var int, buttons: array[4, Rectangle]) = 
    

    var mousePosition = getMousePosition()

    if isMouseButtonDown(Left):
        for tile in mitems(board):
            if checkCollisionPointCircle(Vector2(x: mousePosition.x, y: mousePosition.y), Vector2(x: tile.center.x, y: tile.center.y), tile.radius):
                tile.color = Red
                tile.thickness = 20
                drawText($(tile.kind), 50'i32, 500'i32, 40'i32,  Black)
        for button in buttons:
            if checkCollisionRecs(button, Rectangle(x: mousePosition.x, y: mousePosition.y, width: 10, height: 10)):
                index = diceRoll()
                
    drawTexture(images[index], Vector2(x: 100, y: 600), White)
               

        
