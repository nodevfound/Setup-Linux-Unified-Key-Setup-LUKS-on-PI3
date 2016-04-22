# Setup-Linux-Unified-Key-Setup-LUKS-on-PI3
Setup Linux Unified Key Setup (LUKS) on Raspberry PI 3
(Reference: https://www.lisenet.com/2013/install-luks-and-create-an-encrypted-luks-partition-on-debian/)


Make sure partition is in Linux format <br>
<I>>fdisk -l /dev/sda</I>

Setup encryption on /dev/sda1 partition, password prompt will appear <br>
<I>>cryptsetup -v -y -c "aes-cbc-essiv:sha256" luksFormat /dev/sda1 </I>

Open the encrypted partition and create /dev/mapper/encdata <br>
<I>>cryptsetup luksOpen /dev/sda1 encdata </I>

Overwriting LUKS volume with zeros to ensure that outside world sees this as random data – it protects against disclosure of usage patterns. (iotop to monitor IO activity. Use it to monitor USB write speed: iotop -o) <br>
<I>>pv -tpreb /dev/zero | dd of=/dev/mapper/encdata bs=1M </I>

Create the ext4 filesystem and label the volume "data" <br>
<I>>mkfs.ext4 /dev/mapper/encdata -L data </I>

Create mount directory <br>
<I>>mkdir /data </I>

Mount the partition <br>
<I>>mount /dev/mapper/encdata /mnt/data </I>

Unmount and Close the LUKS volume <br>
<I>>umount /data </I> <br>
<I>>cryptsetup luksClose /dev/mapper/data </I><br>

<HR>
Mount encrypted partition<br>
<I>>cryptsetup luksOpen /dev/sda1 encdata </I><br>
<I>>mount /dev/mapper/encdata /data </I><br>

Unmount encrypted partition<br>
<I>>umount /dev/mapper/encdata /data </I><br>
<I>>cryptsetup luksClose /dev/sda1 encdata </I>
<HR>
