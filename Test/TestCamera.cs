using Godot;

public class TestCamera : Camera
{
    [Export] private string viewportPath = default;

public override void _Ready()
    {
        var sky = new PanoramaSky();
        var bg = GetNode<Viewport>(viewportPath);

        sky.Panorama = bg.GetTexture();

        Environment = new Environment {BackgroundSky = sky};
    }
}