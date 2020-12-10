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

public class PlayerBody : OrbitalBody
{
	// FIXME: private Controller controller;

	public override void _Ready()
	{
		SceneManager.Instance.AddToLocalObjects(this);
	}

	public void Desactivate()
	{
		SetProcess(false);
		SetPhysicsProcess(false);
	}
	public void Activate()
	{
		SetProcess(true);
		SetPhysicsProcess(true);
		SceneManager.Instance.Anchor = this;
	}


	public override void _PhysicsProcess(float delta)
	{
		OrbitalBody center = SceneManager.Instance.Center;
		/*KinematicCollision collision = MoveAndCollide(GetVelocityRelativeTo(center) * delta, true, true, true);

		if (collision != null)
		{
			Vector3d newPosition = (Vector3)GetPositionRelativeTo(center) - collision.Remainder + collision.Remainder.Bounce(collision.Normal);
			SetPositionRelativeTo(center, newPosition);
			float damp = 0.2f;
			Vector3 dv = (Vector3)GetVelocityRelativeTo(center) - collision.ColliderVelocity;
			Vector3 newSpeed = damp * (dv.Bounce(collision.Normal));
			SetVelocityRelativeTo(center, newSpeed + collision.ColliderVelocity);
		}*/
		Vector3 p = GetPositionRelativeTo(center);
		if (p.Length() < 50000)
		{
			Transform = new Transform(Transform.basis, p);
		}
		else
		{

		}
	}

}
