{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.envision = {
    enable = true;
    package = pkgs.envision.overrideAttrs (old: {
      targetPkgs =
        (old.targetPkgs or [])
        ++ (with pkgs; [
          bc
          fmt
          git-lfs
          gtest
          jq
          lz4
          tbb
        ]);
    });
  };
}
