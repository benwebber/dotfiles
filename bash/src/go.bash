#-------------------------------------------------------------------------------
# Golang
#-------------------------------------------------------------------------------

export GOROOT=/usr/local/Cellar/go/1.4.2/libexec
export GOPATH=~/src/go

path contains "${GOROOT}/bin" || path insert "${GOROOT}/bin"
path contains "${GOPATH}/bin" || path insert "${GOPATH}/bin"
