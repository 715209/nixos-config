{ config, pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host  all       all     0.0.0.0/0   scram-sha-256
      host  all       all     ::1/128     scram-sha-256
    '';
  };
}

