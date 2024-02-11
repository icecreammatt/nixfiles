{...}: {
  services.hydra = {
    enable = true;
    port = 3050;
    notificationSender = "hydra@localhost"; # e-mail of hydra service
    hydraURL = "http://localhost:3050";
    # buildMachinesFiles = [];
    useSubstitutes = true;
  };

  nix.buildMachines = [
    {
      hostName = "localhost";
      system = "x86_64-linux";
      supportedFeatures = [];
      maxJobs = 8;
    }
  ];
}
