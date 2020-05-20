cd godot-cpp
scons platform=linux generate_bindings=yes -j$(nproc)
cd ..
scons platform=x11 -j$(nproc)
cp game/bin/x11/liborbitalsimulation.so game/bin/x11/orbitalsimulation.so
