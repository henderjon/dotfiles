#!/usr/bin/gawk -f
# GNU AWK (gawk) Extensions Reference
# This file documents gawk-specific features not available in POSIX AWK
# For standard POSIX AWK features, see awk-posix-reference.awk

BEGIN {
	print "=== GNU AWK (GAWK) EXTENSIONS REFERENCE ==="
	print "Features specific to GNU AWK (not portable to other AWK implementations)"
	print ""
}

# ============================================================================
# STRING FUNCTIONS (gawk extensions)
# ============================================================================

# gensub(regexp, replacement, how [, target])
# General substitution function with more control
# how: "g" or "G" for global, or number for nth occurrence
# Returns: modified string (doesn't modify original)
# Note: Unlike sub/gsub, this returns a new string
# Example: new = gensub(/foo/, "bar", "g", str)
# Example: new = gensub(/([0-9]+)/, "[\\1]", 1)  # replace first match with brackets

# patsplit(string, array [, fieldpat [, seps]])
# Split string into array based on pattern matches (not separators)
# fieldpat: pattern that defines what fields ARE (not what separates them)
# seps: optional array to store separators
# Returns: number of elements
# Example: patsplit("abc123def456", arr, /[0-9]+/)  # arr[1]="123", arr[2]="456"
# Example: patsplit("foo:bar::baz", arr, /[^:]+/, seps)  # extracts non-colon parts

# strtonum(string)
# Convert string to number (handles hex 0x, octal 0)
# Returns: numeric value
# Example: strtonum("0xFF")  # returns 255
# Example: strtonum("077")   # returns 63 (octal)
# Example: strtonum("42")    # returns 42 (decimal)

# asort(source [, dest [, how]])
# Sort array by values
# dest: destination array (if omitted, sorts in place)
# how: sort method ("@ind_num_asc", "@val_str_asc", etc.)
# Returns: number of elements
# Example: n = asort(arr, sorted)
# Example: asort(arr, sorted, "@val_num_desc")  # sort by numeric value descending

# asorti(source [, dest [, how]])
# Sort array by indices (keys)
# dest: destination array (if omitted, sorts in place)
# Returns: number of elements
# Example: n = asorti(arr, sorted)
# Example: asorti(arr, sorted, "@ind_str_asc")  # sort by string index ascending

# ============================================================================
# TIME FUNCTIONS (gawk only)
# ============================================================================

# mktime(datespec)
# Convert datespec to timestamp
# datespec: "YYYY MM DD HH MM SS [DST]"
# Returns: seconds since epoch
# Example: mktime("2025 12 19 10 30 0")
# Example: timestamp = mktime("2025 1 1 0 0 0")

# strftime([format [, timestamp [, utc-flag]]])
# Format timestamp as string
# format: strftime format string (default "%a %b %d %H:%M:%S %Z %Y")
# timestamp: seconds since epoch (default current time)
# utc-flag: if non-zero, use UTC instead of local time
# Returns: formatted date/time string
# Example: strftime("%Y-%m-%d", systime())
# Example: strftime("%Y-%m-%d %H:%M:%S", mktime("2025 12 19 10 30 0"))

# systime()
# Get current time
# Returns: seconds since epoch (Unix timestamp)
# Example: now = systime()
# Example: print "Current timestamp:", systime()

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
# Example: compl(255)  # returns -256

# lshift(val, count)
# Left shift
# Returns: val << count
# Example: lshift(1, 3)  # returns 8 (0001 << 3 = 1000)
# Example: lshift(5, 2)  # returns 20 (0101 << 2 = 10100)

# rshift(val, count)
# Right shift
# Returns: val >> count
# Example: rshift(8, 2)  # returns 2 (1000 >> 2 = 0010)
# Example: rshift(20, 2)  # returns 5 (10100 >> 2 = 0101)

# ============================================================================
# TYPE FUNCTIONS (gawk only)
# ============================================================================

# isarray(x)
# Check if x is an array
# Returns: 1 if array, 0 otherwise
# Example: if (isarray(arr)) print "is array"
# Example: if (!isarray(var)) var = 0  # initialize scalar

# typeof(x)
# Get type of variable
# Returns: "array", "number", "string", "strnum", or "untyped"
# Example: print typeof(x)
# Example: if (typeof(x) == "array") print "x is an array"

# ============================================================================
# CONTROL FLOW (gawk extensions)
# ============================================================================

# nextfile
# Stop processing current file and move to next file
# Skips remaining lines in current input file
# Example: /SKIP_FILE/ { nextfile }
# Example: FNR == 1 && /^#IGNORE/ { nextfile }  # skip files starting with #IGNORE

# ============================================================================
# GAWK-SPECIFIC VARIABLES
# ============================================================================

# ============================================================================
# PATTERN MATCHING VARIABLES
# ============================================================================

# RT (Record Terminator)
# Actual text that matched RS (record separator)
# Useful when RS is a regex
# Example: BEGIN { RS = "[,;\n]" }
# { print "Record:", $0, "Terminated by:", RT }

# IGNORECASE
# If non-zero, pattern matching is case-insensitive
# Affects regex matching, string comparison, field splitting
# Example: BEGIN { IGNORECASE = 1 }
# /error/ { print }  # matches "error", "ERROR", "Error", etc.

# ============================================================================
# COMMAND LINE ARGUMENT VARIABLES
# ============================================================================

# ARGIND
# Index in ARGV of current file being processed
# Example: { print "Processing ARGV[" ARGIND "]:", FILENAME }

# ============================================================================
# FIELD PARSING VARIABLES
# ============================================================================

# FIELDWIDTHS
# Fixed-width field parsing (alternative to FS)
# Space-separated list of field widths
# Example: BEGIN { FIELDWIDTHS = "3 5 2" }
# Example: Data "ABCDEFGHIJ" becomes $1="ABC", $2="DEFGH", $3="IJ"

# FPAT (Field Pattern)
# Define fields by pattern (what fields ARE, not what separates them)
# Alternative to FS (useful for CSV with quoted fields)
# Example: BEGIN { FPAT = "([^,]+)|(\"[^\"]+\")" }  # CSV with quotes
# Example: Data: a,"b,c",d becomes $1="a", $2="\"b,c\"", $3="d"

# ============================================================================
# ERROR HANDLING VARIABLES
# ============================================================================

# ERRNO
# Error string from last failed I/O operation
# Set by getline, close, system calls
# Example:
# {
#     if ((getline line < "file.txt") < 0) {
#         print "Error:", ERRNO
#     }
# }

# ============================================================================
# PROCESS INFORMATION VARIABLES
# ============================================================================

# PROCINFO array
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
# Example: print "gawk version:", PROCINFO["version"]

# ============================================================================
# ADVANCED FORMATTING VARIABLES
# ============================================================================

# BINMODE (Windows only)
# Binary mode for I/O operations
# 0 = text mode (default)
# 1 = binary mode for stdin/stdout
# 2 = binary mode for stdin/stdout/stderr
# 3 = binary mode for all files
# Example: BEGIN { BINMODE = 1 }

# LINT
# Controls lint warning level
# 0 = no warnings
# 1 = enable warnings
# 2 = fatal warnings
# Example: BEGIN { LINT = 0 }  # disable lint warnings

# PREC
# Precision for arbitrary-precision arithmetic
# Number of significant digits
# Example: BEGIN { PREC = 100 }  # 100-digit precision

# ROUNDMODE
# Rounding mode for arbitrary-precision arithmetic
# "N" = round to nearest (default)
# "U" = round up
# "D" = round down
# "Z" = round toward zero
# Example: BEGIN { ROUNDMODE = "U" }

# ============================================================================
# INTROSPECTION VARIABLES
# ============================================================================

# FUNCTAB
# Array of function names
# Keys are function names, values are internal function objects
# Example: BEGIN { for (f in FUNCTAB) print "Function:", f }

# SYMTAB
# Symbol table array
# Contains all global variables and arrays
# Example: BEGIN { for (s in SYMTAB) print "Symbol:", s }
# Example: SYMTAB["myvar"] = 42  # create/modify global variable

# ============================================================================
# INTERNATIONALIZATION
# ============================================================================

# TEXTDOMAIN
# Text domain for internationalization (i18n)
# Used with gettext for translating messages
# Example: BEGIN { TEXTDOMAIN = "myapp" }

# ============================================================================
# GAWK EXTENSION EXAMPLES
# ============================================================================

# Example 1: Time and date operations
# BEGIN {
#     now = systime()
#     print "Current timestamp:", now
#     print "Formatted:", strftime("%Y-%m-%d %H:%M:%S", now)
#
#     future = mktime("2025 12 31 23 59 59")
#     print "New Year's Eve:", strftime("%A, %B %d, %Y", future)
# }

# Example 2: Using gensub for advanced replacements
# {
#     # Extract and reformat phone numbers
#     result = gensub(/([0-9]{3})-([0-9]{3})-([0-9]{4})/, "(\\1) \\2-\\3", "g")
#     print result
# }

# Example 3: Case-insensitive matching
# BEGIN { IGNORECASE = 1 }
# /error|warning|critical/ {
#     print "Issue found:", $0
# }

# Example 4: Fixed-width field parsing
# BEGIN { FIELDWIDTHS = "10 15 5 20" }
# {
#     print "Name:", $1
#     print "Address:", $2
#     print "Age:", $3
#     print "Email:", $4
# }

# Example 5: CSV with quoted fields using FPAT
# BEGIN {
#     FPAT = "([^,]+)|(\"[^\"]+\")"
#     OFS = "|"
# }
# { print }

# Example 6: Process information
# BEGIN {
#     print "Process ID:", PROCINFO["pid"]
#     print "User ID:", PROCINFO["uid"]
#     print "gawk version:", PROCINFO["version"]
#
#     # Create temp file with PID
#     tmpfile = "/tmp/gawk_" PROCINFO["pid"] ".tmp"
#     print "data" > tmpfile
#     close(tmpfile)
# }

# Example 7: Bit manipulation for flags
# BEGIN {
#     READ = 1    # 0001
#     WRITE = 2   # 0010
#     EXEC = 4    # 0100
#
#     perms = or(READ, WRITE)  # 0011 = 3
#     print "Read+Write:", perms
#
#     if (and(perms, WRITE)) {
#         print "Write permission enabled"
#     }
# }

# Example 8: Type checking
# BEGIN {
#     scalar = 42
#     split("a b c", arr)
#
#     print typeof(scalar)  # "number"
#     print typeof(arr)     # "array"
#
#     if (isarray(arr)) {
#         print "arr is an array with", length(arr), "elements"
#     }
# }

# Example 9: Extracting numeric strings
# {
#     # Extract all numbers from line
#     patsplit($0, numbers, /[0-9]+/)
#     for (i = 1; i <= length(numbers); i++) {
#         print "Number", i ":", numbers[i]
#     }
# }

# Example 10: Skip files conditionally
# FNR == 1 {
#     if (FILENAME ~ /\.bak$/) {
#         print "Skipping backup file:", FILENAME
#         nextfile
#     }
# }

# Example 11: Sorting arrays
# END {
#     # Create array of counts
#     data["apple"] = 5
#     data["banana"] = 3
#     data["cherry"] = 8
#
#     # Sort by value (count)
#     n = asorti(data, sorted, "@val_num_desc")
#
#     print "Sorted by count:"
#     for (i = 1; i <= n; i++) {
#         key = sorted[i]
#         print key ":", data[key]
#     }
# }

# Example 12: Error handling with ERRNO
# {
#     file = $1
#     if ((getline line < file) < 0) {
#         print "Cannot read", file ":", ERRNO > "/dev/stderr"
#         next
#     }
#     close(file)
#     print file, "first line:", line
# }

# ============================================================================
# USER-DEFINED FUNCTIONS (gawk extensions)
# ============================================================================

# gawk extends POSIX AWK function capabilities with additional features
# For basic function syntax, see awk-posix-reference.awk

# ============================================================================
# INDIRECT FUNCTION CALLS
# ============================================================================

# gawk allows calling functions indirectly using @
# Useful for callbacks, function dispatch, and dynamic function selection

# Syntax: @function_name(args)
# The function name is stored in a variable and called at runtime

# Example 1: Simple indirect call
# function greet(name) {
#     print "Hello,", name
# }
#
# BEGIN {
#     func = "greet"
#     @func("World")  # calls greet("World")
# }

# Example 2: Function dispatch table
# function add(a, b) { return a + b }
# function sub(a, b) { return a - b }
# function mul(a, b) { return a * b }
# function div(a, b) { return b != 0 ? a / b : "ERROR" }
#
# BEGIN {
#     ops["+"] = "add"
#     ops["-"] = "sub"
#     ops["*"] = "mul"
#     ops["/"] = "div"
#
#     result = @ops["*"](5, 3)  # calls mul(5, 3)
#     print result  # prints 15
# }

# Example 3: Callback functions for processing
# function process_data(arr, callback,    i) {
#     for (i in arr) {
#         arr[i] = @callback(arr[i])
#     }
# }
#
# function double(x) { return x * 2 }
# function square(x) { return x * x }
#
# BEGIN {
#     data[1] = 5
#     data[2] = 10
#     process_data(data, "square")
#     for (i in data) print data[i]  # prints 25, 100
# }

# ============================================================================
# FUNCTION NAMESPACES (gawk 5.0+)
# ============================================================================

# gawk 5.0+ supports namespaces to organize functions and variables
# Syntax: @namespace "name"

# Example: Using namespaces
# @namespace "math"
#
# function add(a, b) {
#     return a + b
# }
#
# @namespace "awk"  # return to default namespace
#
# BEGIN {
#     result = math::add(5, 3)
#     print result  # prints 8
# }

# ============================================================================
# FUNCTION-RELATED VARIABLES
# ============================================================================

# FUNCTAB array - contains all defined functions
# Keys are function names, values are internal function representations
# Useful for introspection and validation

# Example: List all available functions
# BEGIN {
#     print "Available functions:"
#     for (fname in FUNCTAB) {
#         print "  -", fname
#     }
# }

# Example: Check if function exists before calling
# BEGIN {
#     fname = "my_function"
#     if (fname in FUNCTAB) {
#         @fname(args)
#     } else {
#         print "Function", fname, "not found"
#     }
# }

# ============================================================================
# ADVANCED FUNCTION PATTERNS
# ============================================================================

# Example 4: Strategy pattern with indirect calls
# function sort_numeric(a, b) { return a - b }
# function sort_string(a, b) { return (a < b) ? -1 : (a > b) ? 1 : 0 }
# function sort_length(a, b) { return length(a) - length(b) }
#
# function sort_array(arr, strategy,    n, i, j, temp, swapped) {
#     n = length(arr)
#     do {
#         swapped = 0
#         for (i = 1; i < n; i++) {
#             if (@strategy(arr[i], arr[i+1]) > 0) {
#                 temp = arr[i]
#                 arr[i] = arr[i+1]
#                 arr[i+1] = temp
#                 swapped = 1
#             }
#         }
#     } while (swapped)
# }
#
# BEGIN {
#     data[1] = "apple"
#     data[2] = "pie"
#     data[3] = "banana"
#     sort_array(data, "sort_length")
#     for (i in data) print data[i]  # prints by length: "pie", "apple", "banana"
# }

# Example 5: Function composition
# function compose(f, g, x) {
#     return @f(@g(x))
# }
#
# function double(x) { return x * 2 }
# function increment(x) { return x + 1 }
#
# BEGIN {
#     # (double ∘ increment)(5) = double(increment(5)) = double(6) = 12
#     result = compose("double", "increment", 5)
#     print result  # prints 12
# }

# Example 6: Dynamic function selection based on data
# function handle_error(msg) { print "ERROR:", msg > "/dev/stderr" }
# function handle_warning(msg) { print "WARNING:", msg }
# function handle_info(msg) { print "INFO:", msg }
#
# {
#     level = $1
#     message = substr($0, index($0, $2))
#     handler = "handle_" tolower(level)
#
#     if (handler in FUNCTAB) {
#         @handler(message)
#     } else {
#         print "Unknown level:", level
#     }
# }

# Example 7: Memoization with functions
# function fib_impl(n) {
#     if (n <= 1) return n
#     return fib_impl(n-1) + fib_impl(n-2)
# }
#
# function fib(n,    key) {
#     key = "fib_" n
#     if (!(key in memo)) {
#         memo[key] = fib_impl(n)
#     }
#     return memo[key]
# }
#
# BEGIN {
#     for (i = 0; i <= 10; i++) {
#         print "fib(" i ") =", fib(i)
#     }
# }

# ============================================================================
# LIBRARY FUNCTIONS (gawk includes)
# ============================================================================

# gawk supports @include directive to load external AWK libraries
# Syntax: @include "filename.awk"

# Example: Creating a library file (mylib.awk)
# # mylib.awk
# function mylib_uppercase(str) {
#     return toupper(str)
# }
#
# function mylib_reverse(str,    i, result) {
#     result = ""
#     for (i = length(str); i >= 1; i--) {
#         result = result substr(str, i, 1)
#     }
#     return result
# }

# Using the library:
# @include "mylib.awk"
#
# BEGIN {
#     print mylib_uppercase("hello")  # prints HELLO
#     print mylib_reverse("hello")    # prints olleh
# }

# ============================================================================
# IMPORTANT NOTES
# ============================================================================

# Notes about gawk function extensions:
# 1. Indirect function calls (@func) are gawk-specific, not POSIX
# 2. Function must exist when @ is evaluated, or runtime error occurs
# 3. FUNCTAB includes both built-in and user-defined functions
# 4. Namespaces require gawk 5.0 or later
# 5. @include searches AWKPATH environment variable for files
# 6. Indirect calls have slight performance overhead
# 7. Use FUNCTAB to validate function existence before indirect call
# 8. Function composition enables functional programming patterns
# 9. Callbacks enable generic/reusable code
# 10. Library functions should use prefixes to avoid name collisions

# Important Notes:
# 1. gawk extensions are NOT portable to other AWK implementations
# 2. For portable code, use only POSIX AWK features
# 3. gensub() returns new string, unlike sub/gsub which modify in place
# 4. IGNORECASE affects all pattern matching globally
# 5. FIELDWIDTHS and FPAT are mutually exclusive with FS
# 6. RT is only set when RS is a regex
# 7. Time functions use Unix timestamps (seconds since 1970-01-01)
# 8. Bit functions work on integers, results may vary with floating point
# 9. PROCINFO contents may vary by platform
# 10. Use typeof() and isarray() for defensive programming

END {
	print ""
	print "=== END GAWK EXTENSIONS REFERENCE ==="
}
