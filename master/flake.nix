{
  description = ''json de/serializer for tuples and more'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-jser-master.flake = false;
  inputs.src-jser-master.owner = "niv";
  inputs.src-jser-master.ref   = "refs/heads/master";
  inputs.src-jser-master.repo  = "jser.nim";
  inputs.src-jser-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-jser-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-jser-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}