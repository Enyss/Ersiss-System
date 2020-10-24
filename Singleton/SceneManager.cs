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
using System.Collections.Generic;

public class SceneManager : Node
{
    private static SceneManager instance;
    public static SceneManager Instance { get { return instance; } }
    private double maxDistance = 100;
    private OrbitalBody center;
    public OrbitalBody Center
    {
        get => center;
    }
    private OrbitalBody anchor;
    public OrbitalBody Anchor
    {
        get { return anchor; }
        set { anchor = value; }
    }

    private List<OrbitalBody> localObjects;

    public SceneManager()
    {
        instance = this;
        localObjects = new List<OrbitalBody>();
    }

    public override void _PhysicsProcess(float delta)
    {
        if (anchor != null && center.DistanceTo(anchor) > maxDistance)
        {
            CenterBubble();
        }
    }

    public void Initialize()
    {
        Player.Instance.ResetController();
        foreach (OrbitalBody body in localObjects)
        {
            body.SetPositionRelativeTo(center, body.Transform.origin);
            body.SetVelocityRelativeTo(center, body.velocity);
        }
    }

    public void SetCenter(OrbitalBody center)
    {
        this.center = center;
    }

    public void AddToLocalObjects(OrbitalBody body)
    {
        localObjects.Add(body);
    }


    public void CenterBubble()
    {
        center.SetPositionRelativeTo(anchor, new Vector3d());
        center.SetVelocityRelativeTo(anchor, new Vector3d());
        foreach (OrbitalBody body in localObjects)
        {
            body.Transform = new Transform(body.Transform.basis, body.GetPositionRelativeTo(center));
        }
    }
}

    
    