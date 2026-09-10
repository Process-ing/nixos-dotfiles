{
  flake.modules.nixos.brunol-server = {
    disko.devices = {
      disk = {
        main = {
          device = "/dev/sda";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                type = "EF00";
                size = "500M";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              root = {
                end = "-4G"; # Swap size
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
              swap = {
                size = "100%";
                content = {
                  type = "swap";
                  discardPolicy = "both";
                  resumeDevice = true;
                };
              };
            };
          };
        };
        hdd1 = {
          device = "/dev/sdb";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              mdadm = {
                size = "100%";
                content = {
                  type = "mdraid";
                  name = "raid1";
                };
              };
            };
          };
        };
        hdd2 = {
          device = "/dev/sdc";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              mdadm = {
                size = "100%";
                content = {
                  type = "mdraid";
                  name = "raid1";
                };
              };
            };
          };
        };
      };
      mdadm = {
        raid1 = {
          type = "mdadm";
          level = 1;
          content = {
            type = "gpt";
            partitions = {
              primary = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/mnt/raid1";
                };
              };
            };
          };
        };
      };
    };
  };
}
