namespace ErsissSystem.Core.Ship
{
    public interface ISystemSimulation
    {
       bool SimEnabled { get; }

       void _Process(float delta);
    }
}