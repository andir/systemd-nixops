{
  server = {
    nixops.enableDeprecatedAutoLuks = true;
    deployment.targetEnv = "libvirtd";

    fileSystems."/secret" = {
      device = "/dev/mapper/secretdisk";
      options = [ "noexec" "invalidoption" ];
      ec2.size = 20;
      ec2.encrypt = 42;
      ec2.volumeType = "gp2";
    };


    deployment.autoLuks = {
      secretdisk = {
        device = "/dev/vda";
        passphrase = "foobar";
        autoFormat = true;
        mountPoint = "/secret";
      };
    };
    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrIv08Dm5599TMn/3lMSeG5FQJSQpHVlDw7GgZcRZBY andi@x220"
    ];

    systemd.services.sshd = {
      requires = [ "systemd-logind.service" ];
    };
  };
}
