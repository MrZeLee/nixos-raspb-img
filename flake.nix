{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixos-generators
    , nixos-hardware
    , nixpkgs
    }@inputs:
    let
      system = "aarch64-linux";
      overlays = [
        (final: super: {
          makeModulesClosure = x:
            super.makeModulesClosure (x // { allowMissing = true; });
        })
      ];
      specialArgs = {
        inherit nixos-hardware inputs;
      };
    in
    {
      nixosConfigurations = {
        mrzelee = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = system;
          modules = [
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = overlays;
              environment.systemPackages = with pkgs; [
                neovim
                vim
                git
                hello
              ];
            })
            ./modules/hardware-configuration.nix
            ./modules/base.nix
            ./modules/builder.nix
            ./modules/networking.nix
            ./modules/users.nix
            # ./modules/k3s.nix

            # Anything else you like...
          ];
        };

        # # Additional node configuration
        # mrzelee-node2 = nixpkgs.lib.nixosSystem {
        #   inherit specialArgs;
        #   system = system;
        #   modules = [
        #     ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
        #     ./modules/hardware-configuration.nix
        #     nixos-hardware.nixosModules.raspberry-pi-4
        #     ./modules/base.nix
        #     ./modules/networking.nix
        #     ./modules/users.nix
        #     # Custom k3s configuration for the second node
        #     {
        #       services.k3s = {
        #         enable = true;
        #         role = "server";  # or "agent" if you want it to be a worker node
        #         token = "your-secret-token-here";  # Use the same token as the first node
        #         serverAddr = "https://FIRST_NODE_IP:6443";  # Replace FIRST_NODE_IP with actual IP
        #       };
        #       # Same firewall rules as the first node
        #       networking.firewall.allowedTCPPorts = [ 6443 10250 ];
        #       networking.firewall.allowedUDPPorts = [ 8472 ];
        #     }
        #   ];
        # };

        # If you need a default package, define it here
        packages.${system} = {
          # Add your packages here
        };
      };
    };
}
