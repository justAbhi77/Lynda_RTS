extends Node

class_name InfoManager

static var Current:InfoManager

@export var profilePic:TextureRect

@export var Line1:TextEdit
@export var Line2:TextEdit
@export var Line3:TextEdit

func _init():
	Current = self
	
func SetLines(line1:String,line2:String,line3:String):
	Line1.text = line1
	Line2.text = line2
	Line3.text = line3

func ClearLines():
	SetLines("","","")

func SetPic(Sprite:Texture):
	profilePic.texture = Sprite
	profilePic.visible = true
	profilePic.self_modulate = Color.WHITE

func ClearPic():
	profilePic.visible = false

func _ready():
	ClearLines()
	ClearPic()
