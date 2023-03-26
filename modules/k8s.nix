{  pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    argocd
    k9s
    k3s
    kind
    kubernetes-helm-wrapped
    minikube
  ];

  imports = [];

}