{
  flake.modules.homeManager.distrobox-path = {
    # Add additional folders to path, to be able to use some commands inside containers
    home.sessionPath = [
      "/opt/gradle/gradle-9.7.1/bin"
    ];
  };
}