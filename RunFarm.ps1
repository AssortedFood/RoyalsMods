# Navigate to the project directory and run git pull
Set-Location "C:\Users\oxi\Projects\RoyalsMods"
git pull

# Wait for git pull to complete
Start-Sleep -Seconds 2

# Reload the farm.ahk script with admin privileges
Start-Process -FilePath "C:\Users\oxi\Projects\RoyalsMods\farm.ahk" -Verb RunAs
