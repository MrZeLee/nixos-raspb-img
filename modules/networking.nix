{ ... }: {
  # Setup wifi
  networking = {
    hostName = "raspb4";
    wireless.enable = false;
    useDHCP = true;
    interfaces.wlan0.useDHCP = true;
    # wireless.networks = {
    #   my_ssid.pskRaw = "...";
    # };
    usePredictableInterfaceNames = false;
  };


}
