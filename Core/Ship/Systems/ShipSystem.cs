using ErsissSystem.Core.Ship.Consumables;
using Godot;

namespace ErsissSystem.Core.Ship.Systems
{
    public class ShipSystem : Node, IShipSystem
    {
        public ConsumableResourceType ConsumableType { get; }
        public ShipSystemType Type => type;

        [Export(PropertyHint.Enum)]
        private ShipSystemType type = ShipSystemType.None;
        [Export(PropertyHint.Enum)]
        private ConsumableResourceType consumableType = ConsumableResourceType.None;

        public void OnProcess()
        {
            throw new System.NotImplementedException();
        }
    }
}