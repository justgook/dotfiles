Fix worktrees fetches:
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" 

## Setup Commands
```bash 
defaults write com.apple.Finder AppleShowAllFiles true # always show hidden files
```

Disable Annoying Disk Warning (must restart Mac to take effect): 
```bash
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.DiskArbitration.diskarbitrationd.plist DADisableEjectNotification -bool YES && sudo pkill diskarbitrationd
```
