{ lib, config, pkgs, inputs, ... }: {
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      vulkan-validation-layers
    ];
  };

  environment.systemPackages = with pkgs; [
    glxinfo
    clinfo
    virtualglLib
    vulkan-loader
    vulkan-tools
  ];

  services.xserver.videoDrivers = ["nvidia"];
  services.displayManager.sddm.wayland.enable = lib.mkForce false;
  services.xserver.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaPersistenced = true;

    powerManagement.enable = true;
    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
}

