{pkgs, ...}: {
  home.packages = with pkgs; [
    argocd
    k9s
    kind
    kubectl
    kubernetes-helm-wrapped
    minikube
  ];

  imports = [];
}
