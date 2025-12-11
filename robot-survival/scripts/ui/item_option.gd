extends TextureRect


var mouse_over: bool = false

@onready var lbl_name: Label = $LblName
@onready var lbl_level: Label = $LblLevel
@onready var lbl_description: Label = $LblDescription
@onready var item_texture: TextureRect = $ItemBox/ItemTexture
var item: String = ""

var player: Player

signal selected_upgrade(upgrade)

var tween: Tween

@export var tween_intensity: float
@export var tween_duration:float


func _ready() -> void:
	if item == "":
		item = "red_gem"
		
	item_texture.texture = load(UpgradeDb.UPGRADES[item]["icon"])
	lbl_name.text = UpgradeDb.UPGRADES[item]["display_name"]
	lbl_level.text = UpgradeDb.UPGRADES[item]["level"]
	lbl_description.text = UpgradeDb.UPGRADES[item]["description"]


func _input(event: InputEvent) -> void:
	if event.is_action("left_click"):
		if mouse_over:
			emit_signal("selected_upgrade", item)


func _on_mouse_entered() -> void:
	mouse_over = true
	
	pivot_offset = size / 2
	
	tween = create_tween()
	
	tween.tween_property(self, "scale", Vector2.ONE * tween_intensity, tween_duration)
	
	tween.play()


func _on_mouse_exited() -> void:
	mouse_over = false
	
	tween = create_tween()
	
	tween.tween_property(self, "scale", Vector2.ONE, tween_duration)
	
	tween.play()
