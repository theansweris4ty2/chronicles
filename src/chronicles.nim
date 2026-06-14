import naylib, logic, entities, std/random, strformat



proc main() = 
  initWindow(screenWidth, screenHeight,  "Chronicles")
  setTargetFPS(60)
  randomize()
  var index: seq[int] = @[0,0,0]
  var (board, buttons) = createBoard()
  let diceImages = loadMapImages()
  var player: Player = Player(lumber: 0, ore: 0,wheat: 0,soldiers: 0, action1: 0, action2: 0, action3: 0)
 

  while not windowShouldClose():
    beginDrawing()
    clearBackground(White)
    update(board, diceImages, index, buttons, player)
    drawBoard(board)
    endDrawing()
  closeWindow()

  echo &" {player.action1} \n {player.action2} \n {player.action3}"
  


main()
