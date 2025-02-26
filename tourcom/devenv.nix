{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.nodejs
    pkgs.tmux
     ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;
  languages.javascript.enable = true;
  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';
  processes = {
    api-adhesion.exec = "cd ./api-adhesion/src && npm run dev";
    api-mobile-agence.exec = "cd ./api-tourcom-mobile/src && npm run dev";
    api-mobile-users.exec = "cd ./api-tourcom-users/src && npm run dev";
    front-adhesion.exec = "cd ./front-adhesion/src && npm run dev";
  };
  enterShell = ''
    hello
    git --version
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
