# backup-with-restic
This repo includes a backup-script for a backup with restic.

Please refer https://restic.net/ for more details about restic itself.

Please don't excecute the script blindly.
Try to understand it and make changes for your backup-scenario.

Please make sure, that the "backups_restic.sh" file is excecutable.
(chmod +x backups_restic.sh should do the job)

I assume, that restic isn't installed. Therefore there is an variable "RESTIC_PATH" which should point to the self compiled excecutable.
If you've installed restic via the package manager, you could remove "$RESTIC_PATH/" from line 35.

Beside the script are two files with which you can control the files and folders you would like to backup.
They're controlled with "FILES_PATH" and "EXCLUDE_PATH".

All the other variables should be self explaining through my comments.

I'm using a temporary folder "TMP_PATH" in which I put files before the backup-process starts.
Examples are files which I copy from a remote-machine or a database-backup for my nextcloud.
The lines are commented out.
This folder will be removed after the backup-process.

Also a log will be written. It currently includes the date and time, when the backup finishes.

Please feel free to add additional features and make pull-requests.
