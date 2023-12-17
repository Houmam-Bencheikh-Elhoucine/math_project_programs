extends Control

func _ready():
	print(-1%5)

func _on_Cesar_pressed():
	get_tree().change_scene("res://Scenes/CesarCypher.tscn")


func _on_Affine_pressed():
	get_tree().change_scene("res://Scenes/AffineCypher.tscn")


func _on_Vigenere_pressed():
	get_tree().change_scene("res://Scenes/VigenereCypher.tscn")
