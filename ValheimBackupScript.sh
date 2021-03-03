HOME=/home/vhserver
# How many backups to keep before pruning older copies (Default is 10)
backupCount=10
# Where to save backups (Default is $HOME/ValheimBackups/)
backupLocation=$HOME/ValheimBackups/
# Server world file location (Default is $HOME/Valheim)
worldDir=$HOME/.config/unity3d/IronGate/Valheim

format_date() {
  date "+%Y-%m-%d-%H-%M-%S"
}

#Create the backup folder should it not exist
if [[ ! -d $backupLocation ]]
then
  echo "Creating $backupLocation."
  mkdir -p $backupLocation
fi

#Put current date and time in the file name saving the TAR/ZIP in the file location you requested.
tar -czvf $backupLocation/$(format_date).tar.gz $worldDir

#Because linux..we have to add 1 to the backupCount variable
Sum=`echo "$backupCount + 1" | bc`

#Removing old backups
ls -dt $HOME/ValheimBackups/* | tail -n +$Sum | xargs rm -rf
