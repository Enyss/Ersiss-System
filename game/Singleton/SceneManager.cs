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
using System.Collections.Generic;

public class SceneManager : Node
{

    private Simbody center;
    private OrbitalBody anchor;
    private double maxDistance = 100;
    private List<OrbitalBody> localObjects;

    public override void _physics_process(float delta)
    {
        if (anchor != null && center.distanceTo(anchor.simbody) > max_distance)
        {
            CenterBubble();
        }
    }

    public void Initialize()
    {
        Player.reset_controller();
        foreach (OrbitalBody body in localObjects)
        {
            body.simbody.SetPositionRelativeTo(center, object.transform.origin);
            body.simbody.SetVelocityRelativeTo(center, object.velocity);
        }
    }


    public void AddToLocalObjects(OrbitalBody body)
    {
        localObjects.Add(body);
    }

    public void CenterBubble()
    {
        center.SetPositionRelativeTo(anchor.simbody, Vector3());
        center.SetVelocityRelativeTo(anchor.simbody, Vector3());
        foreach (OrbitalBody body in localObjects)
        {
            body.transform.origin = body.simbody.PositionRelativeTo(center);
        }

    }

    public PovBackground AddPov(Pov pov)
    {
        PovBackground bg = povBackground.Instance();
        bg.Setup(pov);
        GetNode("/root/Main/Global").AddChild(bg);
        return bg;

    }

}
