extends Control


# this node is a scene for encrypting a message using affine cypher

# Child nodes
onready var encrypt_screen = $Encrypt
onready var encrypt_plain_text = $Encrypt/PlainText
onready var encrypt_encrypted_text = $Encrypt/EncryptedText


onready var decrypt_screen = $Decrypt
onready var decrypt_plain_text = $Decrypt/PlainText
onready var decrypt_encrypted_text = $Decrypt/EncryptedText

onready var key_container = $KeyConainer
onready var key_a = $KeyConainer/A/LabelKeyA
onready var key_b = $KeyConainer/B/LabelKeyB
onready var error_message = $KeyConainer/Error
onready var switch = $Switch
onready var help = $Help

# Variables
var encrypt = true # boolean to determine which mode is selected
var a = 1
var b = 0

# Methods

func _ready() -> void:
	$Encrypt.show()
	$Decrypt.hide()
	$Help.hide()
	encrypt = true

func update_key() -> void:
	key_a.text = "A: " + str(a)
	key_b.text = "B: " + str(b)

func update_encrypted_text() -> void :
	encrypt_encrypted_text.text = AffineCypher.encrypt(encrypt_plain_text.text)

func update_decrypted_text() -> void :
	decrypt_plain_text.text = AffineCypher.decrypt(decrypt_encrypted_text.text)

## Signal callbacks

func _on_INCA_pressed():
	a += 1
	if (a>=AffineCypher.lengthSet):
		a -= AffineCypher.lengthSet
	update_key()
	error_message.hide()

func _on_DECA_pressed():
	a -= 1
	if (a<0):
		a += AffineCypher.lengthSet
	update_key()
	error_message.hide()

func _on_INCB_pressed():
	b += 1
	if (b>=AffineCypher.lengthSet):
		b -= AffineCypher.lengthSet
	update_key()

func _on_DECB_pressed():
	b -= 1
	if (b<0):
		b += AffineCypher.lengthSet
	update_key()

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

func change_key():
	key_container.show()
	encrypt_screen.hide()
	decrypt_screen.hide()

func apply_key():
	var prev_key_a = AffineCypher.key_a
	var prev_key_b = AffineCypher.key_b
	AffineCypher.key_a = int(key_a.text.substr(3))
	AffineCypher.key_b = int(key_b.text.substr(3))
	if AffineCypher.validate():
		key_container.hide()
		if encrypt:
			encrypt_screen.show()
		else:
			decrypt_screen.show()
	else:
		error_message.show()
		a = prev_key_a
		b = prev_key_b
		update_key()

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
