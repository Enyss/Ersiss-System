namespace ErsissSystem.Core.Ship.Consumables
{
    public abstract class ConsumableResource : IConsumableResource
    {
        public ConsumableResourceType resourceType { get; }
    }
}