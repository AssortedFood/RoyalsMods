# Define the directory to watch
$directoryToWatch = "C:\Users\Hamoon\Projects\RoyalsMods"
$debounceTime = 3  # Delay in seconds to prevent multiple triggers
$lastWriteTimes = @{}  # Store the last write time for each file

# Set up the FileSystemWatcher for the directory
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $directoryToWatch
$watcher.Filter = "*.*"  # Watch all files in the directory
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite

# Define the action to take when a change is detected
$action = {
    $filePath = $Event.SourceEventArgs.FullPath

    # Ignore changes to the .git directory itself
    if ($filePath -eq "C:\Users\Hamoon\Projects\RoyalsMods\.git") {
        return
    }

    $currentEventTime = Get-Date

    # Get the last write time for the file
    if ($lastWriteTimes.ContainsKey($filePath)) {
        $lastEventTime = $lastWriteTimes[$filePath]
    } else {
        $lastEventTime = (Get-Date).AddSeconds(-$debounceTime - 1)
    }

    $timeDiff = ($currentEventTime - $lastEventTime).TotalSeconds

    # Only proceed if debounce time has passed
    if ($timeDiff -ge $debounceTime) {
        # Update the last write time
        $lastWriteTimes[$filePath] = $currentEventTime

        # Get current datetime for commit message
        $datetime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        Write-Host "A file in RoyalsMods changed: $filePath. Performing git operations..."

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
