extends Node


var SET = "abcdefghijklmnopqrstuvwxyz"
onready var lengthSet = len(SET)

var key_a = 1
var key_b = 0

func gcd(a: int, b: int) -> int:
	var r = -1
	while (r != 0):
		r = a%b
		a = b
		b = r
	return a

func inv_a() -> int:
	var x = key_a
	var ret = 1
	while (x != 1):
		x = (x+key_a)%lengthSet
		ret += 1
	return ret

func validate() -> bool:
	return  gcd(key_a, lengthSet) == 1


func encrypt(msg: String) -> String:
		var ret = ""
		var idx
		var enc
		var lower_c
		for c in msg:
			lower_c = c.to_lower()
			if lower_c in SET:
				idx = SET.find(lower_c, 0)
				enc = (idx * key_a+key_b)%lengthSet
				ret += SET[enc]
			else: ret += c
		return ret
	
func decrypt(msg: String) -> String: 
		var ret = ""
		var idx
		var enc
		var lower_c
		var inv_a = inv_a()
		print(inv_a)
		for c in msg:
			lower_c = c.to_lower()
			if lower_c in SET:
				idx = SET.find(lower_c, 0)
				enc = ((idx - key_b)*inv_a)%lengthSet
				ret += SET[enc]
			else: ret += c
		return ret
	
