# Allow script execution
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Install WSL and Ubuntu
wsl --install -d Ubuntu

# Set default WSL version to 2
wsl --set-default-version 2

Write-Host "WSL + Ubuntu installed. Open Ubuntu and run setup-wsl-dotfiles.sh inside WSL."
