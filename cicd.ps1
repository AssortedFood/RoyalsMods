# Define the directory to watch
$directoryToWatch = "C:\Users\Hamoon\Projects\RoyalsMods"
$debounceTime = 3  # Delay in seconds to prevent multiple triggers

# Set up the FileSystemWatcher for the directory
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $directoryToWatch
$watcher.Filter = "*.*"  # Watch all files in the directory
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite

# Define the action to take when a change is detected
$lastEventTime = Get-Date

$action = {
    $currentEventTime = Get-Date
    $timeDiff = ($currentEventTime - $lastEventTime).TotalSeconds

    # Only proceed if debounce time has passed
    if ($timeDiff -ge $debounceTime) {
        $lastEventTime = $currentEventTime

        # Get current datetime for commit message
        $datetime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        Write-Host "A file in RoyalsMods changed. Performing git operations..."

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
while ($true) { Start-Sleep 3 }
