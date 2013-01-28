#!/usr/bin/env bash
#mounting encrypted volumes using tcplay

user=curtiss
cryptdev=enc_fs
cryptpath=/home/curtiss/Dropbox/test.txt
loopdev=$(losetup -f)
mountpt=/home/curtiss/enc_fs

#must be run as root
if [[ $EUID != 0 ]]; then
	printf "%s\n" "You must be root to run this."
	exit 1
fi

if [[ "$1" == "open" ]];then
    # unencrypt and mount container
	losetup "$loopdev" "$cryptpath"
	tcplay --map="$cryptdev" --device="$loopdev"

	# read passphrase
	read -r -s passphrase <<EOF
	"$passhrase"
EOF

	#mount container
	[[ -d "$mountpt" ]] || mkdir "$mountpt"

	# mount options
	userid=$(awk -F"[=(]" '{print $2,$4}' <(id "$user"))
	mount -o nosuid,uid="${userid% *}",gid="${userid#* }" -t vfat /dev/mapper/$cryptdev "$mountpt"

	# close and clean up
elif [[ "$1" == "close" ]]; then
	device=$(awk -v dev=$cryptdev -F":" '/dev/ {print $1}' <(losetup -a))
	umount "$mountpt"
	dmsetup remove "$cryptdev" || printf "%s\n" "demapping failed"
	losetup -d "$device" || printf "%s\n" "deleting $loopdev failed"
else
	printf "%s\n" "Options are open and close"
fi
