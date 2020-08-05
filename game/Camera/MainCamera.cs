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

public class MainCamera : Camera, IPov
{
	private PovBackground globalCamera;
	private TextureRect background;

	private int zoomLevel = 0;
	private RayCast raycast;
	private IInteractable interactionTarget = null;

	public override void _Ready()
	{
		AddToGroup("PoV");
		raycast = (RayCast)GetNode("RayCast");
		Setup();
		//Player.Instance.pov = this;
	}
	public override void _Process(float delta)
	{
		Node target = (Node)raycast.GetCollider();
		Player.Instance.lookingAt = target;
		if (Input.IsActionJustPressed("ui_click"))
		{
			if (target is IInteractable)
			{
				interactionTarget = (IInteractable)target;
				interactionTarget.Interact(Interaction.PRESS);
			}
		}
		if (Input.IsActionJustReleased("ui_click"))
		{
			if (interactionTarget != null)
			{
				interactionTarget.Interact(Interaction.RELEASE);
			}
		}
		if (Input.IsActionJustPressed("fps_zoom"))
		{
			zoomLevel += 1;
			if (zoomLevel > 1)
			{
				zoomLevel = 0;
			}
			this.Fov = 70 - 30 * zoomLevel;
		}
	}
	private void Setup()
	{
		globalCamera = SceneManager.Instance.AddPov(this);
		background = GetNode<TextureRect>("Background/texture");
		background.Texture = globalCamera.GetTexture();
		globalCamera.Size = GetNode<Viewport>("/root").Size;
	}
}
