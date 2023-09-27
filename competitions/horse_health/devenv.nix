{ pkgs, config, ... }:

{
  packages = [
    # A native dependency of numpy
    pkgs.zlib
    pkgs.stdenv.cc.cc.lib
    pkgs.pam

    # A python dependency outside of poetry.
    config.languages.python.package.pkgs.pjsua2
  ];
  languages.python = {
    enable = true;
    poetry.enable = true;
  };
}
