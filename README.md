# Valheim-Backup-Script
This is a script that backs up Valheim personal and local files
Download the file and run it via Powershell. 
You can also edit the file with notepad (Notepad++ is better) and change the file saving locations. 
By default the files save in the same folder the Valheim files are saved in (%username%\AppData\LocalLow\IronGate\ValheimBackups)

HOW TO USE THIS SCRIPT: You can run it each day at any point, or you can setup a scheduled task that backs up this data for you. This works both on dedicated servers and on local saves. 



Modifiable variables in the script:


# How many backups to keep before pruning older copies (Default is 10)
$NumToKeep = 10

# Where to save backups (Default is C:\Users\(USERNAME)\Appdata\LocalLow\IronGate\ValheimBackups)
$BackupFolderPath = "$env:USERPROFILE\AppData\LocalLow\IronGate\ValheimBackups"

# Name of each unique backup file (This gets today's date and appends the file)
$BackupName = Get-Date -Format "yyyyMMdd-HHmm"

# Server world file location (Default is C:\Users\(USERNAME)\Appdata\LocalLow\IronGate\Valheim)
$Worldsavelocation = "$env:USERPROFILE\AppData\LocalLow\IronGate\Valheim"




NOTES: LINUX VERSION MAY COME AS WELL
