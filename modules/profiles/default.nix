{self, ...}: {
  dandelion.profiles.default = {
    imports = [
      #undetected
      self.dandelion.modules.undetected
    ];
  };
}
