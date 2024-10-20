# Navigate to the project directory and run git pull
Set-Location "C:\Users\oxi\Projects\RoyalsMods"
git pull

# Reload the farm.ahk script with admin privileges
Start-Process -FilePath "C:\Users\oxi\Projects\RoyalsMods\farm.ahk" -Verb RunAs
# need to add the rest of the scripts here