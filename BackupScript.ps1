### Valheim data backup script
### Backs up the entire appdata folder including characters/world data

## Note: If you get errors running the script, run the following:
## Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#**************************************************************************
## **************************CONFIGURATION ITEMS***************************
#**************************************************************************

# How many backups to keep before pruning older copies
$NumToKeep = 10

# Where to save backups
$BackupFolderPath = "F:\Share\ValheimBackups"

# Name of each unique backup file
$BackupName = Get-Date -Format "yyyyMMdd-HHmm"

# Server world file location
$Worldsavelocation = "C:\Users\cbarrett\AppData\LocalLow\IronGate\Valheim"

#**************************************************************************
## ***********************END OF CONFIGURATION ITEMS***********************
#**************************************************************************
#**************************************************************************
#**************************************************************************
#**************************************************************************
#**************************************************************************
#**************************************************************************

## Main Script


# Create the backup directory
If(!(test-path $BackupFolderPath))
{
      New-Item -ItemType Directory -Force -Path $BackupFolderPath
}

# Copy/Compress Valheim folder
foreach ($file in Get-ChildItem -Recurse "$Worldsavelocation")
{
  if ((get-date).AddMinutes(-5) -gt $file.CreationTime)
  {
  write-host Creating Archive at "$BackupFolderPath"
Compress-Archive -path "$Worldsavelocation" -destinationpath $BackupFolderPath\$BackupName.zip -Update 
break
  }
  else
  {
  write-host Server recently saved, waiting 5 minutes and taking backup.
  start-sleep -Seconds 300
  write-host Creating Archive at "$BackupFolderPath"
Compress-Archive -path "$Worldsavelocation" -destinationpath $BackupFolderPath\$BackupName.zip -Update
break
}

}

Write-host Backup complete you will find your backup compressed at "$BackupFolderPath" named $BackupName.zip

#Prune Backups
write-host pruning backups. You are keeping $NumToKeep  backups

Get-ChildItem "$BackupFolderPath" -Recurse| where{-not $_.PsIsContainer}| sort CreationTime -desc| select -Skip "$NumToKeep"| Remove-Item -Force

write-host pruning complete





