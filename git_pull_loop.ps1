# Define the repository directory
$repositoryPath = "C:\Users\oxi\Projects\RoyalsMods"

# Function to perform a Git pull
function Invoke-GitPull {
    try {
        # Change to the Git repository directory
        Set-Location $repositoryPath

        # Perform git pull
        git pull

        Write-Host "Git pull completed at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    } catch {
        Write-Host "An error occurred during git pull: $_"
    }
}

# Infinite loop to keep pulling changes
while ($true) {
    # Call the Git pull function
    Invoke-GitPull

    # Wait for 5 seconds before the next pull
    Start-Sleep -Seconds 5
}
