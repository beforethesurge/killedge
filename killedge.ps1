while ($true) {
    $currentTime = Get-Date
    if ($currentTime.Hour -eq 19 -and $currentTime.Minute -eq 0) {
        # Command to run
        Stop-Process -Name "msedge"
        # Wait for a minute to avoid running the script multiple times within the same minute
        Start-Sleep -Seconds 60
    }

    if ($currentTime.Hour -eq 9 -and $currentTime.Minute -eq 0) {
        # Specify folder for applications
        $folderPath = "FOLDEROFPWAS"
        # Check if folder exists
        if (Test-Path $folderPath) {
            # Get all .lnk (shortcut) files in the folder
            $shortcuts = Get-ChildItem -Path $folderPath -File -Filter "*.lnk"
            # Loop through each shortcut and start it
            ForEach ($shortcut in $shortcuts) {
                try {
                    # Start the shortcut (resolve full path of shortcut)
                    Start-Process -FilePath $shortcut.FullName
                } catch {
                    Write-Host "Error starting $($shortcut.FullName): $_"
                }
            }
        } else {
            Write-Host "Folder not found: $folderPath"
        }
        # Wait for a minute to avoid running the script multiple times within the same minute
        Start-Sleep -Seconds 60
    }
    # Check the time every 30 seconds
    Start-Sleep -Seconds 30
}
