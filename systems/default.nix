{
  config,
  specialArgs,
}:
let
  hostname = specialArgs.hostname;
in
{
  imports = [
    ./${hostname}
    ../core
  ];
}
