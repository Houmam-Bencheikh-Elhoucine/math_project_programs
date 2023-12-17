extends Node

var SET = "abcdefghijklmnopqrstuvwxyz"

onready var lengthSet = len(SET)

var key = ""

func setKey(key: String) -> void:
	self.key = ""
	for i in key:
		if i in SET:
			self.key += i

func encrypt(m: String) -> String:
	if key=='': return m
	var res = ""
	var c
	var idx = 0
	var enc
	var length = len(key)
	for i in range(len(m)):
		c = m[i].to_lower()
		if c in SET:
			enc = (SET.find(c) + SET.find(key[idx])) % lengthSet
			res += SET[enc]
			idx += 1
			if idx >= length: idx -= length
		else: res += c

	return res

func decrypt(m: String) -> String:
	var res = ""
	var c
	var idx = 0
	var enc
	var length = len(key)
	for i in range(len(m)):
		c = m[i].to_lower()
		if c in SET:
			enc = (SET.find(c) - SET.find(key[idx]))%lengthSet
			res += SET[enc]
			idx += 1
			if idx >= length: idx -= length
		else: res += c

	return res
