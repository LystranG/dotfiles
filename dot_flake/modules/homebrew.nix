{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      # Preserve dependencies and any unclassified local state during migration.
      cleanup = "none";
    };

    taps = [
      "anomalyco/tap"
      "atomicjar/tap"
      "farion1231/ccswitch"
      "go-musicfox/go-musicfox"
      "laishulu/homebrew"
      "theboredteam/boring-notch"
    ];

    # Snapshot of formulae explicitly installed according to `brew leaves`.
    brews = [
      "anomalyco/tap/opencode"
      "ast-grep"
      "bat"
      "bitwarden-cli"
      "btop"
      "chezmoi"
      "cmake"
      "colima"
      "composer"
      "delve"
      "docker"
      "docker-buildx"
      "docker-compose"
      "eza"
      "fastfetch"
      "fd"
      "fzf"
      "ghostscript"
      "gnupg"
      "htop"
      "imagemagick"
      "iproute2mac"
      "jdtls"
      "jq"
      "julia"
      "knot"
      "kotlin"
      "kubernetes-cli"
      "laishulu/homebrew/macism"
      "lazygit"
      "luarocks"
      "mise"
      "neovim"
      "nmap"
      "ouch"
      "pandoc"
      "pcl"
      "rust"
      "syncthing"
      "tectonic"
      "the_silver_searcher"
      "tmux"
      "trash-cli"
      "tree"
      "utftex"
      "wget"
      "yq"
      "zimfw"
    ];

    casks = [
      "apifox"
      "appcleaner"
      "boring-notch"
      "cryptomator"
      "font-hanamin"
      "font-lxgw-wenkai"
      "font-maple-mono-nf-cn"
      "ghostty"
      "headlamp"
      "iina"
      "iterm2"
      "localsend"
      "mark-text"
      "obsidian"
      "raycast"
      "redis-insight"
      "snipaste"
      "squirrel-app"
      "syncthing-app"
      "tabby"
      "thaw"
      "thunderbird"
      "visual-studio-code"
    ];
  };
}
