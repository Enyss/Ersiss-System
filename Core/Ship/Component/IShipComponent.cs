using System.Collections.Generic;
using ErsissSystem.Core.Ship.Consumables;

namespace ErsissSystem.Core.Ship.Component
{
    public interface IShipComponent
    {
        ShipComponentType Type { get; }
        List<ConsumableResourceType> ResourcesConsumed { get; }
        List<ConsumableResourceType> ResourcesProduced { get; }
        
        float ResourcePerTick { get; }
        float ResourceStored { get; }
        float ResourceCapacity { get; }

        void OnProcess();
    }
}