using Godot;

public class TestHype : Node
{
    private RandomNumberGenerator rng = new RandomNumberGenerator();
    private int count = 0;
    private PackedScene testObject;
    private Node bubble;

    [Export] private string testObjectPath = default;
    [Export] private string timerPath = default;

    public override void _Ready()
    {
        rng.Randomize();
        bubble = GetParent<Node>();
        testObject = GD.Load(testObjectPath) as PackedScene;
        GetNode<Timer>(timerPath).Start();
    }
}