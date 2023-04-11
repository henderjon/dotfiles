# ASCII

https://www.lammertbies.nl/comm/info/ascii-characters

ASCII, the history
--------------------------------------------------------------------------------

The most used computer standard is without doubt ASCII, the American Standard Code for Information Interchange. When people started to develop computers, they had to define a way to represent certain types of information in a digital format. For numbers this was relatively easy, but text representation was far more difficult. Morse code was developed in the 19th century, but could not be easily adapted to the binary system in computers because the codes used for characters have different lengths and there is no obvious sorting method.

IBM came in the sixties of the previous century with it’s own solution EBCDIC, Extended Binary Coded Decimal Interchange Code used on their mainframes and AS/400 systems. But this system had some drawbacks. The letters of the alphabet were placed in blocks which is not very useful for sorting. At the same time that IBM was developing her EBCDIC solution, others computer developers were creating their own.

It became evident that exchanging data between various computer systems would be a huge problem if this diversity would not stop. It was therefore that Bob Bemer—now often called the Father of ASCII—compiled all different coding methods in a huge list. It was this list that made computer manufacturers realize that something had to be done about this situation quickly. Bob Bemer started standardization committees, and the first implementation of ASCII was introduced in 1963. Extensions for foreign languages were adopted to ASCII in 1967, and in 1968 it finally became an official government standard.

Nowadays nearly 100% of all computers use the ASCII coding as their primary coding system. Extensions for foreign languages are all coded as a super-set of ASCII. Therefore we can say without doubt that ASCII is the most used computer standard in the world.

ASCII character set table
--------------------------------------------------------------------------------

The ASCII character set has been adopted as the standard in information exchange. The first 32 characters and the last one are control codes, the others are printable characters. The control codes DC1 (XON) and DC3 (XOFF) are used in software flow control applications. The following table shows the ASCII character set.

–	0	1	2	3	4	5	6	7
0	NUL	SOH	STX	ETX	EOT	ENQ	ACK	BEL
8	BS	HT	LF	VT	FF	CR	SO	SI
16	DLE	DC1	DC2	DC3	DC4	NAK	SYN	ETB
24	CAN	EM	SUB	ESC	FS	GS	RS	US
32	SP	!	“	#	$	%	&	‘
40	(	)	*	+	,	–	.	/
48	0	1	2	3	4	5	6	7
56	8	9	:	;	<	=	>	?
64	@	A	B	C	D	E	F	G
72	H	I	J	K	L	M	N	O
80	P	Q	R	S	T	U	V	W
88	X	Y	Z	[	\	]	^	_
96	`	a	b	c	d	e	f	g
104	h	i	j	k	l	m	n	o
112	p	q	r	s	t	u	v	w
120	x	y	z	{	|	}	~	DEL


The ASCII character set
--------------------------------------------------------------------------------

### ASCII control codes in detail

0 – NUL – Null character
The NUL character in the ASCII character set was originally meant to be treated as a NOP, a character to be ignored. This would be useful on paper tapes where additional information had to be added in between existing information. However, some printing devices had the NUL implemented as a white space instead. Later on, the importance of the null character increased significantly when it was defined as the string terminator in the C programming language. It made it possible to define strings of infinite length in programming languages. Until then most languages like Pascal defined a string as a length indicator, followed by an array that contained the characters.

1 – SOH – Start of heading
If the communication primarily exists of commands and messages, the SOH can be used to mark the beginning of each message header. In the original 1963 definition of the ASCII standard the name start of message was used, which has been renamed to start of heading in the final release. Nowadays we often see the SOH used in serial RS232 communications where there is a master-slave configuration. Each command from the master starts with the SOH. This makes it possible for the slave or slaves to re-synchronize on the next command when data errors occurred. Without a clear marking of the start of each command a re-sync might be problematic to implement.

2 – STX – Start of text
3 – ETX – End of text
A message based communication protocol will probably use messages with a header containing addressing information, followed by the actual content. The ASCII STX indicates the start of the content part in such a message. This control code automatically ends a previous header, i.e. there is no control code to close a header started by SOH. The end of the message content is signaled with control character ETX. The actual contents of a message are not defined by the ASCII standard and are protocol dependent. Interesting to note is, that in the 1963 draft of the standard, naming conventions differed. STX was in this draft called EOA, end of address and ETX started its life as EOM, end of message. This is because in the original draft a message always contained a start and stop control character. The new definition allowed to use only the SOH to send a fixed length command, without the need to end the command with a trailing control code. In fact, in current serial protocols we see this commonly used where fixed length messages are sent without a distinction between the header and content.

4 – EOT – End of transmission
5 – ENQ – Enquiry
6 – ACK – Acknowledgment
7 – BEL – Audible bell
The BEL code is an interesting one in the ASCII set as it is not primarily used for data coding or device control. Instead it is used to attract human attention with an audible sound. It was intended to be used on both computers and devices like printers. In the programming language C the control code \a is used for the bell signal.

8 – BS – Backspace
The functionality of the backspace has changed over time. In the beginning it was primarily meant to move the cursor one character backwards on printers and teletypes to make accents on characters possible. For example to generate the character â, one could send the sequence aBS^ to the printer. This method was a practical copy of the way how characters with accents were handled on mechanical typewriters, but when CRT’s were introduced it was no longer supported in that way. Therefore now the backspace is most often used to not only re-position the cursor, but also delete the actual contents on that position. You can use this control character as \b in the C programming language.

9 – HT – Horizontal tab
The HT control character in the ASCII character set is defined for layout purposes. It instructs the output device to proceed to the next table column. Table column width is flexible, but on many devices the distance between table columns defaults to 8. The use of the horizontal tab not only reduced the work for data typists, but also introduced a method to reduce the amount of storage space necessary for formatted texts. We will now laugh about it, but keep in mind that the ASCII standard was developed 40 years ago when every byte of storage was valuable, and compression methods like ZIP, didn’t exist. The control character HT is available as \t in the C programming language.

10 – LF – Line feed
The line feed character is one of the characters in the ASCII character set that has been misused. Originally, the LF character was meant to move the head of a printer one line down. A second control character CR would then be used to move the printing head to the left margin. This is the way it was implemented in many serial protocols and in operating systems like MS-DOS and Windows. On the other hand the C programming language and Unix operating system redefined this character as newline which meant a combination of line feed and carriage return. You can argue about which use is wrong. The way C and Unix handle it is certainly more natural from a programming point of view. On the other hand is the MS-DOS implementation closer to the original definition. It would have been better if both line feed and newline were part of the original ASCII definition because the first defines a typical device control functionality where the latter is a logical text separator. But this separation is not the case. Nowadays people tend to use the LF character mainly as newline function and most software that handles plain ASCII text files is capable of handling both single LF and CR/LF combinations. The control character is in the programming language C available as \n.

11 – VT – Vertical tab
The vertical tab is like the horizontal tab defined to reduce the amount of work for creating layouts, and also reduce the amount of storage space for formatted text pages. The VT control code is used to jump to the next marked line. To be honest, I have never seen a situation or application where this functionality was implemented. In most situations a sequence of LF codes is used instead.

12 – FF – Form feed
The form feed code FF was designed to control the behavior of printers. When receiving this code the printer moves to the next sheet of paper. The behavior of the control code on terminals depends on the implementation. Some clear the screen, whereas others only display the ^L characters or perform a line feed instead. The shell environments Bash and Tcsh have implemented the ASCII form feed as a clear screen command. The form feed is implemented as \f in the C programming language.

13 – CR – Carriage return
The carriage return in the ASCII character set in its original form is meant to move the printing head back to the left margin without moving to the next line. Over time this code has also been assigned to the enter key on keyboards to signal that the input of text is finished. With screen oriented representation of data, people wanted that entering data would also imply that the cursor positioned to the next line. Therefore, in the C programming language and the unix operating system, a redefinition of the LF control code has taken place to newline. Often software now silently translates an entered CR to the LF ASCII code when the data is stored.

14 – SO – Shift out
15 – SI – Shift in
Even as early as in the sixties, the people who defined the ASCII character set understood that it would be valuable to make the character set not only available for the English alphabet, but also for foreign ones. The shift in and shift out were defined for this purpose. Originally it was meant to switch between the Cyrillic alphabet and Latin. The Cyrillic ASCII definition which uses the shift characters is KOI-7. Later on these control codes were also used to change the typeface on printers. In this use SO produced double wide characters where condensed printing was selected with SI.

16 – DLE – Data link escape
It is sometimes necessary in an ongoing data communication to send control characters. There are situations where those control characters might be understood as part of the normal data stream. The DLE has been defined in the ASCII standard for these situations. If this character is detected in a data-stream, the receiving party knows, that one or more of the following characters must be interpreted in a different way than the other characters in the stream. The exact interpretation of the following characters is not part of the ASCII definition, just the availability to break out of a communication stream with the data link escape. In the Hayes communication protocol for modems, the data link escape has been defined as silence+++silence. In my opinion it would have been a better idea if the Hayes protocol had used the DLE instead, as it does not need to embedded by communication silence, and it would fit within an existing standard. However, the developers of Hayes decided otherwise and now the +++ sequence is used far more often then the original DLE.

17 – DC1 – Device control 1 / XON – Transmission on
Although originally defined as DC1, this ASCII control code is now better known as the XON code used for software flow control in serial communications. The main use is restarting the transmission after the communication has been stopped by the XOFF control code. People who used to work with serial terminals probably remember that sometimes when data errors occurred, it helped to hit the Ctrl-Q key. This is because this key-sequence in fact generates the XON control code, which unlocks a blocked communication when terminal or host computer accidentally interpreted an erroneous character as XOFF.

18 – DC2 – Device control 2
19 – DC3 – Device control 3 / XOFF – Transmission off
20 – DC4 – Device control 4
21 – NAK – Negative acknowledgment
22 – SYN – Synchronous idle
23 – ETB – End of transmission block
24 – CAN – Cancel
25 – EM – End of medium
The EM is used at the end of a serial storage medium like paper tape or magnetic reels. It indicates the logical end of the data. It is not necessary that this is also the physical end of the data carrier.

26 – SUB – Substitute character
27 – ESC – Escape
The escape character is one of the inventions in the ASCII standard that was proposed by Bob Bemer. It is used to start an extended sequence of control codes. In this way it was not necessary to put all thinkable control codes in the ASCII standard. As new technologies would need new control commands, the ESC would be present to be the starting character of these multi-character commands. Escape codes are widely used in printers and terminals to control device settings like fonts, text positioning and colors. If ESC had been absent in the original ASCII definition, the standard would likely have been superseded by some other standard in the past. The escape possibility allowed developers to literally escape from the standard where necessary, but use it whenever possible.

28 – FS – File separator
The file separator FS is an interesting control code, as it gives us insight in the way that computer technology was organized in the sixties. We are now used to random access media like RAM and magnetic disks, but when the ASCII standard was defined, most data was serial. I am not only talking about serial communications, but also about serial storage like punch cards, paper tape and magnetic tapes. In such a situation it is clearly efficient to have a single control code to signal the separation of two files. The FS was defined for this purpose.

29 – GS – Group separator
Data storage was one of the main reasons for some control codes to get in the ASCII definition. Databases are most of the time setup with tables, containing records. All records in one table have the same type, but records of different tables can be different. The group separator GS is defined to separate tables in a serial data storage system. Note that the word table wasn’t used at that moment and the ASCII people called it a group.

30 – RS – Record separator
Within a group (or table) the records are separated with RS or record separator.

31 – US – Unit separator
The smallest data items to be stored in a database are called units in the ASCII definition. We would call them field now. The unit separator separates these fields in a serial data storage environment. Most current database implementations require that fields of most types have a fixed length. Enough space in the record is allocated to store the largest possible member of each field, even if this is not necessary in most cases. This costs a large amount of space in many situations. The US control code allows all fields to have a variable length. If data storage space is limited—as in the sixties—this is a good way to preserve valuable space. On the other hand is serial storage far less efficient than the table driven RAM and disk implementations of modern times. I can’t imagine a situation where modern SQL databases are run with the data stored on paper tape or magnetic reels…

32 – SP – White space
You can argue if the space character is a real control character as it is so widely used in normal texts. But, as the horizontal tab and backspace are also called control characters in the ASCII set, I think it is most natural to call the white space or forward space also a control character. After all it doesn’t represent a character by itself, but merely a command to the output device to proceed one position forward, clearing the information in the current field. In many applications like word processors the white space is also a character that can cause lines to wrap, and web browsers combine multiple spaces to just one output character. This strengthens my belief that it is not just representing a unique character, but an information carrier for devices and applications.

127 – DEL – Delete
One might question why all control codes in the ASCII character set have low values, but the DEL control code has value 127. This is, because this specific character was defined for deleting data on paper tapes. Most paper tapes in that time used 7 holes to code the data. The value 127 represents a binary pattern were all seven bits are high, so when using the DEL character on an existing paper tape, all holes are punched and existing data is erased.

- https://www.sciencebuddies.org/science-fair-projects/references/ascii-table
- https://www.lammertbies.nl/comm/info/ascii-characters
- DLE	data link escape; Comment is the ascii Data Link Escape (DLE) character and begins a commented record
- FS	file separator; FileSep is the ascii File Separator (FS) character and delineates collections of groups (think DBs)
- GS	group separator; GroupSep is the ascii Group Separator (GS) character and delineates groups of records (think DB tables)
- RS	request to send/record separator; RecordSep is the ascii Record Separator (RS) character and delineates records (think DB rows in a table)
- US	unit separator; UnitSep is the ascii Unit Separator (US) character and delineates fields in a record (think DB fields in a row)
