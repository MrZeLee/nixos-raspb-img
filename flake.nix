{
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.05";
        nixos-generators = {
            url = "github:nix-community/nixos-generators";
            # inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-hardware = {
            url = "github:NixOS/nixos-hardware/master";
            # inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixos-generators,
        nixos-hardware,
        nixpkgs
    }@inputs:
    let
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
        packages = {
            aarch64-linux = {
                installer-sd-image = nixos-generators.nixosGenerate {
                    inherit specialArgs;
                    system = "aarch64-linux";
                    format = "sd-aarch64-installer";
                    modules = [
                        ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
                        ./modules/hardware-configuration.nix
                        ./modules/base.nix
                        ./modules/builder.nix
                        ./modules/networking.nix
                        ./modules/users.nix
                    ];
                };
            };
        };

        # Define the default package for aarch64-linux
        defaultPackage.aarch64-linux = self.packages.aarch64-linux.installer-sd-image;
    };
}
