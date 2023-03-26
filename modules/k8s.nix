{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    argocd
    k9s
    kind
    kubernetes-helm-wrapped
    minikube
  ];

  imports = [];

}