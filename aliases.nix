{ ... }: {
    environment.shellAliases = {
        nixosrebuild = "sudo nixos-rebuild switch --flake ~/nixos-config"
    }
}