################################################################################
####
####  DO NOT INVOKE docker DIRECTLY, USE Makefile; `make docker`
####  ASSUMES A WORKING BINARY
####
################################################################################
# iron/go is the alpine image with only ca-certificates added
FROM iron/go
WORKDIR /app
# Now just add the binary; note that the binary must be previously built
ADD binaryfile /app
ENTRYPOINT ["./binaryfile"]
