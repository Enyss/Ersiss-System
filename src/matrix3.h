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

#ifndef MATRIX3_H
#define MATRIX3_H

#include <math.h>

struct Matrix3
{
    double matrix[9];

    Matrix3(){}
    
    Matrix3(double xx, double xy, double xz, 
        double yx, double yy, double yz, 
        double zx, double zy, double zz)
    {
        matrix[0] = xx; matrix[1] = xy; matrix[2] = xz;
        matrix[3] = yx; matrix[4] = yy; matrix[5] = yz;
        matrix[6] = zx; matrix[7] = zy; matrix[8] = zz;
    }

    // Basic Operations 
    Matrix3& operator+=(const Matrix3& rhs);   
    Matrix3& operator-=(const Matrix3& rhs);
    Matrix3& operator*=(Matrix3 rhs);

    Matrix3 operator*(double rhs);
    Matrix3 operator/(double rhs);

    // Matrix Operations
    double det(void);
    Matrix3 inv(void);
};

Matrix3 operator+(Matrix3 lhs, const Matrix3& rhs);
Matrix3 operator-(Matrix3 lhs, const Matrix3& rhs);
Matrix3 operator*(Matrix3 lhs, const Matrix3& rhs);

#endif