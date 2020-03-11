#ifndef BODY_H
#define BODY_H

#include <Godot.hpp>
#include <Node.hpp>

#include "vector3d.h"

namespace godot {

class Body : public Node {
    GODOT_CLASS(Body, Node)

private:

public:
    double mass;
    Vector3d velocity;
    Vector3d position;
    Vector3d acceleration;

    void set_mass(float);
    float get_mass();
    void set_position(Vector3);
    Vector3 get_position();
    void set_velocity(Vector3);
    Vector3 get_velocity();
    void set_acceleration(Vector3);
    Vector3 get_acceleration();
    
    Vector3 getPositionRelativeTo(Body * b);
    void setPositionRelativeTo(Body *b, Vector3 p);
    Vector3 getVelocityRelativeTo(Body * b);
    void setVelocityRelativeTo(Body *b, Vector3 v);

    static void _register_methods();

    Body();
    ~Body();

    void _init(); // our initializer called by Godot

    void _process(float delta);

};

}

#endif