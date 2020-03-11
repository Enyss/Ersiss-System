#ifndef FIXED_BODY_H
#define FIXED_BODY_H

#include <Godot.hpp>
#include <Node.hpp>

namespace godot {

class FixedBody : public Node {
    GODOT_CLASS(FixedBody, Node)

private:
    double x,y,z;
    double vx,vy,vz;

public:
    double mass;
    static void _register_methods();

    FixedBody();
    ~FixedBody();

    void _init(); // our initializer called by Godot

    void _process(float delta);
};

}

#endif