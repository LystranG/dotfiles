{
  lib,
  ...
}:
{
  home = {
    username = "lystran";
    homeDirectory = "/Users/lystran";
    stateVersion = "26.05";
  };

  programs.mise = {
    enable = true;
    # Brew remains the sole owner of the mise executable.
    package = null;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableNushellIntegration = false;
    enableZshIntegration = false;

    globalConfig = {
      tools = {
        bun = "latest";
        gh = "latest";
        go = "latest";
        gradle = "9.5.1";
        helm = "latest";
        java = "zulu-25";
        k9s = "latest";
        maven = "3.9.15";
        mvnd = "1.0.5";
        node = "lts";
        "npm:@github/copilot" = "latest";
        "npm:@mermaid-js/mermaid-cli" = "latest";
        "npm:@openai/codex" = "latest";
        "npm:cross-env" = "latest";
        "npm:get-shit-done-cc" = "latest";
        "npm:picgo" = "latest";
        "npm:skills" = "latest";
        "npm:vercel" = "latest";
        "pipx:serena-agent" = "latest";
        python = "latest";
        rtk = "latest";
        uv = "latest";
      };

      settings.minimum_release_age = "0";
    };
  };

  # Adopt the existing unmanaged file after generating equivalent content.
  xdg.configFile."mise/config.toml".force = lib.mkForce true;

  programs.home-manager.enable = true;
}
