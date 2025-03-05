# game_floor_hooks.gd

extends Object

func _ready(chain: ModLoaderHookChain) -> void:
	# Call any previous hooks or the original _ready method
	chain.execute_next()
	# Our custom code starts here
	# Access the reference object (instance of GameFloor)
	var game_floor := chain.reference_object as Node3D
	# Proceed only if the floor_variant's name matches
	if game_floor.floor_variant and game_floor.floor_variant.floor_name == "Cog Golf Course":
		# Apply the moonlight effect
		apply_moonlight_effect(game_floor)
	

func apply_moonlight_effect(game_floor: Node3D):
	# modify the Sun to have a moonlight effect (store the original sun's settings to revert back to later)
	var sun := game_floor.get_tree().root.get_node("Sun") as DirectionalLight3D
	var original_sun_color := sun.light_color
	var original_light_energy = sun.light_energy
	sun.light_energy = 0.5
	sun.light_color = Color(0.8, 0.8, 1)  # Moonlight color
	# connect to the s_floor_ended signal to revert the sun back to its original settings
	game_floor.s_floor_ended.connect(func():
		sun.light_energy = original_light_energy
		sun.light_color = original_sun_color
	)
	
