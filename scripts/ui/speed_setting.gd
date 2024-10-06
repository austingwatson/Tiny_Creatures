extends TextureButton

export var speed = 0





func _on_SpeedSetting_pressed():
	Engine.time_scale = speed
