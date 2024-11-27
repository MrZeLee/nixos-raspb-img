{ ... }: {
  # Setup wifi
  networking = {
    hostName = "hostName";
    wireless.enable = false;
    useDHCP = false;
    nameservers = [ "8.8.8.8" "8.8.4.4" ]; # Add reliable public DNS servers
    defaultGateway = {
      address = "192.168.xxx.xxx";
      interface = "eth0";
    };
    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.xxx.xxx";
        prefixLength = 23;
      } 
    ];
    # interfaces.wlan0.useDHCP = true;
    # wireless.networks = {
    #   my_ssid.pskRaw = "...";
    # };
    usePredictableInterfaceNames = false;
    firewall.enable = false;
  };


}
