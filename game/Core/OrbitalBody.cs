/** Copyright (c) 2020 The Eriss-System Project Contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE. **/

using Godot;
using System;

public class OrbitalBody : Spatial
{
	public enum BodyClass { NONE, CELESTIAL, SIMULATED, BUBBLE }

	[Export]
	public BodyClass bodyClass = BodyClass.NONE;

	//Simulation elements
	public Vector3d position;
	public Vector3d velocity;
	public Vector3d acceleration;
	public double mass;

	public override void _Ready()
	{
		Simulation.AddBody(this);
	}

	public override void _PhysicsProcess(float delta)
	{
		globalTransform.origin = (Vector3)GetPositionRelativeTo(Scene.center);
	}


	public Vector3d GetPositionRelativeTo(OrbitalBody b)
	{
		return position - b.position;
	}

	public Vector3d GetPositionRelativeTo(OrbitalBody b, double scale)
	{
		return (position - b.position) / scale;
	}

	public void SetPositionRelativeTo(OrbitalBody b, Vector3d relativePosition)
	{
		position = b.position + relativePosition;
	}

	public void SetPositionRelativeTo(OrbitalBody b, Vector3d relativePosition, double scale)
	{
		position = b.position + scale * relativePosition;
	}
	public Vector3d GetVelocityRelativeTo(OrbitalBody b)
	{
		return velocity - b.velocity;
	}
	public void SetVelocityRelativeTo(OrbitalBody b, Vector3d relativeVelocity)
	{
		velocity = b.velocity + v;
	}

	Double DistanceTo(OrbitalBody b)
	{
		return (position - b.position).Length();
	}
}
