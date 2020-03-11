#ifndef VECTOR3D_H
#define VECTOR3D_H

#include <math.h>
#include <Godot.hpp>

struct Vector3d
{
    double x = 0.0;
    double y = 0.0;
    double z = 0.0;

    Vector3d(){}
    
    Vector3d(double x_, double y_, double z_)
    {
        x=x_;
        y=y_;
        z=z_;
    }

    // Conversion 
    godot::Vector3 toVector3();

    // Geometrical Operations
    
    double distanceSquaredTo(const Vector3d& a);
    double distanceTo(const Vector3d& a);
    Vector3d& directionTo(const Vector3d& a);

    double length();
    double lengthSquared();
    Vector3d& normalized();

    // Basic Operations 
    Vector3d& operator+=(const Vector3d& rhs);   
    Vector3d& operator-=(const Vector3d& rhs);
    Vector3d& operator*=(double rhs);
    Vector3d& operator/=(double rhs);

    Vector3d operator*(double rhs);
    Vector3d operator/(double rhs);
};

Vector3d operator+(Vector3d lhs, const Vector3d& rhs);
Vector3d operator-(Vector3d lhs, const Vector3d& rhs);
Vector3d operator*(double lhs, const Vector3d& rhs);

#endif