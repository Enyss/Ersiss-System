using System.Collections.Generic;
using ErsissSystem.Core.Attributes;
using ErsissSystem.Core.Ship.Consumables;
using Godot;

namespace ErsissSystem.Core.Ship.Component
{
    public class ShipComponent : Node, IShipComponent
    {
        public ShipComponentType Type => (ShipComponentType) type;
        public List<ConsumableResourceType> ResourcesConsumed => resourcesConsumed;
        public List<ConsumableResourceType> ResourcesProduced => resourcesProduced;
        public float ResourcePerTick => resourcePerTick;
        public float ResourceStored => resourceStored;
        public float ResourceCapacity => resourceCapacity;

        [ExportFlagsEnum(typeof(ShipComponentType))]
        private int type;

        [Export]
        private List<ConsumableResourceType> resourcesConsumed = new List<ConsumableResourceType>();
        [Export]
        private List<ConsumableResourceType> resourcesProduced = new List<ConsumableResourceType>();
        [Export] private float resourcePerTick = 0f;
        [Export] private float resourceStored = 0f;
        [Export] private float resourceCapacity = 0f;

        public void OnProcess()
        {
            throw new System.NotImplementedException();
        }
    }
}