{config, pkgs, lib, ...}: let
  cfg = config.server.minecraft;
  inherit (pkgs) linkFarmFromDrvs fetchurl;
in {
  options.server.minecraft = lib.mkEnableOption "minecraft related services, to host an smp.";
  config = lib.mkIf cfg {
    environment.systemPackages = [pkgs.tmux];
    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
      servers.smp = {
        enable = true;
        autoStart = true;
        package = pkgs.minecraftServers.fabric-1_21_1.override {
	  jre_headless = pkgs.graalvm-ce;
	};

        whitelist = {
          jsuwu = "cbd3ea51-2acb-4b8c-b8b7-222f9914816f";
          Yologekkie08 = "84236ecc-a29e-4309-862d-3283472519fe";
        };
        serverProperties = {
          white-list = true;
          view-distance = 12;
          difficulty = "hard";
          force-gamemode = true;
          motd = "Mental asylum (the game)";
        };
          
        symlinks = {
          "allowed_symlinks.txt" = pkgs.writeText "allowed_symlinks.txt" "/nix/store";
          mods = pkgs.linkFarmFromDrvs "mods" (let
            inherit (pkgs) fetchurl;
          in builtins.attrValues {
	    Lithium = fetchurl {url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/5szYtenV/lithium-fabric-mc1.21.1-0.13.0.jar"; sha512 = "d4bd9a9cc37daad8828aa4fa9ca20e4f89d10e30cf6daf4546ef4cf4a684ba21ea0865a9c23cef9d1f4348e9ba4aca9aaca3db9f99534fc610fa78a5ca0bf151";};
	    FerriteCore = fetchurl {url = "https://cdn.modrinth.com/data/uXXizFIs/versions/wmIZ4wP4/ferritecore-7.0.0-fabric.jar"; sha512 = "0f2f9b5aebd71ef3064fc94df964296ac6ee8ea12221098b9df037bdcaaca7bccd473c981795f4d57ff3d49da3ef81f13a42566880b9f11dc64645e9c8ad5d4f";};
	    ModernFix = fetchurl {url = "https://cdn.modrinth.com/data/nmDcB62a/versions/T1ftCUJv/modernfix-fabric-5.19.3%2Bmc1.21.1.jar"; sha512 = "36b4fa178e73b7eef5f42df619e67fe71307fafce8b1582acb11c36ad6792fafe88870d74e178898824ede405bd0873a8b00460f6507bdf87be9cfb6353edc7d";};
	    Chunky = fetchurl {url = "https://cdn.modrinth.com/data/fALzjamp/versions/dPliWter/Chunky-1.4.16.jar"; sha512 = "7e862f4db563bbb5cfa8bc0c260c9a97b7662f28d0f8405355c33d7b4100ce05378b39ed37c5d75d2919a40c244a3011bb4ba63f9d53f10d50b11b32656ea395";};
	    CCME = fetchurl {url = "https://cdn.modrinth.com/data/VSNURh3q/versions/dnzpqH8Z/c2me-fabric-mc1.21.1-0.3.0%2Balpha.0.206.jar"; sha512 = "b227e09ea53e7ce472219235efd6c09e7d9fa87708030a9079cf4332e9ce604e660da55da89f31665534fa376d2d8763eae119295910b746c8366f12ecd97554";};
	    LetMeDespawn = fetchurl {url = "https://cdn.modrinth.com/data/vE2FN5qn/versions/BCokhlwI/letmedespawn-1.3.1.jar"; sha512 = "20f38f8fa66675094ccf0bccca1c13863e2056dfa02f2efc4a2efd12cf47340f9395601b2c58a429be6e16b6ad0aaa449566053379bb1f5a0891f635801dd260";};
	    Noisium = fetchurl {url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/4sGQgiu2/noisium-fabric-2.3.0%2Bmc1.21-1.21.1.jar"; sha512 = "606ba78cf7f30d99e417c96aa042f600c1b626ed9c783919496d139de650013f1434fcf93545782e3889660322837ce6e85530d9e1a5cc20f9ad161357ede43e";};
	    AlternateCurrent = fetchurl {url = "https://cdn.modrinth.com/data/r0v8vy1s/versions/78P98rac/alternate-current-mc1.21-1.9.0.jar"; sha512 = "8b2899de60af229e911bf45d10f71e624910e8df555aad94cb4e590f052ca5dae102f366a883a0c17a3821fbb086c587b5b9286b70502c09d51f4d60dd02ab77";};
	    Ksyxis = fetchurl {url = "https://cdn.modrinth.com/data/2ecVyZ49/versions/QFfBwOwT/Ksyxis-1.3.2.jar"; sha512 = "dde5310b59efdd98f0af3c687e14ad5de9207296a1e0003e2e07fccc090b6351fe5769237b1d9e666686521eba91fa4ebcb7cd5a085f805f524385e379ed72cc";};
	    Slumber = fetchurl {url = "https://cdn.modrinth.com/data/ksm6XRZ9/versions/mPf1P26X/slumber-1.2.0.jar"; sha512 = "b7db00573440d64a8275f1a63a492eba00bb2575c460e05ea27e7bf63cfc2591a4b3dc913805c26fdbea1f959ff247d3532b433afef09a5fb4317ed2ce1dce14";};
	    # x = fetchurl {url = ""; sha512 = "";
          });
        };
      };
    };
  };
}
