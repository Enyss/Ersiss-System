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

#include "body.h"

using namespace godot;


Body::Body() {
}

Body::~Body() {
}

void Body::_register_methods(){
    register_method("_process", &Body::_process);
    register_method("position_relative_to", &Body::getPositionRelativeTo);
    register_method("set_position_relative_to", &Body::setPositionRelativeTo);
    register_method("velocity_relative_to", &Body::getVelocityRelativeTo);
    register_method("set_velocity_relative_to", &Body::setVelocityRelativeTo);
    register_property<Body, float>("mass", &Body::set_mass, &Body::get_mass, 1.0);
    register_property<Body, Vector3>("position", &Body::set_position, &Body::get_position, Vector3());
    register_property<Body, Vector3>("velocity", &Body::set_velocity, &Body::get_velocity, Vector3());
    register_property<Body, Vector3>("acceleration", &Body::set_acceleration, &Body::get_acceleration, Vector3());
}

void Body::set_mass(float m){
    mass = m;
}
float Body::get_mass(){
    return mass;
}
void Body::set_position(Vector3 pos){
    position = Vector3d(pos.x, pos.y, pos.z);
}
Vector3 Body::get_position(){
    return Vector3( (float)position.x, (float)position.y, (float)position.z );
}
void Body::set_velocity(Vector3 v) {
    velocity = Vector3d(v.x, v.y, v.z);
}
Vector3 Body::get_velocity(){
    return Vector3( (float)velocity.x, (float)velocity.y, (float)velocity.z );
}
void Body::set_acceleration(Vector3 a){
    acceleration = Vector3d(a.x, a.y, a.z);
   /*char msg[200];
    sprintf(msg, "A = (%E, %E, %E)", acceleration.x, acceleration.y, acceleration.z);
    Godot::print(msg);*/
}
Vector3 Body::get_acceleration(){
    return Vector3( (float)acceleration.x, (float)acceleration.y, (float)acceleration.z );
}

Vector3 Body::getPositionRelativeTo(Body * b)
{
    return (position-b->position).toVector3();
}
void Body::setPositionRelativeTo(Body *b, Vector3 p)
{
    position = b->position+Vector3d(p.x, p.y, p.z);
}
Vector3 Body::getVelocityRelativeTo(Body *b)
{
    return (velocity-b->velocity).toVector3();
}
void Body::setVelocityRelativeTo(Body *b, Vector3 v)
{
    velocity = b->velocity+Vector3d(v.x, v.y, v.z);
}

void Body::_init()
{
    
}

void Body::_process(float delta) {
}