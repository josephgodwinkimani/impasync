# Define variables
$cygwinInstallerUrl = "https://cygwin.com/setup-x86_64.exe"
$cygwinInstallDir = "C:\cygwin"
$imapsyncDir = "$cygwinInstallDir\home\$(whoami)\imapsync"
$packages = "gcc-core", "g++", "make", "perl", "perl-Digest-HMAC", "perl-IO-Socket-SSL", "perl-Socket6", "libcrypt-devel"

# Download Cygwin Installer
Write-Host "Downloading Cygwin installer..."
Invoke-WebRequest -Uri $cygwinInstallerUrl -OutFile "$env:TEMP\setup-x86_64.exe"

# Run Cygwin Installer
Write-Host "Installing Cygwin..."
Start-Process -FilePath "$env:TEMP\setup-x86_64.exe" -ArgumentList "-q -P $($packages -join ',') -R $cygwinInstallDir" -Wait

# Clone IMAPSync repository
Write-Host "Cloning IMAPSync repository..."
git clone https://github.com/imapsync/imapsync.git $imapsyncDir

# Change permissions for the imapsync script
Write-Host "Setting permissions for IMAPSync script..."
Set-ExecutionPolicy Bypass -Scope Process -Force
cd $imapsyncDir
chmod +x imapsync

# Clean up installer
Remove-Item "$env:TEMP\setup-x86_64.exe"

Write-Host "Cygwin and IMAPSync installation completed successfully!"