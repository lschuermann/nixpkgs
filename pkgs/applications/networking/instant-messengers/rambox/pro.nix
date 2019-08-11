{ autoPatchelfHook, electron, fetchurl, makeDesktopItem, makeWrapper, nodePackages, nss, stdenv, xdg_utils, xorg }:

stdenv.mkDerivation rec {
  pname = "rambox-pro";
  version = "1.1.4";

  dontBuild = true;
  dontStrip = true;

  buildInputs = [ nss xorg.libXext xorg.libxkbfile xorg.libXScrnSaver ];
  nativeBuildInputs = [ autoPatchelfHook makeWrapper nodePackages.asar ];

  src = fetchurl {
    url = "https://github.com/ramboxapp/download/releases/download/v${version}/RamboxPro-${version}-linux-x64.tar.gz";
    sha256 = "0vwh3km3h46bgynd10s8ijl3aj5sskzncdj14h3k7h4sibd8r71a";
  };

  installPhase = ''
    mkdir -p $out/bin $out/opt/RamboxPro $out/share/applications
    asar e resources/app.asar $out/opt/RamboxPro/resources/app.asar.unpacked   
    ln -s ${desktopItem}/share/applications/* $out/share/applications
  '';

  postFixup = ''
    makeWrapper ${electron}/bin/electron $out/bin/ramboxpro \
      --add-flags "$out/opt/RamboxPro/resources/app.asar.unpacked --without-update" \
      --prefix PATH : ${xdg_utils}/bin
  '';

  desktopItem = makeDesktopItem {
    name = "rambox-pro";
    exec = "ramboxpro";
    type = "Application";
    desktopName = "Rambox Pro";
  };

  meta = with stdenv.lib; {
    description = "Messaging and emailing app that combines common web applications into one";
    homepage = https://rambox.pro;
    license = licenses.unfree;
    maintainers = with maintainers; [ chrisaw ];
    platforms = [ "i686-linux" "x86_64-linux" ];
  };
}
