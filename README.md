# nixos-raspb-img

## Credits

This project was inspired by and follows the guide from: [NixOS Raspberry Pi Headless Setup by Mukund
Agrawal](https://blog.yaymukund.com/posts/nixos-raspberry-pi-nixbuild-headless/)

## Build Process

The Raspberry Pi NixOS image was created using an external builder (`eu.nixbuild.net`) because the build requires an `aarch64-linux` system. The following
command was used to build the image:

```bash
nix build --builders "ssh://root@eu.nixbuild.net?ssh-key=$HOME/.ssh/nixbuild aarch64-linux - 100 1 big-parallel,benchmark"\
    --max-jobs 0 \
    --system aarch64-linux \
    --option keep-failed true \
    --option build-cores 0

zstd \
    -d result/sd-image/*.img.zst \
    -o installer-sd-image.img

diskutil unmountDisk /dev/diskN
sudo dd \
    if=..path/to/installer-sd-image.img \
    of=/dev/diskN \
    status=progress bs=1M
diskutil eject /dev/diskN
```

### Build Details
- External Builder: `eu.nixbuild.net`
- System Architecture: `aarch64-linux`
- SSH Key Authentication Used
- Configured for maximum build flexibility and debugging
```
