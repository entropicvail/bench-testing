dd if=/dev/zero of=encrypted.img bs=1 count=0 seek=10M;
sudo cryptsetup luksFormat encrypted.img;
sudo cryptsetup luksOpen encrypted.img myEncryptedVolume;
sudo mkfs.ext4 /dev/mapper/myEncryptedVolume;
mkdir Private;
sudo mount /dev/mapper/myEncryptedVolume ~/Private;
sudo umount $HOME/Private;
sudo cryptsetup luksClose myEncryptedVolume;
sudo cryptsetup luksAddKey encrypted.img;
sudo cryptsetup luksDump encrypted.img;
#dd if=encrypted.img of=header.luks bs=512 count=4097;
sudo rm -d ~/Private;
#sudo rm ~/encrypted.img;

