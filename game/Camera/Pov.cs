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

public class Pov : ShipComponent
{

private PovBackground povBackground;
private Camera camera;

[Export]
private float fov = 70;

[Export]
private Vector2 viewportSize = Vector2(128,128);

public override void _Ready()
{
	AddToGroup("PoV");
	SetupViewport();
	SetupCamera();
}
	
public override void _Process(float delta)
{
	camera.translation = globalTransform.origin;
	camera.globalTransform.basis = globalTransform.basis;
}

public void SetupViewport()
{
	GetNode("CameraViewport").size = viewportSize;
	GetNode("CameraViewport").size = viewportSize;
}

public void SetupCamera()
{
	camera = GetNode("CameraViewport/Camera");
	camera.fov = fov;
	PovBackground backgroundCamera = Scene.AddPov(this);
	backgroundCamera.camera.fov = fov;
	Texture tex = backgroundCamera.GetTexture();
	GetNode("Viewport/Background").texture = tex;
	backgroundCamera.size = viewportSize;

}
}
