import naylib

type 
    Tile* = object
        center*: Vector2
        sides*: int32
        radius*: float32
        rotation*: float32
        thickness*: float32
        color*: Color