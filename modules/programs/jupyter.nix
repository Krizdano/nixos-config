{ pkgs, ... }: {
  services.jupyterhub = {
    enable = true;
    jupyterlabEnv = pkgs.python3.withPackages (p: with p; [
      jupyterhub
      jupyterlab
      seaborn
      umap-learn
    ]);

    kernels = {
      python3 =
        let
          env = pkgs.python311.withPackages (pythonPackages: with pythonPackages; [
            ipykernel
            pandas
            numpy
            seaborn
            matplotlib
            scikit-learn
          ]);
        in
        {
          displayName = "Python 3 for machine learning";
          argv = [
            "${env.interpreter}"
            "-m"
            "ipykernel_launcher"
            "-f"
            "{connection_file}"
          ];
          language = "python";
          logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
          logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
        };
    };
  };
}
