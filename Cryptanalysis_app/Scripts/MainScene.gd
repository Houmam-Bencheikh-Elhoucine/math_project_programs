extends Control

#children
onready var input_screen = $Input
onready var result_screen = $ResultContainer

onready var probable = $Input/ProbableWord
onready var enc_text = $Input/Text
onready var key = $ResultContainer/Key
onready var possible_dec = $ResultContainer/Text
onready var error = $ErrorMessage
onready var key_edit = $ResultContainer/KeyEdit
onready var change = $ResultContainer/Change

onready var next = $NextPosition
onready var prev = $PrevPosition
onready var start_button = $Start
onready var reset_button = $Reset
onready var pos = $ResultContainer/Position

func _ready():
	$ResultContainer.hide()
	$NextPosition.hide()
	$PrevPosition.hide()
	$Input.show()
	$Start.show()
	$Reset.hide()

func update_key(custom = false):
	if not custom:
		Cryptanalysis.getkey(Cryptanalysis.filter(probable.text))
	pos.text = str(Cryptanalysis.pos)
	key.text = "Key: " + Cryptanalysis.key

func update_key_length(i):
	if i>0:
		if len(Cryptanalysis.key) + Cryptanalysis.pos >= len(Cryptanalysis.inputString):
			return
		Cryptanalysis.key += "a"
	else:
		Cryptanalysis.key = Cryptanalysis.key.substr(0, len(Cryptanalysis.key)-1)
		if Cryptanalysis.key == "":
			Cryptanalysis.key = "a"
	key.text = "Key: " + Cryptanalysis.key
	possible_dec.text = Cryptanalysis.decrypt()

func _on_Start_pressed():
	if probable.text == "":
		error.text = "Please Introduce a probable expression to begin"
		return 
	if enc_text.text == "":
		error.text = "Please Introduce an encrypted message to begin"
		return 

	Cryptanalysis.inputString = Cryptanalysis.filter(enc_text.text)
	Cryptanalysis.pos = 0
	update_key()
	possible_dec.text = Cryptanalysis.decrypt()
	input_screen.hide()
	result_screen.show()
	start_button.hide()
	next.show()
	prev.show()
	reset_button.show()

func _on_Reset_pressed():
	input_screen.show()
	start_button.show()
	result_screen.hide()
	next.hide()
	prev.hide()
	reset_button.hide()

func _on_NextPosition_pressed():
	Cryptanalysis.pos += 1
	if Cryptanalysis.pos > len(Cryptanalysis.inputString) - len(probable.text):
		Cryptanalysis.pos = 0
	update_key()
	possible_dec.text = Cryptanalysis.decrypt()

func _on_PrevPosition_pressed():
	Cryptanalysis.pos -= 1
	if Cryptanalysis.pos < 0:
		Cryptanalysis.pos = len(Cryptanalysis.inputString) - len(probable.text)
	update_key()
	possible_dec.text = Cryptanalysis.decrypt()

func _on_Button_toggled(button_pressed):
	if button_pressed:
		key_edit.show()
		key.hide()
		change.text = "apply"
	else:
		if key_edit.text != "":
			Cryptanalysis.key = key_edit.text
			update_key(true)
		change.text = "change"
		key_edit.hide()
		key.show()
		possible_dec.text = Cryptanalysis.decrypt(false)
