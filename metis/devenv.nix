{ pkgs, lib, config, inputs, ... }:

{
  # Définir une variable d'environnement
  env.GREET = "devenv";

  # Inclure uniquement les packages nécessaires
  packages = [
    pkgs.git
    pkgs.tmux
  ];

  # Activer JavaScript (Node.js sera automatiquement utilisé)
  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_18;
    corepack ={
      enable = true;
    };
  };

  processes = {
    aerial-api.exec = "cd ./api-aerial/src && npm run dev";
    dashboard-api.exec = "cd ./api-dashboard/src && npm run dev";
    front-resa.exec = "cd ./front-reservation/src && npm run dev";
  };

  # Script personnalisé
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  # Commandes à exécuter lors de l'entrée dans le shell
  enterShell = ''
    hello
    git --version
    make
  '';

  # Commandes pour les tests
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';
}
