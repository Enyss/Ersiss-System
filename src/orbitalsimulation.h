#ifndef ORBITAL_SIMULATION_H
#define ORBITAL_SIMULATION_H

#include <Godot.hpp>
#include <Node.hpp>
#include <list>

#include "vector3d.h"
#include "body.h"

namespace godot {

class OrbitalSimulation : public Node {
    GODOT_CLASS(OrbitalSimulation, Node)

private:
    double time;
    void set_time(float);
    float get_time();

    float speed;

    std::list<Body*> simulatedBodies;
    std::list<Body*> celestialBodies;

    void computeBodyMovement(Body* body, float h);
    Vector3d computeGravity( const Vector3d& position ); 

public:
    const double GMe = 3.986e14; // gravitational parameter = G x Earth Mass

    static void _register_methods();

    OrbitalSimulation();
    ~OrbitalSimulation();

    void _init(); // our initializer called by Godot

    void _process(float delta);

    void update(float delta);

    void addSimulatedBody(Body* body);
    void addSimulatedBodies(Array bodies);
    void addCelestialBody(Body* body);
    void addCelestialBodies(Array bodies);
    void removeBody(Body* body);
};

}

#endif