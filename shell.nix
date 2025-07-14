{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc11
    gnumake
    cmake
    zlib
    libuuid
    vulkan-headers
    vulkan-loader
    libGLU
    libGL
    xorg.libX11
    xorg.libXext
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXi
    snappy
  ];

  shellHook = let
    python_version = "3.12";
    python_home = "/home/wheatfox/miniconda3/envs/genesis";
    cuda_home = "/usr/local/cuda-12.8";
  in ''
    export CC=${pkgs.gcc11}/bin/gcc
    export CXX=${pkgs.gcc11}/bin/g++
    export CUDA_HOME=${cuda_home}
    export PATH=$CUDA_HOME/bin:$PATH
    export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
    export PYTHONHOME=${python_home}
    export PATH=$PYTHONHOME/bin:$PATH
    export PYTHONPATH=$PYTHONHOME/lib/python${python_version}/site-packages:$PYTHONPATH
    export CMAKE_CUDA_COMPILER=$CUDA_HOME/bin/nvcc
    export CMAKE_PREFIX_PATH=$PYTHONHOME
  '';
}
