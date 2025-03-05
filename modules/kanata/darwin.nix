{ self, ... }: let
  kanataModule = self.outputs.nixosConfigurations.default.config.services.kanata;
  cfg = kanataModule.keyboards.drunkdeer.configFile;
in {
  xdg.configFile."kanata.kbd".text = cfg.text;
}
