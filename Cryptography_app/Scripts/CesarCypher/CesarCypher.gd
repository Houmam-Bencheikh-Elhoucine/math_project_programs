extends Node

var SET = "abcdefghijklmnopqrstuvwxyz"
var key = 0

onready var lengthSET = len(SET)

func setKey(key: int) -> void:
	self.key = key
	if key < 0:
		key += lengthSET
	elif key >= lengthSET:
		key -= lengthSET

func incKey():
	self.key += 1
	if key >= lengthSET:
		key -= lengthSET

func decKey():
	self.key -= 1
	if key < 0:
		key += lengthSET

func encrypt(msg: String) -> String:
	var ret = ""
	var idx
	var enc
	var lower_c
	for c in msg:
		lower_c = c.to_lower()
		if lower_c in SET:
			idx = SET.find(lower_c, 0)
			enc = (idx + key)%lengthSET
			ret += SET[enc]
		else: ret += c
	return ret

func decrypt(msg: String) -> String: 
	var ret = ""
	var idx
	var enc
	var lower_c
	for c in msg:
		lower_c = c.to_lower()
		if lower_c in SET:
			idx = SET.find(lower_c, 0)
			enc = (idx - key)%lengthSET
			ret += SET[enc]
		else: ret += c
	return ret
		

