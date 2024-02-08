### Valheim data backup script
#Created by Wdrussell1/Demon1337/Casey Barrett
### Backs up the entire appdata folder including characters/world data
## Note: If you get errors running the script, run the following:
## Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#**************************************************************************
## **************************CONFIGURATION ITEMS***************************
#**************************************************************************
# How many backups to keep before pruning older copies (Default is 10)
NumToKeep=10
# Where to save backups (Default is $HOME/ValheimBackups/)
BackupFolderPath=$HOME/ValheimBackups/
# Server world file location (Default is $HOME/Valheim)
Worldsavelocation=$HOME/Valheim
#**************************************************************************
## ***********************END OF CONFIGURATION ITEMS***********************
#**************************************************************************
#**************************************************************************
#*******************DO NOT MODIFY ANYTHING BEYOND THIS POINT***************
#**************************************************************************
#**************************************************************************
#**************************************************************************
## Main Script
#Create the backup folder should it not exist
if [[ ! -d $BackupFolderPath ]]
then
    echo "$BackupFolderPath does not exist on your filesystem."
	mkdir $BackupFolderPath
fi
#
#Get current date and time
Date=$(date +%Y-%m-%d-%H-%M-%S)
#
#Put current date and time in the file name saving the TAR/ZIP in the file location you requested.
tar -czvf $BackupFolderPath$Date.tar.gz $Worldsavelocation
#
#
##Parsing backups 
#Because linux..we have to add 1 to the NumToKeep variable
Sum=`echo "$NumToKeep + 1" | bc`
#
#Removing old backups
ls -dt $HOME/ValheimBackups/* | tail -n +$Sum | xargs rm -rf *.tar.gz
#
#
