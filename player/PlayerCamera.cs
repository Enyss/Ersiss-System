using Godot;

public class PlayerCamera : KinematicBody
{
    public float MouseSensitivity => mouseSensitivity;
    public int CameraAngle => cameraAngle;
    public Vector3 Acceleration => acceleration;

    private float mouseSensitivity = 0.3f;
    private int cameraAngle;
    private Vector3 acceleration = Vector3.One;
    private OrbitalBody simbody;
    private Node lockedTo;

    [Export] private bool massive = default;
    [Export] private float mass = default;
    [Export] private bool simulated = default;
    [Export] private Vector3 positionInKilometers = default;
    [Export] private Vector3 velocity = default;

    public override void _Ready()
    {
        simbody = new OrbitalBody();
        simbody.mass = mass;
        simbody.position = positionInKilometers * 1000;
        simbody.velocity = velocity;
        Simulation.Instance.AddBody(simbody);
    }

    public override void _ExitTree()
    {
        simbody.QueueFree();
    }

    public override void _Input(InputEvent @event)
    {
        if (@event is InputEventMouseMotion && Input.GetMouseMode() == Input.MouseMode.Captured)
        {
            Vector2 mouseRelativeMotion = ((InputEventMouseMotion) @event).Relative;
            Vector3 axis = GetNode<Camera>("Camera").GlobalTransform.basis.y;
            float change = -mouseRelativeMotion.y * mouseSensitivity;
            
            GlobalRotate(axis, Mathf.Deg2Rad(-mouseRelativeMotion.x * mouseSensitivity));

            if (cameraAngle + change < 75 && cameraAngle + change > -75)
            {
                GetNode<Camera>("Camera").RotateX(Mathf.Deg2Rad(change));
                cameraAngle += (int) change;
            }
            else
            {
                axis = GetNode<Camera>("Camera").GlobalTransform.basis.x;
                GlobalRotate(axis, Mathf.Deg2Rad(change));
            }
        }
    }

    public override void _Process(float delta)
    {
        var camera = GetNode<Camera>("Camera");
        var newAccel = new Vector3();
        
        if (Input.IsActionPressed("move_forward"))
        {
            newAccel -= camera.GlobalTransform.basis.z;
        }

        if (Input.IsActionPressed("move_back"))
        {
            newAccel += camera.GlobalTransform.basis.z;
        }

        if (Input.IsActionPressed("move_up"))
        {
            newAccel += camera.GlobalTransform.basis.y;
        }

        if (Input.IsActionPressed("move_down"))
        {
            newAccel -= camera.GlobalTransform.basis.y;
        }

        if (Input.IsActionPressed("move_left"))
        {
            newAccel -= camera.GlobalTransform.basis.x;
        }

        if (Input.IsActionPressed("move_right"))
        {
            newAccel += camera.GlobalTransform.basis.x;
        }

        Vector3 axis = camera.GlobalTransform.basis.z;
        if (Input.IsActionPressed("roll_clockwise"))
        {
            GlobalRotate(axis, -Mathf.Pi / 4 * delta);
        }

        if (Input.IsActionPressed("roll_counterclockwise"))
        {
            GlobalRotate(axis, Mathf.Pi / 4 * delta);
        }

        acceleration = acceleration.Normalized();
        simbody.acceleration = acceleration * newAccel;
    }

    public void LockTo(Node node)
    {
        lockedTo = node;
    }
}