extends Node

const SET = "abcdefghijklmnopqrstuvwxyz"

var key = ""
var pos = 0
var inputString = ""

var lenSET = len(SET)

func filter(s: String) -> String: 
	var res = ""
	for i in s:
		var l = i.to_lower()
		if l in SET:
			res += l
	return res

func rotate(key: String, pos: int) -> String:
	var l = len(key)
	return key.substr(l-pos%l)+key.substr(0, l-pos%l)
	
func getkey(word: String) -> void:
	var s = getsubstr(inputString, pos, len(word))
	key = ""
	for i in range(len(word)):
		var idx = SET.find(s[i]) - SET.find(word[i])
		if (idx < 0): 
			idx += lenSET
		key += SET[idx]
#	key = rotate(key, pos)

func getsubstr(inp: String, pos: int, length: int) -> String:
	var res = inp.substr(pos, length)
	if len(res) != length:
		return ""
	return res

func decrypt(roll: bool = true) -> String:
	var res = ""
	var c
	var idx = 0
	var enc
	var length = len(key)
	var k = key
	if roll:
		k = rotate(k, pos)
	for i in range(len(inputString)):
		c = inputString[i].to_lower()
		if c in SET:
			enc = (SET.find(c) - SET.find(k[idx]))%lenSET
			res += SET[enc]
			idx += 1
			if idx >= length: 
				res += " "
				idx -= length
	return res
