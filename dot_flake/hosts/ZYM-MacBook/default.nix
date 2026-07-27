{
  lib,
  username,
  ...
}:
{
  imports = [
    ../../modules/homebrew.nix
  ];

  system.stateVersion = 7;

  # Keep shell configuration in chezmoi; nix-darwin only registers the shell.
  programs.zsh.enable = true;

  homebrew.user = username;

  # Run after Homebrew and Home Manager activation so Brew's mise reads the
  # newly generated global configuration as the normal user.
  system.activationScripts.postActivation.text = lib.mkAfter ''
    if [ -x /opt/homebrew/bin/mise ]; then
      echo >&2 "Installing declared mise tools..."
      sudo \
        --user=${lib.escapeShellArg username} \
        --set-home \
        env XDG_CONFIG_HOME=/Users/${username}/.config \
        /opt/homebrew/bin/mise install --yes
    else
      echo >&2 "warning: /opt/homebrew/bin/mise is unavailable; mise tools were not installed"
    fi
  '';
}
