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

#include "orbitalsimulation.h"

using namespace godot;

void OrbitalSimulation::_register_methods() {
    register_method("_process", &OrbitalSimulation::_process);
    register_method("update", &OrbitalSimulation::update);
    register_method("add_celestial_body", &OrbitalSimulation::addCelestialBody);
    register_method("add_celestial_bodies", &OrbitalSimulation::addCelestialBodies);
    register_method("add_simulated_body", &OrbitalSimulation::addSimulatedBody);
    register_method("add_simulated_bodies", &OrbitalSimulation::addSimulatedBodies);
    register_method("print_internal_state", &OrbitalSimulation::printState);

    register_property<OrbitalSimulation, float>("simulation_speed", &OrbitalSimulation::speed, 1.0);
    register_property<OrbitalSimulation, float>("time", &OrbitalSimulation::set_time, &OrbitalSimulation::get_time, 0.0);
}

void OrbitalSimulation::set_time(float t) {}
float OrbitalSimulation::get_time() { return (float)time; }

OrbitalSimulation::OrbitalSimulation() {
}

OrbitalSimulation::~OrbitalSimulation() {
}

void OrbitalSimulation::_init() {
    time = 0.0;
    speed = 1.0;
}


void OrbitalSimulation::computeBodyMovement(Body* body, float h) {
    // Using RK4 to compute the body movement
    Vector3d k1_v = h*(computeGravity(body, body->position) + body->acceleration);
	Vector3d k1_x = h*body->velocity;
	Vector3d k2_v = h*(computeGravity(body, body->position+k1_x/2)+ body->acceleration);
	Vector3d k2_x = h*(body->velocity+k1_v);
	Vector3d k3_v = h*(computeGravity(body, body->position+k2_x/2)+ body->acceleration);
	Vector3d k3_x = h*(body->velocity+k2_v);
	Vector3d k4_v = h*(computeGravity(body, body->position+k3_x)+ body->acceleration);
	Vector3d k4_x = h*(body->velocity+k3_v);

	body->position += (k1_x+2*k2_x+2*k3_x+k4_x)/6;
	body->velocity += (k1_v+2*k2_v+2*k3_v+k4_v)/6;
}

Vector3d OrbitalSimulation::computeGravity( Body* baseBody, const Vector3d& position ) {
    Vector3d f = Vector3d(0,0,0);
    for (auto body : celestialBodies) {
        if (body != baseBody) {
            double l = (body->position - position).length();
            if (l>1){
                double p = body->mass * ((GMe/l)/l);
                f +=  (body->position - position) * (p/l);
            }
        }
    }
    return f;
}

void OrbitalSimulation::update(float delta) {
        for (auto body : simulatedBodies) {
            computeBodyMovement(body, delta);
        }
        for (auto body : celestialBodies) {
            computeBodyMovement(body, delta);
        }
}

void OrbitalSimulation::_process(float delta) {
/*    double h = delta*speed;
    time += h;
    char msg[200];

    for (auto body : simulatedBodies) {
        Godot::print(body->get_name());
        sprintf(msg, "x=%E, y=%E, z=%E", body->position.x, body->position.y, body->position.z);
        Godot::print(msg);
        computeBodyMovement(body, h);
    }*/
}

void OrbitalSimulation::printState() {
    char msg[200];
    Godot::print("\n\n  Simulated Bodies :");
    for (auto body :simulatedBodies ) {
        sprintf(msg, "Pos : (%+8E, \t%+8E, \t%+8E), \t V : (%+8E, \t%+8E, \t%+8E)", 
            body->position.x, body->position.y, body->position.z, body->velocity.x, body->velocity.y, body->velocity.z);
        Godot::print(msg);
    }
    Godot::print("\n Celestial Bodies :");
    for (auto body :celestialBodies ) {
        sprintf(msg, "Pos : (%+8E, \t%+8E, \t%+8E), \t V : (%+8E, \t%+8E, \t%+8E)", 
            body->position.x, body->position.y, body->position.z, body->velocity.x, body->velocity.y, body->velocity.z);
        Godot::print(msg);
    }
}

void OrbitalSimulation::addSimulatedBody(Body* body) {
    simulatedBodies.push_back(body);
}

void OrbitalSimulation::addSimulatedBodies(Array bodies) 
{
    for (int i=0; i<bodies.size() ; i++)
    {
        Body* b = Object::cast_to<Body>(bodies[i]);
        addSimulatedBody(b);
    }
}

void OrbitalSimulation::addCelestialBody(Body* body){
    celestialBodies.push_back(body);
}

void OrbitalSimulation::addCelestialBodies(Array bodies) 
{
    for (int i=0; i<bodies.size() ; i++)
    {
        Body* b = Object::cast_to<Body>(bodies[i]);
        addCelestialBody(b);
    }
}

void OrbitalSimulation::removeBody(Body* body){
    std::logic_error("Not Implemented Exception");
}