#!/usr/bin/awk -f
# POSIX AWK Built-in Functions Reference
# This file documents standard POSIX AWK features (portable across all AWK implementations)
# For GNU AWK (gawk) extensions, see gawk-extensions-reference.awk

BEGIN {
	print "=== POSIX AWK REFERENCE ==="
	print "Standard features portable across all AWK implementations"
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

# index(string, substring)
# Find position of substring in string (1-indexed, 0 if not found)
# Returns: position of first occurrence
# Example: pos = index("hello", "ll")  # returns 3

# length([string])
# Get length of string (or $0 if omitted)
# Returns: number of characters
# Example: len = length("hello")  # returns 5

# match(string, regexp)
# Match regexp against string, sets RSTART and RLENGTH
# Returns: position of match, or 0 if no match
# Example: if (match(str, /[0-9]+/)) print "found at", RSTART

# split(string, array [, fieldsep])
# Split string into array using fieldsep (or FS if omitted)
# Returns: number of elements in array
# Example: n = split("a:b:c", arr, ":")  # arr[1]="a", arr[2]="b", arr[3]="c"

# sprintf(format, expression1, expression2, ...)
# Format expressions according to format string (like C printf)
# Returns: formatted string
# Example: str = sprintf("%s is %d years old", name, age)
#
# ============================================================================
# SPRINTF FORMAT SPECIFICATION
# ============================================================================
#
# Format: %[flags][width][.precision]conversion
#
# CONVERSION SPECIFIERS:
# ----------------------
# %d, %i   - Signed decimal integer
# %u       - Unsigned decimal integer
# %o       - Unsigned octal integer
# %x       - Unsigned hexadecimal integer (lowercase: a-f)
# %X       - Unsigned hexadecimal integer (uppercase: A-F)
# %f       - Floating point (decimal notation)
# %e       - Floating point (scientific notation, lowercase e)
# %E       - Floating point (scientific notation, uppercase E)
# %g       - Use %e or %f, whichever is shorter (lowercase)
# %G       - Use %E or %f, whichever is shorter (uppercase)
# %c       - Single character
# %s       - String
# %%       - Literal percent sign
#
# FLAGS (optional, can be combined):
# -----------------------------------
# -        Left-align within field width (default: right-align)
# +        Always show sign (+ or -) for numbers (default: - only)
# (space)  Prefix positive numbers with space (ignored if + used)
# 0        Pad with zeros instead of spaces (for numbers)
# #        Alternative form:
#          - %o: prefix with 0
#          - %x/%X: prefix with 0x/0X
#          - %e/%E/%f: always include decimal point
#          - %g/%G: don't remove trailing zeros
#
# WIDTH (optional):
# -----------------
# number   Minimum field width (pad with spaces or zeros)
# *        Width taken from next argument
#
# PRECISION (optional):
# ---------------------
# .number  For %f/%e/%E: digits after decimal (default: 6)
#          For %g/%G: significant digits
#          For %s: maximum characters to print
#          For %d/%i/%o/%x/%X: minimum digits to print (zero-pad)
# .*       Precision taken from next argument
#
# ============================================================================
# SPRINTF EXAMPLES
# ============================================================================
#
# Basic conversions:
# sprintf("%d", 42)              # "42"
# sprintf("%i", 42)              # "42"
# sprintf("%u", -5)              # "4294967291" (unsigned, platform dependent)
# sprintf("%o", 8)               # "10" (octal)
# sprintf("%x", 255)             # "ff" (hex lowercase)
# sprintf("%X", 255)             # "FF" (hex uppercase)
# sprintf("%f", 3.14159)         # "3.141590" (6 decimals default)
# sprintf("%e", 1234.5)          # "1.234500e+03"
# sprintf("%E", 1234.5)          # "1.234500E+03"
# sprintf("%g", 1234.5)          # "1234.5" (shorter form)
# sprintf("%c", 65)              # "A" (ASCII)
# sprintf("%s", "hello")         # "hello"
# sprintf("%%")                  # "%"
#
# Width examples:
# sprintf("%5d", 42)             # "   42" (right-aligned in 5 chars)
# sprintf("%5s", "hi")           # "   hi"
# sprintf("%10s", "test")        # "      test"
#
# Precision examples:
# sprintf("%.2f", 3.14159)       # "3.14"
# sprintf("%.0f", 3.14159)       # "3"
# sprintf("%.10f", 3.14)         # "3.1400000000"
# sprintf("%.3s", "hello")       # "hel" (max 3 chars)
# sprintf("%.5d", 42)            # "00042" (min 5 digits)
#
# Width + Precision:
# sprintf("%8.2f", 3.14159)      # "    3.14" (8 chars wide, 2 decimals)
# sprintf("%10.3s", "hello")     # "       hel" (10 chars wide, max 3 from string)
#
# Flags - Left align (-):
# sprintf("%-5d", 42)            # "42   " (left-aligned)
# sprintf("%-10s", "test")       # "test      "
# sprintf("%-8.2f", 3.14)        # "3.14    "
#
# Flags - Zero padding (0):
# sprintf("%05d", 42)            # "00042"
# sprintf("%08.2f", 3.14)        # "00003.14"
# sprintf("%010s", "hi")         # "hi        " (0 flag ignored for strings)
#
# Flags - Sign (+):
# sprintf("%+d", 42)             # "+42"
# sprintf("%+d", -42)            # "-42"
# sprintf("%+.2f", 3.14)         # "+3.14"
#
# Flags - Space ( ):
# sprintf("% d", 42)             # " 42" (space before positive)
# sprintf("% d", -42)            # "-42" (no space before negative)
#
# Flags - Alternative form (#):
# sprintf("%#o", 8)              # "010" (with 0 prefix)
# sprintf("%#x", 255)            # "0xff"
# sprintf("%#X", 255)            # "0XFF"
# sprintf("%#.0f", 3.0)          # "3." (decimal point even with .0)
#
# Dynamic width and precision (*):
# sprintf("%*d", 5, 42)          # "   42" (width=5 from arg)
# sprintf("%.*f", 2, 3.14159)    # "3.14" (precision=2 from arg)
# sprintf("%*.*f", 8, 2, 3.14)   # "    3.14" (width=8, precision=2)
#
# Multiple conversions:
# sprintf("%s: %d", "Count", 5)              # "Count: 5"
# sprintf("%s is %d years old", "Alice", 30) # "Alice is 30 years old"
# sprintf("%.2f + %.2f = %.2f", 1.5, 2.3, 3.8) # "1.50 + 2.30 = 3.80"
#
# Combining flags:
# sprintf("%+08.2f", 3.14)       # "+0003.14" (sign + zero-pad + precision)
# sprintf("%-+10.2f", 3.14)      # "+3.14     " (left-align + sign)
# sprintf("%#-10x", 255)         # "0xff      " (alt form + left-align)
#
# Table formatting:
# sprintf("%-10s %8.2f %5d", "Item", 19.99, 3)  # "Item         19.99     3"
# sprintf("%-10s %8.2f %5d", "LongItemName", 9.50, 100)
#                                                # "LongItemNa    9.50   100"
#
# ============================================================================
# COMMON SPRINTF PATTERNS
# ============================================================================
#
# Currency formatting:
# sprintf("$%.2f", price)                    # "$19.99"
# sprintf("$%,.2f", 1234.56)                 # "$1234.56" (AWK doesn't support ,)
# sprintf("$%8.2f", price)                   # "$   19.99" (right-aligned)
#
# Percentage formatting:
# sprintf("%.1f%%", 85.7)                    # "85.7%"
# sprintf("%5.1f%%", 7.5)                    # "  7.5%"
#
# Padding with zeros:
# sprintf("%04d", 42)                        # "0042" (ID numbers)
# sprintf("%03d", 7)                         # "007"
#
# Scientific notation:
# sprintf("%e", 0.00012)                     # "1.200000e-04"
# sprintf("%.2e", 1234567)                   # "1.23e+06"
#
# Hex dump:
# sprintf("0x%02x", byte)                    # "0x1f" (2-digit hex)
# sprintf("0x%08X", addr)                    # "0x00001234" (8-digit hex address)
#
# Formatted tables:
# printf "%-15s %10s %8s\n", "Name", "Email", "Age"
# printf "%-15s %10s %8d\n", name, email, age
#
# IP address formatting:
# sprintf("%d.%d.%d.%d", a, b, c, d)         # "192.168.1.1"
#
# Date/time formatting (manual):
# sprintf("%04d-%02d-%02d", year, month, day)     # "2025-01-15"
# sprintf("%02d:%02d:%02d", hour, minute, second) # "14:30:00"
#
# ============================================================================
# IMPORTANT NOTES
# ============================================================================
#
# 1. sprintf() and printf() use identical format specifications
# 2. AWK follows C printf conventions with minor differences
# 3. Width/precision can be specified literally or with * (dynamic)
# 4. %g/%G automatically choose %e/%E or %f based on magnitude and precision
# 5. Precision for %f defaults to 6 decimal places
# 6. Width specifies minimum field width (output can be wider if needed)
# 7. Flags can be combined: "%-+08.2f" is valid
# 8. Order matters: % [flags] [width] [.precision] conversion
# 9. Use %% to print a literal % character
# 10. For %s with precision, only that many characters are printed from the string

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
# AWK supports a rich set of operators for arithmetic, comparison, logical
# operations, pattern matching, and more. Operators have precedence and
# associativity rules that determine evaluation order.
#
# ============================================================================
# ARITHMETIC OPERATORS
# ============================================================================
#
# +        Addition
#          Example: sum = a + b
#          Example: x = 5 + 3        # 8
#
# -        Subtraction or unary negation
#          Example: diff = a - b
#          Example: x = -5           # negative 5
#          Example: x = 10 - 3       # 7
#
# *        Multiplication
#          Example: product = a * b
#          Example: x = 4 * 5        # 20
#
# /        Division
#          Example: quotient = a / b
#          Example: x = 10 / 3       # 3.33333
#          Example: x = 10 / 4       # 2.5
#          Note: Division by zero produces inf or nan
#
# %        Modulo (remainder)
#          Example: remainder = a % b
#          Example: x = 10 % 3       # 1
#          Example: x = 17 % 5       # 2
#          Note: Result has same sign as first operand
#
# ^        Exponentiation (power)
#          Example: power = base ^ exponent
#          Example: x = 2 ^ 3        # 8
#          Example: x = 10 ^ 2       # 100
#          Example: x = 2 ^ 0.5      # 1.41421 (square root)
#          Note: Some AWK versions use ** instead
#
# ++       Increment (prefix or postfix)
#          Example: ++i              # increment i, return new value
#          Example: i++              # return current value, then increment
#          Example: x = ++i          # i becomes i+1, x gets new i
#          Example: x = i++          # x gets current i, then i becomes i+1
#
# --       Decrement (prefix or postfix)
#          Example: --i              # decrement i, return new value
#          Example: i--              # return current value, then decrement
#          Example: x = --i          # i becomes i-1, x gets new i
#          Example: x = i--          # x gets current i, then i becomes i-1
#
# ============================================================================
# ASSIGNMENT OPERATORS
# ============================================================================
#
# =        Simple assignment
#          Example: x = 5
#          Example: name = "John"
#          Example: total = sum + tax
#
# +=       Add and assign
#          Example: x += 5           # same as: x = x + 5
#          Example: total += price
#
# -=       Subtract and assign
#          Example: x -= 5           # same as: x = x - 5
#          Example: balance -= withdrawal
#
# *=       Multiply and assign
#          Example: x *= 2           # same as: x = x * 2
#          Example: price *= 1.1     # increase by 10%
#
# /=       Divide and assign
#          Example: x /= 2           # same as: x = x / 2
#          Example: average /= count
#
# %=       Modulo and assign
#          Example: x %= 10          # same as: x = x % 10
#          Example: index %= array_size
#
# ^=       Power and assign
#          Example: x ^= 2           # same as: x = x ^ 2
#          Example: x ^= 0.5         # square root
#
# ============================================================================
# COMPARISON OPERATORS
# ============================================================================
#
# ==       Equal to
#          Example: if (x == 5)
#          Example: if (name == "John")
#          Note: Numeric comparison if both operands are numbers
#
# !=       Not equal to
#          Example: if (x != 0)
#          Example: if (status != "active")
#
# <        Less than
#          Example: if (x < 10)
#          Example: if (age < 18)
#          Example: if ("abc" < "xyz")  # string comparison
#
# <=       Less than or equal to
#          Example: if (x <= 10)
#          Example: if (score <= 100)
#
# >        Greater than
#          Example: if (x > 0)
#          Example: if (price > 100)
#
# >=       Greater than or equal to
#          Example: if (x >= 0)
#          Example: if (age >= 21)
#
# ============================================================================
# LOGICAL OPERATORS
# ============================================================================
#
# &&       Logical AND
#          Example: if (x > 0 && x < 10)
#          Example: if (age >= 18 && hasLicense)
#          Note: Short-circuit evaluation (right side not evaluated if left is false)
#
# ||       Logical OR
#          Example: if (x < 0 || x > 10)
#          Example: if (role == "admin" || role == "owner")
#          Note: Short-circuit evaluation (right side not evaluated if left is true)
#
# !        Logical NOT (negation)
#          Example: if (!found)
#          Example: if (!(x > 0))
#          Example: if (!match($0, /pattern/))
#
# ============================================================================
# PATTERN MATCHING OPERATORS
# ============================================================================
#
# ~        Matches regular expression
#          Example: if ($1 ~ /^[0-9]+$/)     # field 1 is all digits
#          Example: if (email ~ /@/)         # email contains @
#          Example: if ($0 ~ /error|warning/) # line contains error or warning
#          Note: Left operand is string, right operand is regex
#
# !~       Does not match regular expression
#          Example: if ($1 !~ /^#/)          # field 1 doesn't start with #
#          Example: if (name !~ /[0-9]/)     # name contains no digits
#          Example: if ($0 !~ /^$/)          # line is not empty
#
# ============================================================================
# TERNARY OPERATOR
# ============================================================================
#
# ?:       Conditional expression (ternary)
#          Syntax: condition ? true_value : false_value
#          Example: max = (a > b) ? a : b
#          Example: status = (count > 0) ? "found" : "not found"
#          Example: abs = (x < 0) ? -x : x
#          Example: sign = (x > 0) ? 1 : (x < 0) ? -1 : 0
#          Note: Both true_value and false_value must be present
#
# ============================================================================
# STRING CONCATENATION OPERATOR
# ============================================================================
#
# (space)  String concatenation (implicit)
#          Example: fullname = first " " last
#          Example: url = "https://" domain "/path"
#          Example: msg = "Error: " error_code " - " error_text
#          Note: No explicit operator - adjacent expressions are concatenated
#          Note: Concatenation has higher precedence than comparison
#
# ============================================================================
# FIELD REFERENCE OPERATOR
# ============================================================================
#
# $        Field reference
#          Example: $1               # first field
#          Example: $2               # second field
#          Example: $NF              # last field
#          Example: $(NF-1)          # second-to-last field
#          Example: $0               # entire record (line)
#          Example: $i               # field at position i (variable)
#          Note: Fields are 1-indexed
#          Note: $0 is the entire input record
#
# ============================================================================
# ARRAY MEMBERSHIP OPERATOR
# ============================================================================
#
# in       Test if array index exists
#          Example: if (key in array)
#          Example: if (!(key in array))
#          Example: if (i in myarray) print myarray[i]
#          Note: Tests for key existence, not value
#          Note: Does not retrieve the value
#
# ============================================================================
# GROUPING OPERATOR
# ============================================================================
#
# ()       Grouping and function calls
#          Example: result = (a + b) * c     # grouping for precedence
#          Example: length(str)              # function call
#          Example: if ((x > 0) && (y > 0))  # clarity in conditionals
#
# ============================================================================
# OPERATOR PRECEDENCE (highest to lowest)
# ============================================================================
#
# 1.  ()          Grouping
# 2.  $           Field reference
# 3.  ++ --       Increment/decrement (postfix)
# 4.  ++ -- - !   Increment/decrement (prefix), unary minus, logical NOT
# 5.  ^           Exponentiation
# 6.  * / %       Multiplication, division, modulo
# 7.  + -         Addition, subtraction
# 8.  (space)     String concatenation
# 9.  < <= > >=   Comparison (relational)
#     == !=       Equality, inequality
#     ~ !~        Pattern matching
# 10. in          Array membership
# 11. &&          Logical AND
# 12. ||          Logical OR
# 13. ?:          Ternary conditional
# 14. = += -= *=  Assignment operators
#     /= %= ^=
#
# Note: Use parentheses for clarity when operator precedence is unclear
# Note: Most operators are left-associative (evaluate left to right)
# Note: Assignment and exponentiation are right-associative
#
# ============================================================================
# OPERATOR EXAMPLES
# ============================================================================
#
# Arithmetic:
#   sum = a + b + c
#   avg = (a + b + c) / 3
#   squared = x ^ 2
#   area = length * width
#   remainder = n % 10
#
# Compound assignment:
#   total += price               # accumulate total
#   count++                      # increment counter
#   balance -= withdrawal        # deduct from balance
#   value *= 1.1                 # increase by 10%
#
# Comparison:
#   if (age >= 18) print "Adult"
#   if (score == 100) print "Perfect!"
#   if (x > y) max = x; else max = y
#
# Logical:
#   if (x > 0 && x < 10) print "Single digit positive"
#   if (role == "admin" || role == "owner") allow_access = 1
#   if (!found) print "Not found"
#
# Pattern matching:
#   if ($1 ~ /^[0-9]+$/) print "First field is numeric"
#   if ($0 ~ /error/i) error_count++     # case-insensitive with IGNORECASE
#   if (email !~ /@/) print "Invalid email"
#
# Ternary:
#   status = (x > 0) ? "positive" : "non-positive"
#   abs = (x < 0) ? -x : x
#   max = (a > b) ? a : (b > c) ? b : c  # nested ternary
#
# String concatenation:
#   fullname = first " " last
#   greeting = "Hello, " name "!"
#   path = dir "/" file
#
# Field reference:
#   print $1, $2, $3              # print first three fields
#   last = $NF                    # get last field
#   secondlast = $(NF-1)          # get second-to-last field
#   $1 = toupper($1)              # modify first field
#
# Array membership:
#   if (key in cache) {
#       value = cache[key]
#   } else {
#       value = compute(key)
#       cache[key] = value
#   }
#
# Complex expressions:
#   result = (a + b) * (c - d) / (e + 1)
#   valid = (len >= 8) && (str ~ /[A-Z]/) && (str ~ /[0-9]/)
#   price = base_price * (1 + tax_rate) - discount
#   grade = (score >= 90) ? "A" : (score >= 80) ? "B" : (score >= 70) ? "C" : "F"
#
# ============================================================================
# IMPORTANT NOTES
# ============================================================================
#
# 1. Uninitialized variables are 0 in numeric context and "" in string context
# 2. Comparison operators perform numeric comparison if both operands look like numbers
# 3. String comparison is lexicographic (dictionary order) based on ASCII values
# 4. Use IGNORECASE = 1 for case-insensitive pattern matching
# 5. Short-circuit evaluation: && and || don't evaluate right side if unnecessary
# 6. Division by zero produces inf (infinity) or nan (not a number), not an error
# 7. Modulo with negative numbers: result has same sign as first operand
# 8. String concatenation has higher precedence than comparison operators
# 9. Always use parentheses when mixing operators to make intent clear
# 10. The in operator tests key existence, not value (for arrays)
# 11. Field references with $ can use expressions: $(i+1), $(NF-2), etc.
# 12. Increment/decrement work on variables, not literals or expressions
# 13. Pattern matching operators ~ and !~ are specific to AWK (not in C)
# 14. The ^ operator may be ** in some AWK implementations
# 15. Assignment operators can be chained: a = b = c = 0

# ============================================================================
# CONTROL FLOW
# ============================================================================

# ============================================================================
# CONDITIONAL STATEMENTS
# ============================================================================

# if statement
# Syntax: if (condition) statement
# Example: if (x > 0) print "positive"

# if-else statement
# Syntax: if (condition) statement1 else statement2
# Example: if (x > 0) print "positive" else print "non-positive"

# if-else if-else chain
# Syntax: if (cond1) stmt1 else if (cond2) stmt2 else stmt3
# Example:
# if (x > 0) {
#     print "positive"
# } else if (x < 0) {
#     print "negative"
# } else {
#     print "zero"
# }

# Ternary operator (conditional expression)
# Syntax: condition ? value_if_true : value_if_false
# Example: result = (x > 0) ? "positive" : "non-positive"
# Example: max = (a > b) ? a : b

# ============================================================================
# CONDITIONAL STATEMENT EXAMPLES
# ============================================================================

# Example 1: Simple if
# { if (NF > 5) print "More than 5 fields" }

# Example 2: if-else
# {
#     if ($1 > 100) {
#         print "Large:", $1
#     } else {
#         print "Small:", $1
#     }
# }

# Example 3: if-else if-else chain
# {
#     if ($1 < 0) {
#         category = "negative"
#     } else if ($1 == 0) {
#         category = "zero"
#     } else if ($1 <= 10) {
#         category = "small positive"
#     } else if ($1 <= 100) {
#         category = "medium positive"
#     } else {
#         category = "large positive"
#     }
#     print $1, "is", category
# }

# Example 4: Nested if statements
# {
#     if (NF > 0) {
#         if ($1 ~ /^[0-9]+$/) {
#             if ($1 % 2 == 0) {
#                 print $1, "is an even number"
#             } else {
#                 print $1, "is an odd number"
#             }
#         } else {
#             print $1, "is not a number"
#         }
#     }
# }

# Example 5: Ternary operator
# {
#     status = ($1 > threshold) ? "HIGH" : "LOW"
#     print $1, status
# }

# Example 6: Ternary in expressions
# {
#     # Clamp value between min and max
#     value = ($1 < min) ? min : ($1 > max) ? max : $1
#     print value
# }

# ============================================================================
# LOOP STATEMENTS
# ============================================================================

# while loop
# Syntax: while (condition) statement
# Execute statement while condition is true
# Example:
# {
#     i = 1
#     while (i <= NF) {
#         print $i
#         i++
#     }
# }

# do-while loop
# Syntax: do statement while (condition)
# Execute statement at least once, then repeat while condition is true
# Example:
# {
#     i = 1
#     do {
#         print $i
#         i++
#     } while (i <= NF)
# }

# for loop (C-style)
# Syntax: for (init; condition; increment) statement
# Example:
# {
#     for (i = 1; i <= NF; i++) {
#         print i, $i
#     }
# }

# for-in loop (array iteration)
# Syntax: for (var in array) statement
# Iterates over array indices (keys)
# Note: Order is NOT guaranteed (usually insertion order but not specified)
# Example:
# {
#     for (i in array) {
#         print i, array[i]
#     }
# }

# ============================================================================
# LOOP CONTROL STATEMENTS
# ============================================================================

# break
# Exit from the innermost loop immediately
# Example:
# {
#     for (i = 1; i <= NF; i++) {
#         if ($i == "STOP") break
#         print $i
#     }
# }

# continue
# Skip to next iteration of the innermost loop
# Example:
# {
#     for (i = 1; i <= NF; i++) {
#         if ($i == "") continue  # skip empty fields
#         print $i
#     }
# }

# next
# Skip to next input record (line)
# Stops processing current line, continues with next
# Example: /^#/ { next }  # skip comment lines

# exit [exit_code]
# Terminate AWK program
# exit_code: optional exit status (default: 0)
# Executes END blocks before exiting
# Example: exit 0  # successful exit
# Example: exit 1  # error exit

# ============================================================================
# LOOP EXAMPLES
# ============================================================================

# Example 1: while loop - countdown
# BEGIN {
#     i = 10
#     while (i > 0) {
#         print i
#         i--
#     }
#     print "Blastoff!"
# }

# Example 2: do-while loop - input validation
# BEGIN {
#     do {
#         print "Enter positive number:"
#         getline num
#     } while (num <= 0)
#     print "You entered:", num
# }

# Example 3: for loop - print all fields
# {
#     for (i = 1; i <= NF; i++) {
#         printf "Field %d: %s\n", i, $i
#     }
# }

# Example 4: for loop - sum array
# END {
#     total = 0
#     for (i = 1; i <= 100; i++) {
#         total += i
#     }
#     print "Sum 1-100:", total  # 5050
# }

# Example 5: for-in loop - iterate array
# END {
#     for (name in ages) {
#         print name, "is", ages[name], "years old"
#     }
# }

# Example 6: for-in loop - count occurrences
# {
#     for (i = 1; i <= NF; i++) {
#         count[$i]++
#     }
# }
# END {
#     for (word in count) {
#         print word, count[word]
#     }
# }

# Example 7: Nested loops - multiplication table
# BEGIN {
#     for (i = 1; i <= 10; i++) {
#         for (j = 1; j <= 10; j++) {
#             printf "%4d", i * j
#         }
#         print ""
#     }
# }

# Example 8: break statement - find first match
# {
#     found = 0
#     for (i = 1; i <= NF; i++) {
#         if ($i == search_term) {
#             print "Found at field", i
#             found = 1
#             break  # Stop searching
#         }
#     }
#     if (!found) print "Not found"
# }

# Example 9: continue statement - skip negatives
# {
#     sum = 0
#     for (i = 1; i <= NF; i++) {
#         if ($i < 0) continue  # Skip negative numbers
#         sum += $i
#     }
#     print "Sum of positive numbers:", sum
# }

# Example 10: next statement - skip comment lines
# /^#/ { next }  # Skip lines starting with #
# /^$/ { next }  # Skip empty lines
# { process($0) }  # Process non-comment, non-empty lines

# Example 11: exit in loop - early termination
# {
#     for (i = 1; i <= NF; i++) {
#         if ($i == "FATAL") {
#             print "Fatal error found, exiting"
#             exit 1
#         }
#     }
# }

# Example 12: while with getline - read multiple files
# BEGIN {
#     while ((getline line < "file1.txt") > 0) {
#         print "File1:", line
#     }
#     close("file1.txt")
#
#     while ((getline line < "file2.txt") > 0) {
#         print "File2:", line
#     }
#     close("file2.txt")
# }

# ============================================================================
# COMPLEX CONTROL FLOW EXAMPLES
# ============================================================================

# Example 13: Bubble sort with nested loops
# function bubble_sort(arr, n,    i, j, temp, swapped) {
#     for (i = 0; i < n - 1; i++) {
#         swapped = 0
#         for (j = 0; j < n - i - 1; j++) {
#             if (arr[j] > arr[j + 1]) {
#                 temp = arr[j]
#                 arr[j] = arr[j + 1]
#                 arr[j + 1] = temp
#                 swapped = 1
#             }
#         }
#         if (!swapped) break  # Optimization: already sorted
#     }
# }

# Example 14: Binary search with while loop
# function binary_search(arr, n, target,    low, high, mid) {
#     low = 0
#     high = n - 1
#
#     while (low <= high) {
#         mid = int((low + high) / 2)
#
#         if (arr[mid] == target) {
#             return mid  # Found
#         } else if (arr[mid] < target) {
#             low = mid + 1
#         } else {
#             high = mid - 1
#         }
#     }
#
#     return -1  # Not found
# }

# Example 15: State machine with if-else
# {
#     if (state == "INIT") {
#         if ($1 == "START") {
#             state = "PROCESSING"
#             print "Started processing"
#         }
#     } else if (state == "PROCESSING") {
#         if ($1 == "DATA") {
#             process_data($2)
#         } else if ($1 == "END") {
#             state = "DONE"
#             print "Finished processing"
#         } else if ($1 == "ERROR") {
#             state = "ERROR"
#             print "Error occurred"
#         }
#     } else if (state == "DONE") {
#         print "Already finished"
#     } else if (state == "ERROR") {
#         print "Cannot continue due to error"
#     }
# }

# Important Notes about Control Flow:
# 1. Braces {} are optional for single statements but recommended for clarity
# 2. No parentheses needed around condition in for-in loop: for (i in arr)
# 3. break and continue only work in loops, not in if statements
# 4. next only works in pattern-action blocks, not in BEGIN/END
# 5. exit runs END blocks before terminating
# 6. for-in loop order is undefined (don't rely on it)
# 7. Conditions are "true" if non-zero or non-empty string
# 8. Empty string "" and 0 are "false"
# 9. Uninitialized variables are 0 and "" (both false)
# 10. Use && (AND), || (OR), ! (NOT) for combining conditions

# ============================================================================
# BUILT-IN VARIABLES
# ============================================================================

# ============================================================================
# FIELD AND RECORD VARIABLES
# ============================================================================

# $0         - Current record (entire line)
# $1, $2,... - Fields in current record (1-indexed)
# NF         - Number of fields in current record
# NR         - Total number of records read so far
# FNR        - Number of records in current file
# FILENAME   - Name of current input file

# ============================================================================
# SEPARATOR VARIABLES
# ============================================================================

# FS         - Input field separator (default: whitespace)
# RS         - Input record separator (default: newline)
# OFS        - Output field separator (default: space)
# ORS        - Output record separator (default: newline)
# SUBSEP     - Subscript separator for multi-dimensional arrays (default: "\034")

# ============================================================================
# PATTERN MATCHING VARIABLES
# ============================================================================

# RSTART     - Start position of match() match
# RLENGTH    - Length of match() match

# ============================================================================
# COMMAND LINE ARGUMENT VARIABLES
# ============================================================================

# ARGC       - Number of command-line arguments
# ARGV       - Array of command-line arguments (0-indexed)

# ============================================================================
# FORMATTING VARIABLES
# ============================================================================

# OFMT       - Output format for numbers (default: "%.6g")
# CONVFMT    - Conversion format for numbers (default: "%.6g")

# ============================================================================
# ENVIRONMENT
# ============================================================================

# ENVIRON    - Array of environment variables

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
#     print matrix[1, 2]  # prints "b"
# }

# Example 2: Splitting composite keys to extract individual indices
# BEGIN {
#     data[1, "name"] = "Alice"
#     data[1, "age"] = 30
#
#     for (composite_key in data) {
#         n = split(composite_key, indices, SUBSEP)
#         id = indices[1]
#         field = indices[2]
#         printf "ID: %s, Field: %s, Value: %s\n", id, field, data[composite_key]
#     }
# }

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

# Example 2: Function with multiple parameters
# function max(a, b) {
#     return (a > b) ? a : b
# }
# { print max($1, $2) }

# Example 3: Function with local variables
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

# Example 4: Function that modifies an array (passed by reference)
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

# Example 5: Function without return (void function)
# function print_header(title) {
#     print "=============================="
#     print title
#     print "=============================="
# }
# BEGIN { print_header("My Report") }

# Example 6: Recursive function
# function factorial(n) {
#     if (n <= 1) return 1
#     return n * factorial(n - 1)
# }
# BEGIN {
#     print factorial(5)  # prints 120
# }

# Example 7: String manipulation function
# function trim(str) {
#     gsub(/^[ \t]+|[ \t]+$/, "", str)
#     return str
# }
# { print trim($0) }

# Example 8: Validation function
# function is_valid_email(email) {
#     return match(email, /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/)
# }
# {
#     if (is_valid_email($1)) {
#         print $1, "is valid"
#     }
# }

# Example 9: Function that returns multiple values via array
# function get_stats(arr, results,    i, sum, count, avg) {
#     sum = 0
#     count = 0
#     for (i in arr) {
#         sum += arr[i]
#         count++
#     }
#     avg = count > 0 ? sum / count : 0
#     results["sum"] = sum
#     results["count"] = count
#     results["avg"] = avg
# }
# END {
#     data[1] = 10
#     data[2] = 20
#     data[3] = 30
#     get_stats(data, stats)
#     print "Average:", stats["avg"]
# }

# Example 10: Complete script with functions
# function celsius_to_fahrenheit(c) {
#     return (c * 9/5) + 32
# }
#
# function fahrenheit_to_celsius(f) {
#     return (f - 32) * 5/9
# }
#
# function format_temp(temp, unit) {
#     return sprintf("%.1f°%s", temp, unit)
# }
#
# /^C/ {
#     c = $2
#     f = celsius_to_fahrenheit(c)
#     print format_temp(c, "C"), "=", format_temp(f, "F")
# }
#
# /^F/ {
#     f = $2
#     c = fahrenheit_to_celsius(f)
#     print format_temp(f, "F"), "=", format_temp(c, "C")
# }

# Important Notes about Functions:
# 1. Scalars are passed by value (copy), arrays by reference
# 2. To create local variables, add them as extra parameters after actual parameters
# 3. Convention: separate actual params from local vars with extra whitespace
# 4. Functions can access global variables directly
# 5. No function overloading - each function name must be unique
# 6. Recursive functions work but watch for stack depth
# 7. Functions can be called from any action block (BEGIN, pattern-action, END)
# 8. Return value can be any type (number, string, not array directly)
# 9. If no return statement, function returns empty string ""
# 10. Function definitions are typically placed at the beginning or end of script

# ============================================================================
# COMMON EXAMPLES
# ============================================================================

# Example 1: Number all lines
# { print NR ":", $0 }

# Example 2: Print last field
# { print $NF }

# Example 3: CSV to TSV converter
# BEGIN { FS = ","; OFS = "\t" }
# { print }

# Example 4: Sum first column
# { sum += $1 }
# END { print "Total:", sum }

# Example 5: Count word frequency
# {
#     for (i = 1; i <= NF; i++)
#         words[$i]++
# }
# END {
#     for (word in words)
#         print word, words[word]
# }

# Example 6: Extract phone numbers
# {
#     if (match($0, /[0-9]{3}-[0-9]{4}/)) {
#         phone = substr($0, RSTART, RLENGTH)
#         print "Phone:", phone
#     }
# }

# Example 7: Paragraph mode (blank line separated records)
# BEGIN { RS = ""; FS = "\n" }
# { print "Paragraph", NR, "has", NF, "lines" }

# Example 8: Execute command and capture output
# BEGIN {
#     "date +%Y-%m-%d" | getline today
#     close("date +%Y-%m-%d")
#     print "Today:", today
# }

# Important Notes:
# 1. Field variables ($1, $2, etc.) are 1-indexed, not 0-indexed
# 2. $0 is special - modifying it recalculates all field variables
# 3. NF can be modified to add/remove fields
# 4. Modifying fields changes $0 automatically
# 5. Always close() pipes to avoid resource leaks
# 6. Set separators in BEGIN block before processing input
# 7. ENVIRON is read-only; you cannot set environment variables
# 8. FILENAME is empty when reading from stdin
# 9. ARGV elements can be modified/deleted to control input files
# 10. For gawk-specific extensions, see gawk-extensions-reference.awk

END {
	print ""
	print "=== END POSIX AWK REFERENCE ==="
}
