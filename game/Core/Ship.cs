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

public class Ship : OrbitalBody
{
	private Godot.Collections.Dictionary<ShipSystem> systems;
	private Godot.Collections.Array<ShipComponent> components;

	public override void _Ready()
	{
		systems = Godot.Collections.Dictionary<ShipSystem>();
		components = Godot.Collections.Array<ShipComponent>();
		registerSystems();
		initializeSystems();
		Scene.addToLocalObjects(this);
	}

	private void RegisterSystems()
	{
		GetSystemsRecursive(this);
		foreach( ShipComponent component in components )
		{
			systems[component.systemName].registerComponent(component);
		}
	}

	private void InitializeSystems()
	{
		foreach( ShipSystem system in systems.Values )
		{
			system.ship = this;
			system.Initialize();
		}
	}

	private void GetSystemsRecursive(Node node)
	{
		foreach( Node child in node.GetChildren() )
		{
			if (child is ShipSystem)
			{
				systems[child.systemName] = child;
			}
			else if (child is ShipComponent)
			{
				components.PushBack(child);
			}

			if (child.GetChildCount() > 0)
			{
				GetSystemsRecursive(child);
			}
		}
	}
}
