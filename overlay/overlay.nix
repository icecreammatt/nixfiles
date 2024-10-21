final: prev: {
  # Overlay to add custom Colemak mappings
  nnn = final.callPackage ./nnn {};
  # Game like snake I made in college
  worm = final.callPackage ./worm {};
  # Custom version
  pocketbase = final.callPackage ./pocketbase {};
  # Sample program not in nixpkgs to show hex colors
  hex2color = final.callPackage ./hex2color {};
  # Markdown LSP for helix
  mdpls = final.callPackage ./mdpls {};
  # serpl search and replace
  serpl = final.callPackage ./serpl {};
}
