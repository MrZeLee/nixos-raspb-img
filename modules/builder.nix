{
    nix.settings = {
        trusted-users = [ "mrzelee" ];
        builders-use-substitutes = true;
    };

    nix = {
        distributedBuilds = true;
        buildMachines = [
        { hostName = "eu.nixbuild.net";
            system = "aarch64-linux";
            sshUser = "root";
            sshKey = "/home/mrzelee/.ssh/nixbuild";
            maxJobs = 100;
            supportedFeatures = [ "benchmark" "big-parallel" ];
        }
        ];
    };

}
