{ config, lib, pkgs, ... }:

{
  services.k3s = {
    enable = true;
    package = pkgs.k3s_1_28;
    role = "agent";
    token = ""; # Replace this with a secure token
    clusterInit = false; # This node will be the first control plane node
    serverAddr = "https://192.168.xxx.xxx:6443";
    extraFlags = "--flannel-iface=eth0 --node-ip=192.168.xxx.xxx";
  };

  # Optional: Install useful kubernetes tools
  environment.systemPackages = with pkgs; [
    kubectl
    nfs-utils
    openiscsi
    jq
    dig
  ];

  services.openiscsi = {
    enable = true;
    name = "${config.networking.hostName}-initiatorhost";
  };

  # HACK: Symlink binaries to /usr/local/bin such that Longhorn can find them
  # when they use nsenter.
  # https://github.com/longhorn/longhorn/issues/2166#issuecomment-1740179416
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];

  boot.supportedFilesystems = [ "nfs" ];
  services.rpcbind.enable = true;
}

