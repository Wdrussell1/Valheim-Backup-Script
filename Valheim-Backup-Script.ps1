### Valheim data backup script
#Created by Wdrussell1/Demon1337/Casey Barrett
### Backs up the entire appdata folder including characters/world data

## Note: If you get errors running the script, run the following:
## Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#**************************************************************************
## **************************CONFIGURATION ITEMS***************************
#**************************************************************************

# How many backups to keep before pruning older copies
$NumToKeep = 10

# Where to save backups (Default is C:\Users\(USERNAME)\Appdata\LocalLow\IronGate\ValheimBackups)
$BackupFolderPath = "$env:USERPROFILE\AppData\LocalLow\IronGate\ValheimBackups"

# Name of each unique backup file (This gets today's date and appends the file)
$BackupName = Get-Date -Format "yyyyMMdd-HHmmss"

# Server world file location (Default is C:\Users\(USERNAME)\Appdata\LocalLow\IronGate\Valheim)
$Worldsavelocation = "$env:USERPROFILE\AppData\LocalLow\IronGate\Valheim"

#**************************************************************************
## ***********************END OF CONFIGURATION ITEMS***********************
#**************************************************************************
#**************************************************************************
#*******************DO NOT MODIFY ANYTHING BEYOND THIS POINT***************
#**************************************************************************
#**************************************************************************
#**************************************************************************

## Main Script


# Create the backup directory
If(!(test-path $BackupFolderPath))
{
      New-Item -ItemType Directory -Force -Path $BackupFolderPath
}

## Copy/Compress Valheim folder
# Copy/Compress Worlds
foreach ($file in Get-ChildItem -Recurse "$Worldsavelocation/worlds")
{
  if ((get-date).AddMinutes(-5) -gt $file.CreationTime)
  {
  write-host Creating Archive at "$BackupFolderPath"
Compress-Archive -path "$Worldsavelocation/worlds" -destinationpath $BackupFolderPath\$BackupName.zip -Update 
break
  }
  else
  {
  write-host Server recently saved, waiting 5 minutes and taking backup.
  start-sleep -Seconds 300
  write-host Creating Archive at "$BackupFolderPath"
Compress-Archive -path "$Worldsavelocation/worlds" -destinationpath $BackupFolderPath\$BackupName.zip -Update
break
}

}
# Copy/Compress Characters adding them to the archive
foreach ($file in Get-ChildItem -Recurse "$Worldsavelocation/characters")
{
  if ((get-date).AddMinutes(-5) -gt $file.CreationTime)
  {
  write-host Creating Archive at "$BackupFolderPath"
Compress-Archive -path "$Worldsavelocation/characters" -destinationpath $BackupFolderPath\$BackupName.zip -Update 
break
  }
  else
  {
  write-host Server recently saved, waiting 5 minutes and taking backup.
  start-sleep -Seconds 300
  write-host Creating Archive at "$BackupFolderPath"
Compress-Archive -path "$Worldsavelocation/characters" -destinationpath $BackupFolderPath\$BackupName.zip -Update
break
}

}

Write-host Backup complete you will find your backup compressed at "$BackupFolderPath" named $BackupName.zip

#Prune Backups
write-host pruning backups. You are keeping $NumToKeep  backups

Get-ChildItem "$BackupFolderPath" -Recurse -Include *.zip| where{-not $_.PsIsContainer}| sort CreationTime -desc| select -Skip "$NumToKeep"| Remove-Item -Force

write-host pruning complete
