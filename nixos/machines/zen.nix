# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/home/philm/dev/personal/dotfiles/nixos/machines/zen.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ../configuration.nix
  ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usbhid" "uas" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.firmware = [ pkgs.wireless-regdb ];
  networking.hostName = "zen";

  networking.interfaces.enp38s0.useDHCP = true;
  networking.interfaces.enp39s0.useDHCP = true;
  # This interface has some issues currently see https://github.com/NixOS/nixpkgs/issues/85377
  # networking.interfaces.wlo1.useDHCP = true;

  services.xserver = {
    dpi = 110;
    screenSection = ''
      DefaultDepth 24
      Option "RegistryDwords" "PerfLevelSrc=0x3322; PowerMizerDefaultAC=0x1"
      Option "TripleBuffer" "True"
      Option "Stereo" "0"
      Option "nvidiaXineramaInfoOrder" "DFP-0"
      Option "metamodes" "DP-0: nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-2: nvidia-auto-select +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      Option "SLI" "Off"
      Option "MultiGPU" "Off"
      Option "BaseMosaic" "off"
    '';
    videoDrivers = [ "nvidia" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f49d8556-ac03-4140-a879-5af144d7e81d";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/775E-7F47";
    fsType = "vfat";
  };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 32;
  # High-DPI console
  console.font =
    lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
}
