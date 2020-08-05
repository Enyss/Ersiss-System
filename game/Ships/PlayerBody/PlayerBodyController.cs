/**# Copyright (c) 2020 The Eriss-System Project Contributors
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
# SOFTWARE.**/

using Godot;
using System;

public class PlayerBodyController : Controller
{
	private PlayerBody body;
	private float maxAcceleration = 1.0f;
	private float sensitivity = 0.3f;

	public override void _Ready()
	{
		Player.Instance.baseController = this;
	}

public override void _Input(InputEvent e)
{
	if (e is InputEventMouseMotion)
	{
		var basis = body.GlobalTransform.basis;
		body.GlobalRotate(basis.x.Normalized(), -((InputEventMouseMotion)e).Relative.y * sensitivity/60);
		body.GlobalRotate(basis.y.Normalized(), -((InputEventMouseMotion)e).Relative.x * sensitivity/60);
	}
}
public override void _Process(float delta)
{
	Vector3 a = new Vector3();
	Basis basis = parent.GlobalTransform.basis;
	if (Input.IsActionPressed("move_forward"))
	{
		a-= basis.z;
	}
	if (Input.IsActionPressed("move_back"))
	{
		a+= basis.z;
	}
	if (Input.IsActionPressed("move_up"))
	{
		a+= basis.y;
	}
	if (Input.IsActionPressed("move_down"))
	{
		a-= basis.y;
	}
	if (Input.IsActionPressed("move_left"))
	{
		a-= basis.x;
	}
	if (Input.IsActionPressed("move_right"))
	{
		a+= basis.x;
	}
	if (Input.IsActionPressed("roll_clockwise"))
	{
		parent.GlobalRotate(basis.z, (float)(-Math.PI/4*delta) );
	}
	if (Input.IsActionPressed("roll_counterclockwise"))
	{
		parent.GlobalRotate(basis.z, (float)(Math.PI/4*delta));
	}
	((PlayerBody)parent).acceleration = a.Normalized()*maxAcceleration;
	Player.Instance.pov.GlobalTransform = GetParent<Spatial>().GlobalTransform;
}

	
public override void Activate()
{
	base.Activate();
	parent = GetParent<Spatial>();
	((PlayerBody)parent).Activate();
	SceneManager.Instance.Anchor = (OrbitalBody)parent;
}
	
public override void Desactivate()
{
	base.Desactivate();
	GetParent<PlayerBody>().Desactivate();
}
	
/**func set_movement(position, anchor):
	var center = parent.get_parent().center
	var v = anchor.velocity_relative_to(center)
	parent.simbody.set_position_relative_to(center, position,1)
	parent.simbody.set_velocity_relative_to(center, v)

}**/

}
