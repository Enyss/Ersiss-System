using Godot;
using System;

public class CameraSwitch : SwitchButton
{
    public void Setup()
    {
        system.Connect("camera_changed", this, "on_camera_changed");
        Connect("clicked", system, "next_camera");
    }

    public void on_camera_changed()
    {
        Reset();
        // FIXME: Make system.components public OR implement a system.GetComponents() method
        // ShipComponent component = system.components["active_camera"];
        // UpdateState(component.componentName);
    }
}
