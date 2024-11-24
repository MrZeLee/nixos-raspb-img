{
  users.users.mrzelee = {
    isNormalUser = true;
    home = "/home/mrzelee";
    extraGroups = [
      "wheel"
      "networkmanager"
      "gpio"
      "audio"
      "video"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2gO7UAKfjRE2uApIneVTMLCpZxL3QkTPTcipAzm3IjTlrjvzvzyXs0+Y0QEFEK9CImH/ZYMBVzb3yJM9o/KeDThbuzfGWP4q18ZVUHvtsPdrNNu/AxUIqhsw+462SGwdju13TnlgXmPfg8bVYHVnJBwXtW/5lZ8lIEZpDHTv2lU3wvOgn3YRVjd8FdfDVGBiad1O6JQEZY7v9BDrg8ynugK4pyt2EViZvaTwQMuZC3EPuDtdrzhCm1oSWPFnA6KEb7musy+0/zR/aV2ewg4Ouy8E69aWiuSV8DPzgVFKT7sj5zEOH8Ouq0AzElQl8XQoJLPHSHFM4qeQE3pAvokFoJAc+I9Wi1ht/PSvZxdiCSAVXT2L9X4G7IN4i4BWaDaEwIFYv9tmxN+DkC6sWWNXNmMSmOJVdisT7GLhvRY70CZgOChg0DBWrcVAynrh6HpRfjQGKi7huHoPxey4YG15+ByKiM25Vi3nRBYwrstsLdVS4SAuoIS4dV8XJ9JVSrFX/fdWRxcjKMcFDgqwzClQ6rmQdqCHkZeTV9CqnehntP3AvVM6xM5bXK4TppJVxE6iJpSBUc01fe0qJLplztYlBeqMZmjdEa/nPjZZMQFE/0TNURI7oCFAGzMgHnxzbLnmSTNjZMi4YpA2BdXREkUh6Cm9UiXAiCjsRoGDaVR0fRw== josel@DESKTOP-JOSE" # public key
    ];
  };

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  # don't require password for sudo
  security.sudo.extraRules = [{
    users = [ "mrzelee" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  services.sshd.enable = true;
  # And expose via SSH
  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
  services.timesyncd.enable = true;
  # services.getty.autologinUser = "mrzelee";
}
