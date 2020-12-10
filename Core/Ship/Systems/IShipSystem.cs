using ErsissSystem.Core.Ship.Consumables;

namespace ErsissSystem.Core.Ship.Systems
{
    public interface IShipSystem
    {
        /// <summary>
        /// The <code>ShipSystemType</code> of the object.
        /// </summary>
        ShipSystemType Type { get; }
    
        ConsumableResourceType ConsumableType { get; }

        /// <summary>
        /// Processes simulation actions that should occur during the _Process event.
        /// </summary>
        void OnProcess();
    }
}