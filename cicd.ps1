# Define the file to watch
$fileToWatch = "C:\Users\Hamoon\Projects\RoyalsMods\farm.ahk"
$directoryToWatch = "C:\Users\Hamoon\Projects\RoyalsMods"

# Set up the FileSystemWatcher for the directory
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $directoryToWatch
$watcher.Filter = "farm.ahk"
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite

# Define the action to take when a change is detected
$action = {
    # Check if the changed file is the one we're interested in
    $filePath = $Event.SourceEventArgs.FullPath
    if ($filePath -eq $fileToWatch) {
        # Get current datetime for commit message
        $datetime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        Write-Host "farm.ahk file changed. Performing git operations..."

        # Change to the Git repository directory
        Set-Location "C:\Users\Hamoon\Projects\RoyalsMods"

        # Run Git commands
        git add .
        git commit -m "Auto-commit: $datetime"
        git push

        Write-Host "Git push completed."
    }
}

# Register the event
Register-ObjectEvent $watcher "Changed" -Action $action

# Start watching
$watcher.EnableRaisingEvents = $true

# Keep the script running
while ($true) { Start-Sleep 1 }
