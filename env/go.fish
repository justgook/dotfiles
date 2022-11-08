if [ -x "$(command -v go)" ] 
    set -x GOPATH $(go env GOPATH)
    fish_add_path  $(go env GOPATH)/bin -P
end

