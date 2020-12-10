using System;

namespace ErsissSystem.Core.Ship.Component
{
    [Flags]
    public enum ShipComponentType
    {
        // As flags, these should be assigned bit values.
        None = 0,
        Consumer = 1,
        Producer = 2,
        Battery = 4
    }
}