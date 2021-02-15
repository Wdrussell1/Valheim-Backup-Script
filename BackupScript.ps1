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
foreach ($file in Get-ChildItem "$BackupFolderPath")
{
  if ((get-date).AddMinutes(-5) -gt $file.CreationTime)
  {
Compress-Archive -path "$BackupFolderPath" -destinationpath "$BackupFolderPath\$BackupName".zip
  }
  else
  {
  start-sleep -Seconds 300
Compress-Archive -path "$BackupFolderPath" -destinationpath "$BackupFolderPath\$BackupName".zip

}
}

#Prune Backups
Get-ChildItem "$BackupFolderPath" -Recurse| where{-not $_.PsIsContainer}| sort CreationTime -desc| select -Skip "$NumToKeep"| Remove-Item -Force




