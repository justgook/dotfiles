# Go (if go exists)
if [ -f /usr/local/go/bin/go ]
    set -g fish_user_paths "/usr/local/go/bin" fish_user_paths
    set -x  GOPATH   $(go env GOPATH)
    set -x PATH $PATH $GOPATH/bin
    set -x PATH $PATH (go env GOPATH)/bin
end
