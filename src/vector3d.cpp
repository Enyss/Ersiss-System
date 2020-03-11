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

#include "vector3d.h"
//using namespace godot;
// Conversion

godot::Vector3 Vector3d::toVector3()
{
    return godot::Vector3(x,y,z);
}

// Geometrical Operations

double Vector3d::distanceSquaredTo(const Vector3d& a)
{
    return (*this-a).lengthSquared();
}

double Vector3d::distanceTo(const Vector3d& a)
{
    return (*this-a).length();
}

Vector3d& Vector3d::directionTo(const Vector3d& a)
{
    return  (a-*this).normalized();
}

double Vector3d::length()
{
    return sqrt(x*x+y*y+z*z);
}

double Vector3d::lengthSquared()
{
    return x*x+y*y+z*z;
}

Vector3d& Vector3d::normalized()
{
    
    return *this /= length();
}


// Basic Operations

Vector3d& Vector3d::operator+=(const Vector3d& rhs)
{
    x += rhs.x;
    y += rhs.y;
    z += rhs.z;
    return *this; 
}
Vector3d& Vector3d::operator-=(const Vector3d& rhs)
{
    x -= rhs.x;
    y -= rhs.y;
    z -= rhs.z;
    return *this; 
}
Vector3d& Vector3d::operator*=(double rhs)
{
    x *= rhs;
    y *= rhs;
    z *= rhs;
    return *this; 
}
Vector3d& Vector3d::operator/=(double rhs)
{
    x /= rhs;
    y /= rhs;
    z /= rhs;
    return *this; 
}
 

Vector3d Vector3d::operator/(double rhs) 
{
    return Vector3d( x / rhs, y / rhs, z / rhs);
}
Vector3d Vector3d::operator*(double rhs) 
{
    return Vector3d::Vector3d( x * rhs, y * rhs, z * rhs);
}

Vector3d operator+(Vector3d lhs, const Vector3d& rhs) 
{
    lhs += rhs;
    return lhs; 
} 
Vector3d operator-(Vector3d lhs, const Vector3d& rhs) 
{
    lhs -= rhs;
    return lhs; 
} 
Vector3d operator*(double lhs, const Vector3d& rhs) 
{
    return Vector3d::Vector3d( lhs * rhs.x, lhs * rhs.y, lhs * rhs.z);
}
 