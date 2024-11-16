{ pkgs, lib, ... }: {
# Set the system state version. This should not be changed after initial installation.
    

    system.stateVersion = "24.11";

    programs.ssh.extraConfig = ''
        Host eu.nixbuild.net
        PubkeyAcceptedKeyTypes ssh-ed25519
        ServerAliveInterval 60
        IPQoS throughput
        IdentityFile ~/.ssh/nixbuild
        '';

    programs.ssh.knownHosts = {
        nixbuild = {
            hostNames = [ "eu.nixbuild.net" ];
            publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
        };
    };

    # Reduces writes to hardware memory, which increases the lifespan
    # of an SSD.
    zramSwap.enable = true;
    zramSwap.memoryPercent = 150;

    # Needed for rebuilding on the Pi. You might not need this with more
    #memory, but my Pi only has 1GB.
    # swapDevices = [{
    #   device = "/swapfile";
    #   size = 2048;
    # }];
}
