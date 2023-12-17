extends Control

## This node is a scene of encrypting using the Cesar Cypher
## the Cesar Cypher works by traslating the order of the letters by a 
## constant value called "Key"
## that means (for a character m: e(m) = m + k
## such as: e(x) -> the encrypted character for x, and k is the key


# Signals

# Child nodes
onready var encrypt_screen = $Encrypt
onready var encrypt_plain_text = $Encrypt/PlainText
onready var encrypt_encrypted_text = $Encrypt/EncryptedText
onready var encrypt_key = $Encrypt/KeyConainer/LabelKey

onready var decrypt_screen = $Decrypt
onready var decrypt_plain_text = $Decrypt/PlainText
onready var decrypt_encrypted_text = $Decrypt/EncryptedText
onready var decrypt_key = $Decrypt/KeyConainer/LabelKey

onready var switch = $Switch
onready var help = $Help

# Variables
var encrypt = true # boolean to determine which mode is selected

# Methods

func _ready() -> void:
	$Encrypt.show()
	$Decrypt.hide()
	$Help.hide()
	encrypt = true


func update_key() -> void:
	if encrypt:
		encrypt_key.text = "Key: " + str(CesarCypher.key)
	else:
		decrypt_key.text = "Key: " + str(CesarCypher.key)

func update_encrypted_text() -> void :
	encrypt_encrypted_text.text = CesarCypher.encrypt(encrypt_plain_text.text)

func update_decrypted_text() -> void :
	decrypt_plain_text.text = CesarCypher.decrypt(decrypt_encrypted_text.text)

## Signal callbacks

func _on_INC_pressed():
	CesarCypher.incKey()
	update_key()

func _on_DEC_pressed():
	CesarCypher.decKey()
	update_key()


func _on_Encrypt_started():
	update_encrypted_text()

func _on_Decrypt_started():
	update_decrypted_text()

func _on_Switch_toggled(button_pressed):
	if button_pressed:
		switch.text = "Decrypt"
		decrypt_key.text = encrypt_key.text
		decrypt_screen.visible = true
		encrypt_screen.visible = false
		encrypt = false
	else:
		encrypt_key.text = decrypt_key.text
		switch.text = "Encrypt"
		encrypt_screen.visible = true
		decrypt_screen.visible = false
		encrypt = true


func _on_HelpButton_pressed():
	if not help.visible:
		encrypt_screen.hide()
		decrypt_screen.hide()
		help.show()
		switch.hide()
	else:
		help.hide()
		switch.show()
		if encrypt:
			encrypt_screen.show()
		else:
			decrypt_screen.show()


func _on_Close_pressed():
	help.hide()
	switch.show()
	if encrypt:
		encrypt_screen.show()
	else:
		decrypt_screen.show()

func _on_QuitButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


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
	
