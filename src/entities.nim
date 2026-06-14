import naylib

type
    TileKind* = enum 
        farm
        industry 
        military 
        empty 


type 
    Tile* = ref object
        center*: Vector2
        sides*: int32
        radius*: float32
        rotation*: float32
        thickness*: float32
        color*: Color
        occupied*: bool
        case kind*: TileKind
        of farm:
            harvest: range[0 .. 5]
        of industry:
            production: range[0 .. 5]
        of military:
            recruitment: range[0 .. 5]
        else:
            discard
        

