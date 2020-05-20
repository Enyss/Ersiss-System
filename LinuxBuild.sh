cd godot-cpp
scons platform=linux generate_bindings=yes -j$(nproc)
cd ..
scons platform=linux -j$(nproc)
