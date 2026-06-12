import naylib, entities

const screenWidth* = 1280
const screenHeight* = 960
const tileRadius*: float32 = 50


proc createBoard*(): seq[Tile] = 

    var board: seq[Tile] = @[]

    var center = Vector2(x: screenWidth/2.float32, y: 100)
    var k: int = 0
    for i in 0..5:
        k += 1
        center.x = (screenWidth/2 - tileRadius * 2) - ((i).float32 * tileRadius * 2)
        for j in 1..k:
           board.add(Tile( center: Vector2(x: center.x + float32(j) * ((tileRadius - 7'f32) * 2) + float(i) * (tileRadius), y: center.y + float32(i) * (tileRadius + 20'f32)), sides: 6'i32, radius: tileRadius, rotation: 90'f32, thickness: 5'f32, color: Black))

    center.y = 520
    k = 5
    for h in 0..5:
        k -= 1
        center.x = (screenWidth/2 - tileRadius) - ((h).float32 * tileRadius * 2) + 175
        for j in 0..k:
            board.add(Tile(center: Vector2(x: center.x - float32(j) * ((tileRadius - 7'f32) * 2) + float(h) * (tileRadius), y: center.y + float32(h) * (tileRadius + 20'f32)), sides: 6'i32, radius: tileRadius, rotation: 90'f32, thickness: 5'f32, color: Black))

    return board

proc drawBoard*(board: var seq[Tile]) = 
    for tile in board: 
        drawPolyLines(Vector2(x: tile.center.x, y: tile.center.y), tile.sides, tile.radius, tile.rotation, tile.thickness, tile.color)

proc update*(board: var seq[Tile]) = 
    var mousePosition = getMousePosition()

    if isMouseButtonDown(Left):
        for tile in mitems(board):
            if checkCollisionPointCircle(Vector2(x: mousePosition.x, y: mousePosition.y), Vector2(x: tile.center.x, y: tile.center.y), tile.radius):
                tile.color = Red
                tile.thickness = 20