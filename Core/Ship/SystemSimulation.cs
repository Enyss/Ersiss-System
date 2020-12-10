using System.Collections.Generic;
using ErsissSystem.Core.Ship.Systems;
using Godot;

namespace ErsissSystem.Core.Ship
{
    public class SystemSimulation : Node, ISystemSimulation
    {
        #region Exported Variables

        [Export] private bool simEnabled = true;
        [Export] private List<ShipSystemType> availableSystems = new List<ShipSystemType>();
        [Export] private NodePath  systemContainer = new NodePath();

        #endregion

        #region Member Variables

        public bool SimEnabled => simEnabled;

        private Node systemContainerNode;
        private List<IShipSystem> shipSystems = new List<IShipSystem>();

        #endregion

        public override void _Ready()
        {
            systemContainerNode = GetNode<Node>(systemContainer);
        }

        public override void _Process(float delta)
        {
            if (!simEnabled) return;
            
            foreach (IShipSystem shipSystem in shipSystems)
            {
                shipSystem.OnProcess();
            }
        }
    }
}