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
    
    /*Vector3 getPositionRelativeTo(Body * b);
    void setPositionRelativeTo(Body *b, Vector3 p);*/
    Vector3 getPositionRelativeTo(Body * b, float unit);
    void setPositionRelativeTo(Body *b, Vector3 p, float unit);
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