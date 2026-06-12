import naylib, logic



proc main() = 
  initWindow(screenWidth, screenHeight,  "Chronicles")
  setTargetFPS(60)
  var board = createBoard()


  while not windowShouldClose():
    beginDrawing()
    clearBackground(Beige)
    update(board)
    drawBoard(board)
    endDrawing()
  closeWindow()


main()
