import naylib

type
    TileKind* = enum 
        farm 
        mine
        forest
        military 


type 
    Tile* = ref object
        center*: Vector2
        sides*: int32
        radius*: float32
        rotation*: float32
        thickness*: float32
        color*: Color
        occupied*: bool
        production*: int
        case kind*: TileKind
        of farm:
            harvest: range[0 .. 5]
        of mine:
            mining: range[0 .. 5]
        of military:
            recruitment: range[0 .. 5]
        of forest: 
            logging: range[0 .. 5]

type 
    Player* = ref object
        lumber*: int
        ore*: int
        wheat*: int
        soldiers*: int
        action1*: int
        action2*: int
        action3*: int

