# OpenFOAM Application

This OpenFOAM image is a very thin wrapper around the default OpenFOAM image (https://hub.docker.com/r/openfoam/openfoam5-paraview54/). The wrapping is done to make it easy to run OpenFOAM simulations on Nerdalize. For a step-by-step guide on how to do this, see https://www.nerdalize.com/applications/openfoam.

## How does it work?

This image adds a new entrypoint to the default OpenFOAM image. The entrypoint executes three sequential steps:
1. All files in `/input` are copied to the `$FOAM_RUN` folder. Note that the files in `/input` were uploaded using `nerd dataset upload`.
2. The specified run script is executed. This file can be set with `$OPENFOAM_RUN_FILE`. The default value is `./run.sh`.
3. All files from the `$FOAM_RUN` folder are copied to `/output`, so they can be downloaded using `nerd dataset download`.
