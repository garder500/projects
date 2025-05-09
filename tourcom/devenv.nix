{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
     ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;
  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_20;
    corepack ={
      enable = true;
    };
  };
  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    initialDatabases = [
      { name = "mobile_users"; }
      { name = "mobile_agences"; }
    ];
    ensureUsers = [
       {
        name = "devenv";
        password = "devenv";
        ensurePermissions = {
          "*.*" = "ALL PRIVILEGES";
        };
      }
    ];


  };
  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';
  processes = {
    api-adhesion.exec = "cd ./api-adhesion/src && npm run dev";
    api-mobile-agence.exec = "cd ./api-tourcom-mobile/src && npm run dev";
    api-mobile-users.exec = "cd ./api-tourcom-users/src && npm run dev";
    front-adhesion.exec = "export NODE_OPTIONS=--openssl-legacy-provider && cd ./front-adhesion/src && npm run dev";
  };
  enterShell = ''
    hello
    git --version
    make
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
