/*
 * Copyright (c) 2020 The Eriss-System Project Contributors
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 * */

using Godot;
using System;

public struct Vector3d
{
	public double x;
	public double y;
	public double z;

	public Vector3d(double x, double y, double z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public double Length()
	{
		return Math.Sqrt(x*x+y*y+z*z);
	}

	public static implicit operator Vector3(Vector3d v) => new Vector3((float)v.x, (float)v.y, (float)v.z);
	public static implicit operator Vector3d(Vector3 v) => new Vector3d(v.x, v.y, v.z);

	public static Vector3d operator -(Vector3d a) => new Vector3d(-a.x, -a.y, -a.z);

	public static Vector3d operator +(Vector3d a, Vector3d b)
		=> new Vector3d(a.x+b.x, a.y+b.y, a.z+b.z);

	public static Vector3d operator -(Vector3d a, Vector3d b)
		=> a + (-b);

	public static Vector3d operator *(double a, Vector3d b)
		=> new Vector3d(a*b.x,a*b.y, a*b.z);
	public static Vector3d operator *(Vector3d a, double b)
		=> b*a;

	public static Vector3d operator /(Vector3d a, double b)
	{
		if (b == 0)
		{
			//throw new DivideByZeroException();
		}
		return new Vector3d(a.x/b, a.y/b, a.z/b);
	}
}
