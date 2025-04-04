{ lib, pkgs, ... }:
{
  services.nomad = {
    enable = true;

    # Add extra plugins to Nomads plugin directory.
    # extraSettingsPlugins = [ pkgs.nomad-driver-podman ];

    # Add Docker driver.
    # enableDocker = true;

    # Nomad as Root to access Docker/Podman sockets.
    # dropPrivileges = false;

    # Nomad configuration, as Nix attribute set.
    settings = {
      client.enabled = true;
      server = {
        enabled = true;
        bootstrap_expect = 1;
      };
      # plugin = [{
      #   nomad-driver-podman = {
      #     config = { };
      #   };
      # }];
    };
  };

  # I don't Nomad starting when the system boots.
  systemd.services.nomad.wantedBy = lib.mkForce [ ];

  # # Handy packages
  # environment.systemPackages = with pkgs; [
  #   nomad-driver-podman # Podman driver plugin.

  #   damon # TUI for Nomad.
  # ];
}

