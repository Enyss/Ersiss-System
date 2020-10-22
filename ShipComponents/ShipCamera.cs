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

public class ShipCamera : Spatial, IShipComponent, IPov
{

    // IShipComponent properties
    public string ComponentName { get; set; }
    public string SystemName { get; set; }
    public ShipSystem System { get; }

    // IPov properties
    public Viewport LocalViewport { get; set; }
    public Camera LocalCamera { get; set; }
    public Viewport GlobalViewport { get; set; }
    public Camera GlobalCamera { get; set; }

    [Export]
    public float Fov { get => fov; set => fov = value; }
    private float fov = 70;

    [Export]
    private Vector2 viewportSize = new Vector2(128, 128);

    public override void _Ready()
    {
        LocalViewport = GetNode<Viewport>("CameraViewport");
        LocalCamera = GetNode<Camera>("CameraViewport/Camera");

        AddToGroup("PoV");
        SetupViewport();
        SetupCamera();
    }

    public override void _Process(float delta)
    {
        Transform transform = new Transform(GlobalTransform.basis, GlobalTransform.origin);
        LocalCamera.Transform = transform;
    }

    public void SetupViewport()
    {
        LocalViewport.Size = viewportSize;
    }
    public void SetupCamera()
    {
        //Setup the local Camera
        LocalCamera.Fov = fov;

        // Create the Global viewport&Camera
		PackedScene backgroundCamera = ResourceLoader.Load<PackedScene>("res://Camera/BackgroundCamera.tscn");
		GlobalViewport = backgroundCamera.Instance() as Viewport;
		GetNode("/root/Main/GlobalScene").AddChild(GlobalViewport);
        GlobalViewport.Size = viewportSize;

        //Setup the Global camera
        GlobalCamera = GlobalViewport.GetNode<Camera>("Camera");
        GlobalCamera.Fov = fov;

        // To be modified later 
        Texture tex = GlobalViewport.GetTexture();
        GetNode<TextureRect>("Viewport/Background").Texture = tex;
    }

    public void SetSystem(ShipSystem system)
    {

    }
    public void Setup()
    {

    }

}


