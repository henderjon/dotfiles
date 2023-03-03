#!/usr/bin/env python3

import sys

esc = "\033[", # "\u001b" "\033", byte(27),
reset = "0m"

text = {
	"Bold"          : ("1", "22"),
	"Dim"           : ("2", "22"),
	"Italic"        : ("3", "23"),
	"Underline"     : ("4", "24"),
	"Blink"         : ("5", "25"),
	"Reverse"       : ("7", "27"),
	"Hidden"        : ("8", "28"),
	"Strikethrough" : ("9", "29"),
}
fgs = {
	"Black"         : ("30", "39"),
	"Red"           : ("31", "39"),
	"Green"         : ("32", "39"),
	"Yellow"        : ("33", "39"),
	"Blue"          : ("34", "39"),
	"Magenta"       : ("35", "39"),
	"Cyan"          : ("36", "39"),
	"White"         : ("37", "39"),
	"Default"       : ("39", "39"),
}
bgs = {
	"BlackBG"       : ("40", "49"),
	"RedBG"         : ("41", "49"),
	"GreenBG"       : ("42", "49"),
	"YellowBG"      : ("43", "49"),
	"BlueBG"        : ("44", "49"),
	"MagentaBG"     : ("45", "49"),
	"CyanBG"        : ("46", "49"),
	"WhiteBG"       : ("47", "49"),
	"DefaultBG"     : ("49", "49"),
}

def print_fg_bg():
	sys.stdout.write(" %13s" % "")
	for fg_name, fg_codes in fgs.items():
		sys.stdout.write(" %13s" % fg_name)

	sys.stdout.write("\n")

	for fg_name, fg_codes in fgs.items():
		sys.stdout.write(" %13s" % fg_name)

		for _, bg_codes in bgs.items():
			sys.stdout.write(" \033[%s;%sm %s \033[%s;%sm" % (fg_codes[0], bg_codes[0], "Hello World", fg_codes[1], bg_codes[1]))

		sys.stdout.write("\n")


def print_text_on_bg():
	sys.stdout.write("\n")

	for fg_name, fg_codes in fgs.items():
		sys.stdout.write(" %13s " % fg_name)

		for text_name, text_codes in text.items():
			sys.stdout.write(" \033[%s;%sm %s \033[0m" % (fg_codes[0], text_codes[0], text_name))

		sys.stdout.write("\n")


def print_white_on_fg(double=False):
	sys.stdout.write("\n")

	for bg_name, bg_codes in bgs.items():
		sys.stdout.write(" %13s" % bg_name)

		sys.stdout.write(" \033[%sm" % bg_codes[0])
		for text_name, text_codes in text.items():
			sys.stdout.write(" \033[%sm %s \033[%sm" % (text_codes[0], text_name, text_codes[1]))

		sys.stdout.write("\033[%sm" % bg_codes[1])

		if double:
			sys.stdout.write("\n %13s \033[%sm" % ("", bg_codes[0]))
			for text_name, text_codes in text.items():
				sys.stdout.write(" \033[%sm %s \033[%sm" % (text_codes[0], text_name, text_codes[1]))

			sys.stdout.write("\033[%sm" % bg_codes[1])

		sys.stdout.write("\n")


def print_black_on_fg(double=False):
	sys.stdout.write("\n")

	for bg_name, bg_codes in bgs.items():
		sys.stdout.write(" %13s" % bg_name)

		sys.stdout.write(" \033[30;%sm" % bg_codes[0])
		for text_name, text_codes in text.items():
			sys.stdout.write(" \033[%sm %s \033[%sm" % (text_codes[0], text_name, text_codes[1]))

		sys.stdout.write("\033[39;%sm" % bg_codes[1])

		if double:
			sys.stdout.write("\n %13s \033[30;%sm" % ("", bg_codes[0]))
			for text_name, text_codes in text.items():
				sys.stdout.write(" \033[%sm %s \033[%sm" % (text_codes[0], text_name, text_codes[1]))

			sys.stdout.write("\033[39;%sm" % bg_codes[1])

		sys.stdout.write("\n")

if __name__ == '__main__':
	print_fg_bg()
	print_text_on_bg()
	print_white_on_fg(False)
	print_black_on_fg(False)
	sys.stdout.write("\n")


