# Valheim-Backup-Script
This is a script that backs up Valheim personal and local files
Download the file and run it via Powershell. 
You can also edit the file with notepad (Notepad++ is better) and change the file saving locations. 
By default the files save in the same folder the Valheim files are saved in (%username%\AppData\LocalLow\IronGate\ValheimBackups)

## HOW TO USE THIS SCRIPT

You can run it each day at any point, or you can setup a scheduled task that backs up this data for you. This works both on dedicated servers and on local saves. 

Sample crontab:
`0 */4 * * * /home/vhserver/valheimBackup.sh`

## Modifiable Variables

### Windows

```
## Number of backups to keep before pruning (default: 10)
NumToKeep = 10

# Backup save location (default: C:\Users\(USERNAME)\Appdata\LocalLow\IronGate\ValheimBackups)
BackupFolderPath = "$env:USERPROFILE\AppData\LocalLow\IronGate\ValheimBackups"

# Backup name format (default: current date prepended)
BackupName = Get-Date -Format "yyyyMMdd-HHmm"

# Server world data location (default: C:\Users\(USERNAME)\Appdata\LocalLow\IronGate\Valheim)
$Worldsavelocation = "$env:USERPROFILE\AppData\LocalLow\IronGate\Valheim"
```

### Linux

```
Linux default settings have been pre-customized to suggested LinuxGSM dedicated server locations.

# Current user location (force set for crontab)
HOME=/home/vhserver

# Number of backups to keep before pruning (default: 10)
backupCount=10

# Backup save location (default: $HOME/ValheimBackups/)
backupLocation=$HOME/ValheimBackups/

# Server world data location (default: $HOME/.config/unity3d/IronGate/Valheim)
worldDir=$HOME/.config/unity3d/IronGate/Valheim
```
