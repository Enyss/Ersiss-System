using Godot;
using System;
using System.Drawing.Text;

public class BatteryController : Battery
{
    /// <summary>
    /// The surface material for the Battery Display mesh.  
    /// </summary>
    private SpatialMaterial batteryScreenMaterial;
    private ViewportTexture viewportTexture;
    private BatteryUI batteryUI;
    
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        batteryScreenMaterial = GetNode<MeshInstance>("BatteryScreen").GetSurfaceMaterial(0) as SpatialMaterial;
        viewportTexture = GetNode<Viewport>("BatteryViewport").GetTexture();
        batteryUI = GetNode<BatteryUI>("BatteryViewport/BatteryScreenUI");
    }

  // Called every frame. 'delta' is the elapsed time since the previous frame.
  public override void _Process(float delta)
  {
      // FIXME: Implelment UI updates 
      batteryUI.maxCapacity = NominalCapacity;
      batteryUI.capacity = Capacity;
      batteryUI.current = Amperage;
      batteryUI.voltage = Voltage;
  }

  public void SetActive(bool active)
  {
      batteryScreenMaterial.AlbedoTexture = active ? viewportTexture : null;
  }
}
