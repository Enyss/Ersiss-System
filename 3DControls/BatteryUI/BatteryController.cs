using Godot;
using System;

public class BatteryController : ShipComponent
{
    private SpatialMaterial batteryScreenMaterial;
    private ViewportTexture viewportTexture; 
    
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        batteryScreenMaterial = GetNode<MeshInstance>("BatteryScreen").GetSurfaceMaterial(0) as SpatialMaterial;
        viewportTexture = GetNode<Viewport>("Viewport").GetTexture();
    }

  // Called every frame. 'delta' is the elapsed time since the previous frame.
  public override void _Process(float delta)
  {
      // FIXME: Implelment UI updates 
      // battery_ui.max_capacity = system.nominal_capacity
      // battery_ui.capacity = system.capacity
      // battery_ui.current = system.amperage
      // battery_ui.voltage = system.voltage
  }

  public void SetActive(bool active)
  {
      if (active)
      {
          batteryScreenMaterial.AlbedoTexture = viewportTexture;
      }
      else
      {
          batteryScreenMaterial.AlbedoTexture = null;
      }
  }
}
