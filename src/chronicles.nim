import naylib, logic, std/random



proc main() = 
  initWindow(screenWidth, screenHeight,  "Chronicles")
  setTargetFPS(60)
  var index: int
  var board = createBoard()
  var diceImages: array[6, Texture]
  var buttons: array[4, Rectangle]
  let button: Rectangle = Rectangle(x: 75'f32, y: 720'f32, width: 150'f32, height: 50'f32)
  buttons[0] = button
  var pip1 = loadImage("assets/pip1.png")
  diceImages[0] = loadTextureFromImage(pip1)
  var pip2 = loadImage("assets/pip2.png")
  diceImages[1] = loadTextureFromImage(pip2)
  var pip3= loadImage("assets/pip3.png")
  diceImages[2] = loadTextureFromImage(pip3)
  var pip4 = loadImage("assets/pip4.png")
  diceImages[3] = loadTextureFromImage(pip4)
  var pip5 = loadImage("assets/pip5.png")
  diceImages[4] = loadTextureFromImage(pip5)
  var pip6 = loadImage("assets/pip6.png")
  diceImages[5] = loadTextureFromImage(pip6)
  randomize()


  while not windowShouldClose():
    beginDrawing()
    clearBackground(Beige)
    drawRectangle(button, Blue)
    drawText("Roll", button.x.int32 + 40'i32, button.y.int32 + 10'i32, 40'i32, Black)
    update(board, diceImages, index, buttons)
    drawBoard(board)
    endDrawing()
  closeWindow()


main()
