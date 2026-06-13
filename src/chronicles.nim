import naylib, logic



proc main() = 
  initWindow(screenWidth, screenHeight,  "Chronicles")
  setTargetFPS(60)
  var board = createBoard()
  var dice = loadImage("assets/pip1.png")
  var diceImage = loadTextureFromImage(dice)


  while not windowShouldClose():
    beginDrawing()
    clearBackground(Beige)
    update(board, diceImage)
    drawBoard(board)
    endDrawing()
  closeWindow()


main()
