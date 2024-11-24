{ config, lib, pkgs, ... }:

{
  services.k3s = {
    enable = true;
    role = "agent";
    token = "your-secret-token-here"; # Replace this with a secure token
    clusterInit = false; # This node will be the first control plane node
  };

  # Optional: Install useful kubernetes tools
  environment.systemPackages = with pkgs; [
    kubectl
  ];
}
