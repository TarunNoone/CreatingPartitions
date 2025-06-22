# Creating blank disk image
- Default sector size is 512 Bytes
```shell
dd if=/dev/zero of=disk.img bs=512 count=1
```

## Adding MBR to the empty disk image
```shell
fdisk disk.img
```
- This opens an interactive command that helps creating paritions
- As soon as an empty file is opened, fdisk adds the MBR.
- It doesn't write it automatically, so select write option.

## Creating partitions
- The fdisk utility has dialog to help creating paritions.
- It should be automatically updating the parition information in the MBR's Partition Table
- At this point the MBR is populated with Partition Table.
- The partitions themselves are empty.

### Attach the disk.img as a Loop Device
```shell
sudo losetup -f -P disk.img
```

### Check the loop device number
```shell
losetup -a | grep disk.img
```

### Confirm the attached loop device has the partitions
This will attach the individual partitions, which can be confirmed with any of the following commands
```shell
sudo fdisk -l /dev/loopX
ls /dev/loopX* # Star is needed here.
lsblk /dev/loopX # This is better since it shows the mount points, if it was mounted.
```

### Dettach the Loop Device (once you are done with it)
```shell
sudo umount /mnt # in-case the device was also mounted using commands in next steps
sudo losetup -d /dev/loopX
```

## Format as partition
- Make sure the disk.img is attached as a loop device

```shell
sudo mkfs.fat -F 12 /dev/loop<X>p<N> # Ex: /dev/loop21p1
```

## Accessing the file system in a partition

```shell
sudo mdir -i /dev/loop<X>p<N>
```

## Mount the partition

```shell
sudo mount /dev/loop21p1 /mnt
```

## Unmount the parition
```shell
sudo umount /mnt
```

