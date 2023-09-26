#!/usr/bin/env python3

import sys
import subprocess

if len(sys.argv) <= 1 or sys.argv[1] == "":
	print("please provide a tag; include the 'v', if you please")
	exit(1)

tag=sys.argv[1]

if tag[0] != "v":
	print("please provide a tag; include the 'v', if you please")
	exit(1)

# tags = subprocess.check_output(["git", "tag", "--sort", "-version:refname", '--format="%(refname:strip=2);%(symref)"'])
# info=tags[:tags.index(b"\n")]
# tag=info[:info.index(b";")]
# hash=info[info.index(b";")+1:]
# print(f"{tag}, {hash}")

builds=[
	{"os": "darwin", "arch": "arm64"},
	{"os": "darwin", "arch": "amd64"},
	{"os": "linux", "arch": "arm64"},
	{"os": "linux", "arch": "amd64"},
]

for build in builds:
	print(f'GOOS={build["os"]} GOARCH={build["arch"]} make release')

hash = subprocess.check_output(["git", "rev-list", "-n", "1", tag])
hash = hash[:7]
print(f"gh release create --notes-from-tag {tag}")
print(f"gh release upload {tag} ./release/*-{str(hash, 'utf-8')}-*.tgz")
#$(RELEASEDIR)/$(BIN)-$(COHASH)-$(GOOS)-$(GOARCH).tgz
