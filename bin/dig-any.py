#!/usr/bin/env python3

import os, sys

types = [
    "NS", "A", "AAAA", "CNAME", "MX", "TXT",
]

if len(sys.argv) <= 1 :
    domain = input("domain to query: ")
else:
    domain = sys.argv[1]

single_type = sys.argv[2] if len(sys.argv) > 2 else ""

for type in types:
    if single_type != "" and single_type != type:
        continue

    print(f"# ------ {type}")
    os.system(f"dig +nocmd {domain} +noall +answer {type}")
    # os.system(f"dig {domain} +nocomments +noall +answer -t {type}")

# https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site
# dig EXAMPLE.COM +noall +answer -t AAAA
# dig WWW.EXAMPLE.COM +nostats +nocomments +nocmd
