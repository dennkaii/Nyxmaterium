{inputs, ...}: {
  imports = [inputs.asus-dialpad-driver.nixosModules.default];
  services.asus-dialpad-driver = {
    enable = true;
    layout = "proartp16";
    wayland = true;
    waylandDisplay = "wayland-1";
    config.main = {
      enabled = false;
      slices_count = 3;
      disable_due_inactivity_time = 5;
      touchpad_disables_dialpad = true;
      activation_time = 0.5;
    };
  };
}
