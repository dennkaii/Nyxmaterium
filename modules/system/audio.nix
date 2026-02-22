{
  dandelion.modules.audio = {lib, ...}: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      audio.enale = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };
    services.pulseaudio.enable = lib.mkForce false;
  };
}
