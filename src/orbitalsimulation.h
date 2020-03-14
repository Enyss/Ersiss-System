/*Copyright (c) 2020 The Eriss-System Project Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.*/

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
    Vector3d computeGravity( Body* baseBody, const Vector3d& position ); 

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

    void printState(void);
};

}

#endif