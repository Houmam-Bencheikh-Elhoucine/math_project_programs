extends Control

# children
onready var encrypt_plain_text = $Encrypt/PlainText
onready var encrypt_encrypted_text = $Encrypt/EncryptedText
onready var encrypt_screen = $Encrypt

onready var decrypt_encrypted_text = $Decrypt/EncryptedText
onready var decrypt_plain_text = $Decrypt/PlainText
onready var decrypt_screen = $Decrypt

onready var key = $Key
onready var switch = $Switch
onready var help = $Help

var encrypt = true

func _ready():
	help.hide()
	decrypt_screen.hide()
	encrypt_screen.show()
	key.show()

func update_encrypted_text() -> void :
	encrypt_encrypted_text.text = VigenereCypher.encrypt(encrypt_plain_text.text)

func update_decrypted_text() -> void :
	decrypt_plain_text.text = VigenereCypher.decrypt(decrypt_encrypted_text.text)

## Signal callbacks

func _on_Encrypt_started():
	update_encrypted_text()

func _on_Decrypt_started():
	update_decrypted_text()

func _on_Switch_toggled(button_pressed):
	if button_pressed:
		switch.text = "Decrypt"
		decrypt_screen.visible = true
		encrypt_screen.visible = false
		encrypt = false
	else:
		switch.text = "Encrypt"
		encrypt_screen.visible = true
		decrypt_screen.visible = false
		encrypt = true


func _on_HelpButton_pressed():
	if not help.visible:
		encrypt_screen.hide()
		decrypt_screen.hide()
		switch.hide()
		help.show()
		key.hide()
	else:
		help.hide()
		switch.show()
		key.show()
		if encrypt:
			encrypt_screen.show()
		else:
			decrypt_screen.show()


func _on_Close_pressed():
	help.hide()
	switch.show()
	key.show()
	if encrypt:
		encrypt_screen.show()
	else:
		decrypt_screen.show()



func _on_QuitButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func change_key():
	VigenereCypher.setKey(key.text)
	key.text = VigenereCypher.key

func copy_result() -> void:
	if not OS.has_clipboard():
		print("error while adding to clipboard")
		return 
	if encrypt:
		OS.set_clipboard(encrypt_encrypted_text.text)
	else:
		OS.set_clipboard(decrypt_plain_text.text)

func _on_copy_text(event):
	if (event is InputEventMouseButton) and (event.pressed) and (event.button_index == BUTTON_LEFT):
		copy_result()
