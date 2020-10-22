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

using System;
using Godot;

/// <summary>
/// Displays information on a given plan
/// </summary>
public class PlanetDebugLabel : Label
{
    private string orbitalBodyRootPath = @"/root/Main/Global/";
    
    /// <summary>
    /// The name of the body in tne scene to get debug information for.
    /// </summary>
    [Export] private string bodyName = default;
    private OrbitalBody body;
    private OrbitalBody anchorBody;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        body = GetNode<Node>($@"{orbitalBodyRootPath}{bodyName}") as OrbitalBody;
        anchorBody = SceneManager.Instance.Anchor;
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(float delta)
    {
        if (body is null)
        {
            GD.PrintErr($@"Cannot find body at path {orbitalBodyRootPath}{bodyName}");
            return;
        }

        if (anchorBody is null)
        {
            GD.PrintErr("Cannot find anchor for scene.");
            return;
        }
        
        Vector3d pos = body.GetPositionRelativeTo(anchorBody, 1000);
        Vector3d vel = body.GetVelocityRelativeTo(anchorBody);

        Text =
            $@"FPS: {Engine.GetFramesPerSecond()} \n" +
            $@"Sim Speed: {Simulation.Instance.simulationSpeed} \n" +
            $@"H: {pos.Length():0.0000} \n" +
            $@"POS: ({(int) pos.x}, {(int) pos.y}, {(int) pos.z} \n" + "" +
            $@"V: {vel.Length():0.0000} \n" +
            $@"VEL: {(int) vel.x}, {(int) vel.y}, {(int) vel.z}";
    }
}