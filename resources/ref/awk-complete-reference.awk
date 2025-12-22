#!/usr/bin/awk -f
# AWK Built-in Functions Reference
# This file documents all built-in functions in POSIX AWK and GNU AWK (gawk)

BEGIN {
	print "=== AWK BUILT-IN FUNCTIONS REFERENCE ==="
	print ""
}

# ============================================================================
# STRING FUNCTIONS
# ============================================================================

# gsub(regexp, replacement [, target])
# Globally substitute regexp with replacement in target (or $0 if omitted)
# Returns: number of substitutions made
# Example: gsub(/foo/, "bar", str)

# sub(regexp, replacement [, target])
# Substitute first occurrence of regexp with replacement in target (or $0)
# Returns: number of substitutions made (0 or 1)
# Example: sub(/foo/, "bar", str)

# gensub(regexp, replacement, how [, target])  # gawk only
# General substitution function with more control
# how: "g" for global, "G" for global, or number for nth occurrence
# Returns: modified string (doesn't modify original)
# Example: new = gensub(/foo/, "bar", "g", str)

# index(string, substring)
# Find position of substring in string (1-indexed, 0 if not found)
# Returns: position of first occurrence
# Example: pos = index("hello", "ll")  # returns 3

# length([string])
# Get length of string (or $0 if omitted)
# Returns: number of characters
# Example: len = length("hello")  # returns 5

# match(string, regexp [, array])
# Match regexp against string, sets RSTART and RLENGTH
# array: (gawk only) captures matched groups
# Returns: position of match, or 0 if no match
# Example: if (match(str, /[0-9]+/)) print "found at", RSTART

# split(string, array [, fieldsep [, seps]])
# Split string into array using fieldsep (or FS if omitted)
# seps: (gawk only) array to store separators
# Returns: number of elements in array
# Example: n = split("a:b:c", arr, ":")  # arr[1]="a", arr[2]="b", arr[3]="c"

# patsplit(string, array [, fieldpat [, seps]])  # gawk only
# Split string into array based on pattern matches (not separators)
# Returns: number of elements
# Example: patsplit("abc123def456", arr, /[0-9]+/)  # arr[1]="123", arr[2]="456"

# sprintf(format, expression1, expression2, ...)
# Format expressions according to format string (like C printf)
# Returns: formatted string
# Example: str = sprintf("%s is %d years old", name, age)

# substr(string, start [, length])
# Extract substring starting at position start (1-indexed)
# length: optional, if omitted extracts to end
# Returns: substring
# Example: substr("hello", 2, 3)  # returns "ell"

# tolower(string)
# Convert string to lowercase
# Returns: lowercase string
# Example: tolower("HELLO")  # returns "hello"

# toupper(string)
# Convert string to uppercase
# Returns: uppercase string
# Example: toupper("hello")  # returns "HELLO"

# strtonum(string)  # gawk only
# Convert string to number (handles hex 0x, octal 0)
# Returns: numeric value
# Example: strtonum("0xFF")  # returns 255

# asort(source [, dest [, how]])  # gawk only
# Sort array by values
# dest: destination array (if omitted, sorts in place)
# how: sort method ("@ind_num_asc", "@val_str_asc", etc.)
# Returns: number of elements
# Example: n = asort(arr, sorted)

# asorti(source [, dest [, how]])  # gawk only
# Sort array by indices (keys)
# Returns: number of elements
# Example: n = asorti(arr, sorted)

# ============================================================================
# NUMERIC FUNCTIONS
# ============================================================================

# atan2(y, x)
# Arctangent of y/x in radians
# Returns: angle in radians [-π, π]
# Example: angle = atan2(1, 1)  # returns π/4

# cos(x)
# Cosine of x (x in radians)
# Returns: cosine value [-1, 1]
# Example: cos(0)  # returns 1

# sin(x)
# Sine of x (x in radians)
# Returns: sine value [-1, 1]
# Example: sin(0)  # returns 0

# exp(x)
# Exponential function (e^x)
# Returns: e raised to power x
# Example: exp(1)  # returns e (2.71828...)

# log(x)
# Natural logarithm of x (base e)
# Returns: ln(x)
# Example: log(2.71828)  # returns ~1

# sqrt(x)
# Square root of x
# Returns: √x
# Example: sqrt(16)  # returns 4

# int(x)
# Truncate x to integer (towards zero)
# Returns: integer portion
# Example: int(3.7)  # returns 3, int(-3.7)  # returns -3

# rand()
# Generate random number
# Returns: random float in [0, 1)
# Example: r = rand()

# srand([seed])
# Set random number seed
# seed: if omitted, uses current time
# Returns: previous seed value
# Example: srand(42)  # reproducible random sequence

# ============================================================================
# I/O FUNCTIONS
# ============================================================================

# close(filename_or_command)
# Close file or pipe
# Returns: 0 on success, non-zero on error
# Example: close("output.txt")

# fflush([filename])
# Flush output buffer for filename (or all open files if omitted)
# Returns: 0 on success, non-zero on error
# Example: fflush()

# system(command)
# Execute shell command
# Returns: exit status of command
# Example: system("ls -l")

# getline [var] [< file]
# getline [var] [| command]
# command | getline [var]
# Read next line into var (or $0)
# Returns: 1 on success, 0 on EOF, -1 on error
# Example: while ((getline line < "file.txt") > 0) print line

# print [expression-list] [> file]
# print [expression-list] [>> file]
# print [expression-list] [| command]
# Print expressions separated by OFS, terminated by ORS
# Example: print "hello", "world" > "output.txt"

# printf format [, expression-list] [> file]
# printf format [, expression-list] [>> file]
# printf format [, expression-list] [| command]
# Formatted print (like C printf)
# Example: printf "%s: %d\n", name, count > "output.txt"

# ============================================================================
# OPERATORS
# ============================================================================
#
# Arithmetic: + - * / % ^ ++ --
#   Example: sum = a + b; power = x ^ 2; count++
#
# Assignment: = += -= *= /= %= ^=
#   Example: total += price; x *= 2
#
# Comparison: == != < <= > >=
#   Example: if (x == 5); if (age >= 18)
#
# Logical: && || !
#   Example: if (x > 0 && x < 10); if (!found)
#
# Pattern matching: ~ !~
#   Example: if ($0 ~ /error/); if (name !~ /[0-9]/)
#
# Ternary: condition ? true_value : false_value
#   Example: max = (a > b) ? a : b
#
# String concatenation (implicit, via space):
#   Example: fullname = first " " last
#
# Field reference: $
#   Example: $1, $NF, $(NF-1), $0
#
# Array membership: in
#   Example: if (key in array)
#
# Operator Precedence (highest to lowest):
#   1. () grouping, $ field reference
#   2. ++ -- (postfix), ++ -- - ! (prefix/unary)
#   3. ^ exponentiation
#   4. * / % multiplication/division/modulo
#   5. + - addition/subtraction
#   6. (space) string concatenation
#   7. < <= > >= == != ~ !~ comparisons
#   8. in array membership
#   9. && logical AND
#   10. || logical OR
#   11. ?: ternary
#   12. = += -= *= /= %= ^= assignment
#
# Important notes:
#   - Uninitialized variables are 0 (numeric) or "" (string)
#   - Comparison is numeric if both operands look like numbers
#   - Short-circuit evaluation for && and ||
#   - Division by zero produces inf or nan
#   - Pattern matching operators ~ and !~ are AWK-specific
#   - Use parentheses for clarity in complex expressions
#   - See awk-posix-reference.awk for complete operator documentation

# ============================================================================
# CONTROL FLOW
# ============================================================================

# if/else if/else - Conditional execution
# Syntax: if (cond) stmt [else if (cond) stmt]... [else stmt]
# Example: if (x > 0) print "pos" else if (x < 0) print "neg" else print "zero"

# Ternary operator: condition ? true_value : false_value
# Example: max = (a > b) ? a : b

# while loop - Execute while condition is true
# Syntax: while (condition) statement
# Example: while (i < 10) { print i; i++ }

# do-while loop - Execute at least once, then while condition is true
# Syntax: do statement while (condition)
# Example: do { print i; i++ } while (i < 10)

# for loop - C-style loop
# Syntax: for (init; condition; increment) statement
# Example: for (i = 1; i <= 10; i++) print i

# for-in loop - Iterate over array indices
# Syntax: for (var in array) statement
# Example: for (key in arr) print key, arr[key]

# break - Exit innermost loop
# continue - Skip to next iteration of innermost loop
# next - Skip to next input record (pattern-action blocks only)
# exit [code] - Terminate program (runs END blocks)

# See POSIX AWK reference for detailed control flow examples

# ============================================================================
# TIME FUNCTIONS (gawk only)
# ============================================================================

# mktime(datespec)
# Convert datespec to timestamp
# datespec: "YYYY MM DD HH MM SS [DST]"
# Returns: seconds since epoch
# Example: mktime("2025 12 19 10 30 0")

# strftime([format [, timestamp [, utc-flag]]])
# Format timestamp as string
# format: strftime format string (default "%a %b %d %H:%M:%S %Z %Y")
# timestamp: seconds since epoch (default current time)
# Returns: formatted date/time string
# Example: strftime("%Y-%m-%d", systime())

# systime()
# Get current time
# Returns: seconds since epoch
# Example: now = systime()

# ============================================================================
# SYSTEM INTERACTION FUNCTIONS
# ============================================================================

# system(command)
# Execute shell command and wait for completion
# Returns: exit status of command (0 = success, non-zero = error)
# Example: status = system("ls -l /tmp")
# Example: if (system("test -f file.txt") == 0) print "File exists"

# exit [exit_code]
# Terminate AWK program
# exit_code: optional exit status (default: 0)
# Executes END blocks before exiting
# Example: exit 0  # successful exit
# Example: exit 1  # error exit
# Example: if (error) exit 1

# nextfile  # gawk only
# Stop processing current file and move to next file
# Skips remaining lines in current input file
# Example: /SKIP_FILE/ { nextfile }

# next
# Skip to next input record (line)
# Stops processing current line, continues with next
# Example: /^#/ { next }  # skip comment lines

# ENVIRON array
# Access environment variables
# Read-only array containing all environment variables
# Example: print ENVIRON["HOME"]
# Example: print ENVIRON["PATH"]
# Example: if ("USER" in ENVIRON) print "User:", ENVIRON["USER"]

# PROCINFO array (gawk only)
# Process and system information
# PROCINFO["pid"]        - Current process ID
# PROCINFO["ppid"]       - Parent process ID
# PROCINFO["pgrpid"]     - Process group ID
# PROCINFO["uid"]        - User ID
# PROCINFO["euid"]       - Effective user ID
# PROCINFO["gid"]        - Group ID
# PROCINFO["egid"]       - Effective group ID
# PROCINFO["version"]    - gawk version string
# PROCINFO["strftime"]   - Default strftime format
# Example: print "PID:", PROCINFO["pid"]
# Example: print "User ID:", PROCINFO["uid"]

# ============================================================================
# SYSTEM INTERACTION EXAMPLES
# ============================================================================

# Example 1: Execute command and capture output
# BEGIN {
#     cmd = "uname -s"
#     cmd | getline os
#     close(cmd)
#     print "Operating System:", os
# }

# Example 2: Check if command succeeded
# BEGIN {
#     if (system("which git > /dev/null 2>&1") == 0) {
#         print "Git is installed"
#     } else {
#         print "Git not found"
#         exit 1
#     }
# }

# Example 3: Run command for each line of input
# {
#     cmd = "echo " $1 " | tr '[:lower:]' '[:upper:]'"
#     cmd | getline upper
#     close(cmd)
#     print "Original:", $1, "Upper:", upper
# }

# Example 4: Access environment variables
# BEGIN {
#     if ("EDITOR" in ENVIRON) {
#         print "Your editor is:", ENVIRON["EDITOR"]
#     } else {
#         print "EDITOR not set, using default"
#     }
#
#     home = ENVIRON["HOME"]
#     config_file = home "/.myconfig"
#     print "Config file:", config_file
# }

# Example 5: Get process information (gawk only)
# BEGIN {
#     print "Process ID:", PROCINFO["pid"]
#     print "Parent PID:", PROCINFO["ppid"]
#     print "User ID:", PROCINFO["uid"]
#     print "gawk version:", PROCINFO["version"]
# }

# Example 6: Run command with error checking
# BEGIN {
#     cmd = "ls /nonexistent 2>&1"
#     while ((cmd | getline line) > 0) {
#         print "Output:", line
#     }
#     status = close(cmd)
#     if (status != 0) {
#         print "Command failed with status:", status
#         exit 1
#     }
# }

# Example 7: Pipe output to external command
# {
#     # Send all lines to sort command
#     print | "sort"
# }
# END {
#     close("sort")
# }

# Example 8: Create temporary files with process ID
# BEGIN {
#     tmpfile = "/tmp/awk_temp_" PROCINFO["pid"] ".txt"
#     print "Creating:", tmpfile
#     print "data" > tmpfile
#     close(tmpfile)
# }

# Example 9: Execute shell command with variables
# BEGIN {
#     dir = "/tmp"
#     file = "test.txt"
#     cmd = sprintf("ls -l %s/%s 2>/dev/null", dir, file)
#     if (system(cmd) != 0) {
#         print "File not found"
#     }
# }

# Example 10: Get command output into variable
# BEGIN {
#     # Single line output
#     "date +%Y-%m-%d" | getline today
#     close("date +%Y-%m-%d")
#     print "Today:", today
#
#     # Multiple line output into array
#     i = 0
#     while (("ls -1" | getline file) > 0) {
#         files[++i] = file
#     }
#     close("ls -1")
#     print "Found", i, "files"
# }

# Example 11: Conditional exit based on data
# /ERROR/ {
#     print "Error found on line", NR ":", $0
#     error_count++
# }
# END {
#     if (error_count > 0) {
#         print "Total errors:", error_count
#         exit 1  # Non-zero exit code indicates failure
#     }
#     print "No errors found"
#     exit 0
# }

# Example 12: Use environment to configure behavior
# BEGIN {
#     # Check debug mode from environment
#     DEBUG = ("DEBUG" in ENVIRON) && ENVIRON["DEBUG"] == "1"
#
#     if (DEBUG) print "Debug mode enabled"
# }
# {
#     if (DEBUG) print "Processing:", $0
#     # ... normal processing ...
# }

# ============================================================================
# PROCESSING COMMAND OUTPUT LINE-BY-LINE
# ============================================================================

# Example 13: Shell-level piping (preferred method)
# The most common and efficient way to process command output is to pipe
# the command's output directly to awk at the shell level (not in awk):
#
# $ ls -la | awk '{print "File:", $9}'
# $ ps aux | awk '$3 > 50 {print $2, $11}'
# $ git log --oneline | awk '{print NR, $0}'
#
# This approach:
# - Is simple and efficient
# - Uses awk's standard input processing
# - Allows full use of awk's pattern-action model
# - Is the recommended approach for most use cases

# Example 14: Process command output in BEGIN block
# If you need to run a command from within awk and process its output,
# use getline in a loop within BEGIN or END blocks:
# BEGIN {
#     print "Files modified today:"
#     cmd = "find . -mtime 0 -type f"
#     while ((cmd | getline file) > 0) {
#         print "  -", file
#     }
#     close(cmd)
# }

# Example 15: Store command output for processing with input
# Run command once in BEGIN, store results, then process with input:
# BEGIN {
#     # Get list of all users
#     i = 0
#     while (("cut -d: -f1 /etc/passwd" | getline user) > 0) {
#         users[++i] = user
#     }
#     close("cut -d: -f1 /etc/passwd")
#     print "Found", i, "users"
# }
# {
#     # Now process input file and check against users list
#     for (u = 1; u <= i; u++) {
#         if ($1 == users[u]) {
#             print $0, "- valid user"
#             next
#         }
#     }
#     print $0, "- unknown user"
# }

# Example 16: Store in associative array for fast lookup
# BEGIN {
#     # Build lookup table from command output
#     while (("ls /tmp" | getline fname) > 0) {
#         tmp_files[fname] = 1
#     }
#     close("ls /tmp")
# }
# {
#     # Check if filename in field 1 exists in /tmp
#     if ($1 in tmp_files) {
#         print $1, "exists in /tmp"
#     } else {
#         print $1, "not found in /tmp"
#     }
# }

# Example 17: Run command per input line (use with caution)
# You CAN run commands in main {} blocks, but be aware of performance:
# {
#     # Run a command for each input line (SLOW for many lines!)
#     cmd = "file -b " $1
#     cmd | getline filetype
#     close(cmd)
#     print $1 ":", filetype
# }
#
# Better approach - collect filenames, process once in END:
# {
#     files[NR] = $1
# }
# END {
#     for (i = 1; i <= NR; i++) {
#         cmd = "file -b " files[i]
#         cmd | getline filetype
#         close(cmd)
#         print files[i] ":", filetype
#     }
# }

# Example 18: Combine multiple command outputs
# BEGIN {
#     # Get current user
#     "whoami" | getline current_user
#     close("whoami")
#
#     # Get current directory
#     "pwd" | getline current_dir
#     close("pwd")
#
#     # Get current date
#     "date +%Y-%m-%d" | getline today
#     close("date +%Y-%m-%d")
#
#     print "Report for", current_user
#     print "Directory:", current_dir
#     print "Date:", today
#     print "---"
# }
# {
#     # Process input with context from commands
#     print $0
# }

# Example 19: Dynamic command based on input (advanced)
# {
#     # Build command based on input field
#     if ($1 == "git") {
#         cmd = "git status --short"
#     } else if ($1 == "disk") {
#         cmd = "df -h ."
#     } else {
#         next
#     }
#
#     print "Output of", $1, "command:"
#     while ((cmd | getline line) > 0) {
#         print "  ", line
#     }
#     close(cmd)
# }

# Example 20: Error handling for command execution
# BEGIN {
#     cmd = "ls /nonexistent/directory 2>&1"
#     has_output = 0
#
#     while ((cmd | getline line) > 0) {
#         print "Output:", line
#         has_output = 1
#     }
#
#     exit_status = close(cmd)
#     if (exit_status != 0) {
#         print "Command failed with exit status:", exit_status
#         if (!has_output) {
#             print "No output produced"
#         }
#     }
# }

# Important Notes about Processing Command Output:
# 1. Shell piping (command | awk) is usually better than awk running commands
# 2. Running commands in {} blocks is inefficient - prefer BEGIN/END
# 3. Always close() command pipes to prevent resource leaks
# 4. Check close() return value to detect command failures
# 5. Use 2>&1 to capture stderr, or 2>/dev/null to suppress it
# 6. Be very careful with shell injection - sanitize any user input
# 7. Each getline reads one line - use while loops for multiple lines
# 8. Command pipes are opened once and persist until close()
# 9. Cannot use pattern-action syntax with command pipes directly
# 10. For heavy command usage, consider shell scripts instead of awk

# Important Notes:
# 1. system() returns exit status (0 = success, non-zero = error/signal)
# 2. Always close() pipes to avoid resource leaks
# 3. Check return value of close() on pipes to get command exit status
# 4. getline returns: 1 (success), 0 (EOF), -1 (error)
# 5. Use 2>&1 or 2>/dev/null in commands to handle stderr
# 6. ENVIRON is read-only; you cannot set environment variables
# 7. PROCINFO is gawk-specific, not POSIX-portable
# 8. exit runs END blocks; use exit inside END to skip remaining END code
# 9. Be careful with shell injection - validate/sanitize user input
# 10. Quote file paths in shell commands if they contain spaces

# ============================================================================
# BIT MANIPULATION FUNCTIONS (gawk only)
# ============================================================================

# and(v1, v2 [, ...])
# Bitwise AND
# Returns: bitwise AND of all arguments
# Example: and(12, 10)  # returns 8 (1100 & 1010 = 1000)

# or(v1, v2 [, ...])
# Bitwise OR
# Returns: bitwise OR of all arguments
# Example: or(12, 10)  # returns 14 (1100 | 1010 = 1110)

# xor(v1, v2 [, ...])
# Bitwise XOR
# Returns: bitwise XOR of all arguments
# Example: xor(12, 10)  # returns 6 (1100 ^ 1010 = 0110)

# compl(val)
# Bitwise complement (NOT)
# Returns: bitwise complement
# Example: compl(0)  # returns -1 (all bits set)

# lshift(val, count)
# Left shift
# Returns: val << count
# Example: lshift(1, 3)  # returns 8

# rshift(val, count)
# Right shift
# Returns: val >> count
# Example: rshift(8, 2)  # returns 2

# ============================================================================
# TYPE FUNCTIONS (gawk only)
# ============================================================================

# isarray(x)
# Check if x is an array
# Returns: 1 if array, 0 otherwise
# Example: if (isarray(arr)) print "is array"

# typeof(x)
# Get type of variable
# Returns: "array", "number", "string", "strnum", or "untyped"
# Example: typeof(x)

# ============================================================================
# BUILT-IN VARIABLES
# ============================================================================

# ============================================================================
# FIELD AND RECORD VARIABLES
# ============================================================================

# $0
# The entire current input record (line)
# Modifying $0 recalculates $1, $2, ... $NF
# Example: { print $0 }  # prints entire line
# Example: { $0 = toupper($0); print }  # convert line to uppercase

# $1, $2, $3, ... $NF
# Individual fields in current record
# Fields are split based on FS (field separator)
# Fields are 1-indexed (not 0-indexed!)
# Example: { print $1, $3 }  # print first and third fields
# Example: { $2 = "CHANGED"; print }  # modify second field

# NF (Number of Fields)
# Count of fields in current record
# Can be modified to add/remove fields
# $NF is the last field
# Example: { print NF }  # print field count
# Example: { print $NF }  # print last field
# Example: { print $(NF-1) }  # print second-to-last field
# Example: { NF = 3 }  # truncate to first 3 fields

# NR (Number of Records)
# Total number of input records read so far across all files
# Increments for each line read
# Example: { print NR, $0 }  # number all lines
# Example: NR == 5 { print }  # print only line 5
# Example: END { print "Total lines:", NR }

# FNR (File Number of Records)
# Number of records read in current file
# Resets to 1 for each new input file
# Example: FNR == 1 { print "File:", FILENAME }  # print filename header
# Example: { print FILENAME ":" FNR ":", $0 }  # file:line: content

# FILENAME
# Name of current input file being processed
# Empty or "-" when reading from stdin
# Example: { print FILENAME, NR, $0 }
# Example: FILENAME ~ /\.log$/ { process_log() }

# ============================================================================
# SEPARATOR VARIABLES
# ============================================================================

# FS (Field Separator)
# Input field separator (regex or string)
# Default: whitespace (space and tab)
# Can be set in BEGIN block or via -F command line option
# Example: BEGIN { FS = ":" }  # split on colon
# Example: BEGIN { FS = "[ \t]+" }  # split on whitespace (explicit regex)
# Example: BEGIN { FS = "," }  # CSV parsing
# Example: awk -F: '{print $1}' /etc/passwd

# RS (Record Separator)
# Input record separator (regex or string)
# Default: newline ("\n")
# Set to "" for paragraph mode (blank line separated)
# Example: BEGIN { RS = "\n\n" }  # paragraph mode
# Example: BEGIN { RS = ";" }  # records end with semicolon
# Example: BEGIN { RS = "\0" }  # null-terminated records

# OFS (Output Field Separator)
# Output field separator when printing multiple fields
# Default: single space (" ")
# Used in print statements when comma-separated values
# Example: BEGIN { OFS = "," }  # CSV output
# Example: BEGIN { OFS = " | " }  # pipe-separated output
# Example: { print $1, $2, $3 }  # fields separated by OFS

# ORS (Output Record Separator)
# Output record separator appended to print statements
# Default: newline ("\n")
# Example: BEGIN { ORS = "\n\n" }  # double-space output
# Example: BEGIN { ORS = "" }  # no newline after print
# Example: BEGIN { ORS = ";\n" }  # end each line with semicolon

# SUBSEP (Subscript Separator)
# Multi-dimensional array subscript separator
# Default: "\034" (ASCII 28 decimal, 034 octal - non-printing char)
# Used internally for arr[i,j] which becomes arr[i SUBSEP j]
# Example: BEGIN { SUBSEP = ":" }  # use colon as separator
# Example: arr[1,2] = "val"  # stored as arr["1\0342"]
# See MULTI-DIMENSIONAL ARRAYS section for details

# ============================================================================
# PATTERN MATCHING VARIABLES
# ============================================================================

# RSTART
# Start position of substring matched by match()
# 0 if no match found
# 1-indexed (first character is position 1)
# Example: { if (match($0, /[0-9]+/)) print "Found at:", RSTART }

# RLENGTH
# Length of substring matched by match()
# -1 if no match found
# Example: {
#     if (match($0, /[0-9]+/)) {
#         num = substr($0, RSTART, RLENGTH)
#         print "Number:", num
#     }
# }

# RT (Record Terminator) - gawk only
# Actual text that matched RS (record separator)
# Useful when RS is a regex
# Example: BEGIN { RS = "[,;\n]" }
# { print "Record:", $0, "Terminated by:", RT }

# IGNORECASE - gawk only
# If non-zero, pattern matching is case-insensitive
# Affects regex matching, string comparison, field splitting
# Example: BEGIN { IGNORECASE = 1 }
# /error/ { print }  # matches "error", "ERROR", "Error", etc.

# ============================================================================
# COMMAND LINE ARGUMENT VARIABLES
# ============================================================================

# ARGC
# Number of command-line arguments (including program name)
# Count of elements in ARGV array
# Example: BEGIN { print "Argument count:", ARGC }

# ARGV
# Array of command-line arguments (0-indexed)
# ARGV[0] is "awk"
# ARGV[1], ARGV[2], ... are input files or arguments
# You can modify ARGV to change which files are processed
# Example: BEGIN { for (i = 0; i < ARGC; i++) print ARGV[i] }
# Example: BEGIN { ARGV[1] = "newfile.txt" }  # change input file

# ARGIND - gawk only
# Index in ARGV of current file being processed
# Example: { print "Processing ARGV[" ARGIND "]:", FILENAME }

# ============================================================================
# FORMATTING VARIABLES
# ============================================================================

# OFMT (Output Format)
# Format for printing numbers with print statement
# Default: "%.6g" (6 significant digits)
# Example: BEGIN { OFMT = "%.2f" }  # 2 decimal places
# Example: { x = 1/3; print x }  # prints 0.33 with OFMT="%.2f"

# CONVFMT (Conversion Format)
# Format for converting numbers to strings internally
# Default: "%.6g"
# Used when concatenating numbers with strings
# Example: BEGIN { CONVFMT = "%.2f" }
# Example: { x = 1/3; s = "value: " x }  # converts x to string

# ============================================================================
# FIELD PARSING VARIABLES (gawk only)
# ============================================================================

# FIELDWIDTHS
# Fixed-width field parsing (alternative to FS)
# Space-separated list of field widths
# Example: BEGIN { FIELDWIDTHS = "3 5 2" }  # first field 3 chars, second 5 chars, etc.
# Example: Data "ABCDEFGHIJ" becomes $1="ABC", $2="DEFGH", $3="IJ"

# FPAT (Field Pattern)
# Define fields by pattern (what fields ARE, not what separates them)
# Alternative to FS (useful for CSV with quoted fields)
# Example: BEGIN { FPAT = "([^,]+)|(\"[^\"]+\")" }  # CSV with quotes
# Example: Data: a,"b,c",d becomes $1="a", $2="\"b,c\"", $3="d"

# ============================================================================
# ERROR HANDLING VARIABLES (gawk only)
# ============================================================================

# ERRNO
# Error string from last failed I/O operation
# Set by getline, close, system calls
# Example: {
#     if ((getline line < "file.txt") < 0) {
#         print "Error:", ERRNO
#     }
# }

# ============================================================================
# ADVANCED gawk VARIABLES
# ============================================================================

# BINMODE - gawk only (Windows)
# Binary mode for I/O operations
# 0 = text mode (default)
# 1 = binary mode for stdin/stdout
# 2 = binary mode for stdin/stdout/stderr
# 3 = binary mode for all files
# Example: BEGIN { BINMODE = 1 }  # Windows binary mode

# LINT - gawk only
# Controls lint warning level
# 0 = no warnings
# 1 = enable warnings
# 2 = fatal warnings
# Example: BEGIN { LINT = 0 }  # disable lint warnings

# PREC - gawk only
# Precision for arbitrary-precision arithmetic
# Number of significant digits
# Example: BEGIN { PREC = 100 }  # 100-digit precision

# ROUNDMODE - gawk only
# Rounding mode for arbitrary-precision arithmetic
# "N" = round to nearest (default)
# "U" = round up
# "D" = round down
# "Z" = round toward zero
# Example: BEGIN { ROUNDMODE = "U" }

# PROCINFO - gawk only
# Array containing process information
# See SYSTEM INTERACTION FUNCTIONS section for details

# FUNCTAB - gawk only
# Array of function names
# Keys are function names, values are internal function objects
# Example: BEGIN { for (f in FUNCTAB) print "Function:", f }

# SYMTAB - gawk only
# Symbol table array
# Contains all global variables and arrays
# Example: BEGIN { for (s in SYMTAB) print "Symbol:", s }

# TEXTDOMAIN - gawk only
# Text domain for internationalization (i18n)
# Used with gettext for translating messages
# Example: BEGIN { TEXTDOMAIN = "myapp" }

# ============================================================================
# BUILT-IN VARIABLE EXAMPLES
# ============================================================================

# Example 1: Number lines in multiple files (like cat -n)
# { print NR ":", $0 }

# Example 2: Number lines per file (reset for each file)
# { print FILENAME ":" FNR ":", $0 }

# Example 3: Print only last field
# { print $NF }

# Example 4: Print all but first field
# { $1 = ""; print }  # or { for (i=2; i<=NF; i++) printf "%s ", $i; print "" }

# Example 5: CSV to TSV converter
# BEGIN { FS = ","; OFS = "\t" }
# { print }  # or { $1=$1; print } to force reformatting

# Example 6: Process only specific files
# BEGIN {
#     # Remove files from ARGV we don't want to process
#     for (i = 1; i < ARGC; i++) {
#         if (ARGV[i] ~ /\.bak$/) {
#             delete ARGV[i]
#         }
#     }
# }

# Example 7: Extract matched substring
# {
#     if (match($0, /[0-9]{3}-[0-9]{4}/)) {
#         phone = substr($0, RSTART, RLENGTH)
#         print "Phone:", phone
#     }
# }

# Example 8: Paragraph mode (blank line separated records)
# BEGIN { RS = ""; FS = "\n" }
# { print "Paragraph", NR, "has", NF, "lines" }

# Example 9: Fixed-width field parsing
# BEGIN { FIELDWIDTHS = "10 15 5" }
# { print "Name:", $1, "Address:", $2, "Age:", $3 }

# Example 10: Case-insensitive matching (gawk)
# BEGIN { IGNORECASE = 1 }
# /error/ { print }  # matches ERROR, error, Error, etc.

# Example 11: Custom multi-dimensional array separator
# BEGIN { SUBSEP = "::" }
# {
#     count[$1, $2]++
# }
# END {
#     for (key in count) {
#         split(key, parts, SUBSEP)
#         print parts[1], parts[2], count[key]
#     }
# }

# Example 12: Format numbers in output
# BEGIN { OFMT = "%.2f" }
# { total += $1 }
# END { print "Total:", total }  # prints with 2 decimal places

# Important Notes:
# 1. Field variables ($1, $2, etc.) are 1-indexed, not 0-indexed
# 2. $0 is special - modifying it recalculates all field variables
# 3. NF can be modified to add/remove fields
# 4. $NF always refers to last field (even if NF changes)
# 5. Modifying fields changes $0 automatically
# 6. FS can be a string or regex, RS can be string or regex (gawk)
# 7. Set separators in BEGIN block before processing input
# 8. FILENAME is empty when reading from stdin
# 9. ARGV elements can be modified/deleted to control input files
# 10. Many advanced variables (FPAT, FIELDWIDTHS, PROCINFO, etc.) are gawk-only

# ============================================================================
# MULTI-DIMENSIONAL ARRAYS (Emulating Nested Arrays)
# ============================================================================

# AWK does not have true nested/multi-dimensional arrays, but emulates them
# using a special separator character (SUBSEP) to concatenate array indices.

# SUBSEP (Subscript Separator)
# Default: "\034" (ASCII 034 octal = ASCII 28 decimal)
# This is a non-printing character used to separate multi-dimensional indices

# Creating multi-dimensional arrays:
# arr[i, j] = value
# Internally stored as: arr[i SUBSEP j] = value

# Example 1: Basic 2D array
# BEGIN {
#     matrix[1, 1] = "a"
#     matrix[1, 2] = "b"
#     matrix[2, 1] = "c"
#     matrix[2, 2] = "d"
#
#     print matrix[1, 2]  # prints "b"
# }

# Example 2: 3D array (or more dimensions)
# BEGIN {
#     cube[1, 2, 3] = "value"
#     print cube[1, 2, 3]  # prints "value"
# }

# Example 3: Iterating over multi-dimensional arrays
# BEGIN {
#     arr[1, "a"] = 10
#     arr[1, "b"] = 20
#     arr[2, "a"] = 30
#     arr[2, "b"] = 40
#
#     for (key in arr) {
#         print key, "=", arr[key]
#         # Output will show combined keys like "1\034a = 10"
#     }
# }

# Example 4: Splitting composite keys to extract individual indices
# BEGIN {
#     # Create multi-dimensional array
#     data[1, "name"] = "Alice"
#     data[1, "age"] = 30
#     data[2, "name"] = "Bob"
#     data[2, "age"] = 25
#
#     # Iterate and split keys
#     for (composite_key in data) {
#         # Split the composite key using SUBSEP
#         n = split(composite_key, indices, SUBSEP)
#
#         id = indices[1]
#         field = indices[2]
#         value = data[composite_key]
#
#         printf "ID: %s, Field: %s, Value: %s\n", id, field, value
#     }
# }

# Example 5: Using custom separator (instead of SUBSEP)
# BEGIN {
#     # You can use your own separator, but you must concatenate manually
#     sep = ":"
#
#     # Manual concatenation
#     key = 1 sep "name"
#     data[key] = "Charlie"
#
#     key = 2 sep "age"
#     data[key] = 35
#
#     # Split them back
#     for (k in data) {
#         split(k, parts, sep)
#         print "Index 1:", parts[1], "Index 2:", parts[2], "Value:", data[k]
#     }
# }

# Example 6: Testing if multi-dimensional key exists
# BEGIN {
#     arr[1, 2] = "exists"
#
#     # Method 1: Direct check
#     if ((1, 2) in arr) {
#         print "Found!"
#     }
#
#     # Method 2: Using SUBSEP explicitly
#     key = 1 SUBSEP 2
#     if (key in arr) {
#         print "Found!"
#     }
# }

# Example 7: Building nested data structures (tree-like)
# BEGIN {
#     # Simulate a tree: tree[parent, child] = value
#     tree["root", "child1"] = "leaf1"
#     tree["root", "child2"] = "leaf2"
#     tree["child1", "grandchild1"] = "leaf3"
#     tree["child1", "grandchild2"] = "leaf4"
#
#     # Query all children of "root"
#     for (key in tree) {
#         split(key, parts, SUBSEP)
#         if (parts[1] == "root") {
#             printf "Root has child: %s with value: %s\n", parts[2], tree[key]
#         }
#     }
# }

# Example 8: Matrix operations with 2D arrays
# BEGIN {
#     # Create a 3x3 matrix
#     for (i = 1; i <= 3; i++) {
#         for (j = 1; j <= 3; j++) {
#             matrix[i, j] = i * j
#         }
#     }
#
#     # Print matrix
#     for (i = 1; i <= 3; i++) {
#         for (j = 1; j <= 3; j++) {
#             printf "%3d ", matrix[i, j]
#         }
#         print ""
#     }
# }

# Important Notes:
# 1. SUBSEP is "\034" by default (ASCII 034 octal = 28 decimal, non-printing char)
# 2. You can change SUBSEP: BEGIN { SUBSEP = ":" }
# 3. Multi-dimensional syntax arr[i, j] is syntactic sugar for arr[i SUBSEP j]
# 4. Use split(key, array, SUBSEP) to extract individual indices
# 5. The "in" operator works with multi-dimensional keys: if ((i, j) in arr)
# 6. gawk supports true multi-dimensional arrays, but for portability use SUBSEP method

# ============================================================================
# USER-DEFINED FUNCTIONS
# ============================================================================

# AWK allows you to define your own functions for code reuse and organization

# Function Syntax:
# function name(parameter1, parameter2, ..., parameterN) {
#     # function body
#     return value  # optional
# }

# Important Rules:
# 1. Functions must be defined before they are called (typically at top of script)
# 2. Parameters are passed by value for scalars
# 3. Arrays are passed by reference (modifications affect original)
# 4. Local variables are declared as extra parameters
# 5. No return statement means function returns empty string ""
# 6. Functions can call other functions (including recursively)
# 7. Function names share namespace with variables

# Example 1: Simple function with return value
# function square(n) {
#     return n * n
# }
# BEGIN {
#     print square(5)  # prints 25
# }

# Example 2: Function with local variables
# Use extra parameters for local variables (convention: separate with extra spaces)
# function sum_range(start, end,    i, total) {
#     total = 0
#     for (i = start; i <= end; i++) {
#         total += i
#     }
#     return total
# }
# BEGIN {
#     print sum_range(1, 10)  # prints 55
# }

# Example 3: Function that modifies an array (passed by reference)
# function init_array(arr, size,    i) {
#     for (i = 1; i <= size; i++) {
#         arr[i] = i * i
#     }
# }
# BEGIN {
#     init_array(numbers, 5)
#     for (i = 1; i <= 5; i++) {
#         print numbers[i]  # prints 1, 4, 9, 16, 25
#     }
# }

# Example 4: Recursive function
# function factorial(n) {
#     if (n <= 1) return 1
#     return n * factorial(n - 1)
# }
# BEGIN {
#     print factorial(5)  # prints 120
# }

# ============================================================================
# GAWK FUNCTION EXTENSIONS
# ============================================================================

# gawk supports indirect function calls using @
# Useful for callbacks, function dispatch, and dynamic function selection

# Example 5: Indirect function call (gawk only)
# function greet(name) {
#     print "Hello,", name
# }
#
# BEGIN {
#     func = "greet"
#     @func("World")  # calls greet("World")
# }

# Example 6: Function dispatch table (gawk only)
# function add(a, b) { return a + b }
# function mul(a, b) { return a * b }
#
# BEGIN {
#     ops["+"] = "add"
#     ops["*"] = "mul"
#     result = @ops["*"](5, 3)  # calls mul(5, 3)
#     print result  # prints 15
# }

# Example 7: Using @include to load libraries (gawk only)
# @include "mylib.awk"
#
# BEGIN {
#     result = mylib_function()
# }

# Important Notes about Functions:
# 1. Scalars are passed by value (copy), arrays by reference
# 2. To create local variables, add them as extra parameters after actual parameters
# 3. Convention: separate actual params from local vars with extra whitespace
# 4. Functions can access global variables directly
# 5. No function overloading - each function name must be unique
# 6. Recursive functions work but watch for stack depth
# 7. Return value can be any type (number, string, not array directly)
# 8. If no return statement, function returns empty string ""
# 9. Indirect calls (@func) are gawk-specific, not POSIX
# 10. FUNCTAB array contains all defined function names (gawk only)

END {
	print ""
	print "=== END REFERENCE ==="
}
