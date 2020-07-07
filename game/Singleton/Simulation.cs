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
using System.Collections.Generic;

public class Simulation : Node
{
    public const double GMe = 3.986e14; // gravitational parameter = G x Earth Mass

    public double time;
    public int simulationSpeed;

    private HashSet<OrbitalBody> bodies;
    private HashSet<OrbitalBody> nBodies;
    private Dictionary<OrbitalBody, Vector3d> nBodiesData;

    public override void _Init()
    {
        bodies = new HashSet();
        nBodies = new HashSet();
        nBodiesData = new Dictionary<OrbitalBody, Vector3d>();
    }

    public override _PhysicsProcess(float delta)
    {
        time += simulationSpeed * delta;
        Update(simulationSpeed * delta);
    }

    private void Update(float t)
    {
        // Here, compute the "best" delta_time/iteration for the simulation
        int iterations = 1;
        double dt = t / iterations;

        // Compute the simulation steps
        for (int i = 0; i < iterations; i++)
        {
            SimulationStep(dt);
        }
    }

    private void SimulationStep(double dt)
    {
        // save the nBodies data
        foreach( OrbitalBody nBody in nBodies )
        {
            nBodiesData[nBody] = nBody.position;
        }

        //compute the simulation
        foreach( OrbitalBody body in Bodies)
        {
            ComputeBodyMovement(body, dt);
        }
    }

    private void ComputeBodyMovement(OrbitalBody body, float dt)
    {
        // Using RK4 to compute the body movement
        Vector3d k1_v = h * (ComputeGravity(body, body.position) + body.acceleration);
        Vector3d k1_x = h * body.velocity;
        Vector3d k2_v = h * (ComputeGravity(body, body.position + k1_x / 2) + body.acceleration);
        Vector3d k2_x = h * (body.velocity + k1_v);
        Vector3d k3_v = h * (ComputeGravity(body, body.position + k2_x / 2) + body.acceleration);
        Vector3d k3_x = h * (body.velocity + k2_v);
        Vector3d k4_v = h * (ComputeGravity(body, body.position + k3_x) + body.acceleration);
        Vector3d k4_x = h * (body.velocity + k3_v);

        body.position += (k1_x + 2 * k2_x + 2 * k3_x + k4_x) / 6;
        body.velocity += (k1_v + 2 * k2_v + 2 * k3_v + k4_v) / 6;
    }

    private Vector3d ComputeGravity(OrbitalBody body, Vector3d position)
    {
        Vector3d force = new Vector3d();
        foreach (OrbitalBody nBody in nBodies)
        {
            if (nBody != body)
            {
                double l = (nBodiesData[nBody] - position).Length();
                double p = nBody.mass * ((GMe / l) / l);
                force += p * (nBodiesData[nBody] - position)/ l;
            }
        }
        return f;
    }

    public void AddBody(OrbitalBody body)
    {
        bodies.Add(body);
        if (body.bodyClass == body.BodyClass.CELESTIAL)
        {
            nBodies.Add(body);
        }
    }

    public void BodyClassChanged(OrbitalBody body)
    {
        if (body.bodyClass == body.BodyClass.CELESTIAL)
        {
            nBodies.Add(body);
        }
        else
        {
            nBodies.Remove(body);
        }
    }

}