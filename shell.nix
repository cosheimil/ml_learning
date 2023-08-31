with import <nixpkgs> { };

let
  pythonPackages = python3Packages;
in pkgs.mkShell rec {
  name = "Machine Learning Venv";
  venvDir = "/home/artem/projects/ml_learning/ml-venv";
  buildInputs = [
    # A Python interpreter including the 'venv' module is required to bootstrap
    # the environment.
    pythonPackages.python
    pythonPackages.pip

    # This executes some shell code to initialize a venv in $venvDir before
    # dropping into the shell
    pythonPackages.venvShellHook
    pythonPackages.numpy
    pythonPackages.requests
    pythonPackages.pre-commit-hooks

    # Working with data
    pythonPackages.pandas
    pythonPackages.numpy
    pythonPackages.matplotlib
    pythonPackages.seaborn
    pythonPackages.kaggle
    pythonPackages.phik
    pythonPackages.tqdm
    pythonPackages.wandb

    # Machine Learning
    pythonPackages.scikit-learn
    pythonPackages.xgboost
    pythonPackages.lightgbm
    pythonPackages.catboost
    pythonPackages.torch
    pythonPackages.torchvision
    pythonPackages.torchaudio

    # Web Frameworks
    streamlit
    pythonPackages.jupyter
    pythonPackages.ipykernel
    
    # In this particular example, in order to compile any binary extensions they may
    # require, the Python modules listed in the hypothetical requirements.txt need
    # the following packages to be installed locally:
    taglib
    openssl
    git
    libxml2
    libxslt
    libzip
    zlib
  ];

  # Run this command, only after creating the virtual environment
  shellHook = ''
      # Tells pip to put packages into $PIP_PREFIX instead of the usual locations.
      # See https://pip.pypa.io/en/stable/user_guide/#environment-variables.
      export PIP_PREFIX=$(pwd)/_build/pip_packages
      export PYTHONPATH="$PIP_PREFIX/${pkgs.python3.sitePackages}:$PYTHONPATH"
      export PATH="$PIP_PREFIX/bin:$PATH"
      unset SOURCE_DATE_EPOCH
      pip install shap boostaroota optuna sweetviz autoviz graphviz featuretools Boruta pyogrio fiona -q
  '';
}
