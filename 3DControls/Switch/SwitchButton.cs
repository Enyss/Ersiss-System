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
using System.Collections.Generic;

public class SwitchButton : ShipComponent, IInteractable
{
    AudioStreamPlayer3D sound = default;
    Dictionary<string, SwitchData> states;

    [Export] public bool depressed;
    [Export] public bool toggleSwitch;

    public SwitchButton()
    {
        states = new Dictionary<string, SwitchData>();
    }

    public override void _Ready()
    {
        // Set the button texture
        SpatialMaterial mat = (SpatialMaterial)GetNode<MeshInstance>("Button/Text").GetSurfaceMaterial(0);
        mat.AlbedoTexture = GetNode<Viewport>("Texture").GetTexture();

        // Get the different switch states
        Godot.Collections.Array children = GetChildren();
        foreach (Node child in children)
        {
            if (child is SwitchData)
            {
                states[((SwitchData)child).stateName] = (SwitchData)child;
            }
        }

        // Move the button in position
        MoveSwitch();
    }

    public void Interact(Interaction interaction)
    {
        switch (interaction)
        {
            case Interaction.PRESS:
                Click();
                break;
            case Interaction.RELEASE:
                ReleaseClick();
                break;
        }
    }



    protected void Click()
    {
        if (toggleSwitch)
        {
            depressed = !depressed;
        }
        else
        {
            depressed = true;
        }
        MoveSwitch();
        sound.Play();
        EmitSignal("clicked", this);
    }

    protected void ReleaseClick()
    {
        if (!toggleSwitch)
        {
            depressed = false;
        }
        MoveSwitch();
    }
    public void UpdateState(string newState)
    {
        SwitchData data;
        if (states.TryGetValue(newState, out data))
        {
            Label label = GetNode<Label>("Texture/Label");
            label.Text = data.text;
            label.AddColorOverride("font_color", data.textColor);
            GetNode<ColorRect>("Texture/Outline").Color = data.buttonColor;
        }
    }

    public void Reset()
    {
        depressed = false;
        MoveSwitch();
    }
    protected void MoveSwitch()
    {
        Vector3 newPos;
        if (depressed)
        {
            newPos = new Vector3(0, -0.03f, 0);
        }
        else
        {
            newPos = new Vector3(0, 0.05f, 0);
        }

        MeshInstance mesh = GetNode<MeshInstance>("Button");
        mesh.Transform = new Transform(mesh.Transform.basis, newPos);
    }
}