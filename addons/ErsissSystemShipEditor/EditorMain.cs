using Godot;

namespace ErsissSystem.ErsissSystemShipEditor
{
    [Tool]
// ReSharper disable once UnusedType.Global
    public class EditorMain : EditorPlugin
    {
        private readonly PackedScene mainPanel =
            ResourceLoader.Load<PackedScene>("res://addons/ErsissSystemShipEditor/Scenes/EditorWindow.tscn");

        private readonly Texture icon =
            ResourceLoader.Load<Texture>("res://addons/ErsissSystemShipEditor/Images/rocket.png");

        private Control mainPanelInstance;
        private Node shipNode;

        public override void _EnterTree()
        {
            mainPanelInstance = (Control) mainPanel.Instance();
            GetEditorInterface().GetEditorViewport().AddChild(mainPanelInstance);
            MakeVisible(false);

            var shipScript = GD.Load<Script>("res://addons/ErsissSystemShipEditor/Scripts/CustomTypes/Ship.cs");
            AddCustomType("Ship", "Node", shipScript, icon);
        }

        public override void _ExitTree()
        {
            RemoveCustomType("Ship");
            mainPanelInstance?.QueueFree();
        }

        public override bool HasMainScreen()
        {
            return true;
        }

        public override void MakeVisible(bool visible)
        {
            if (mainPanelInstance != null) mainPanelInstance.Visible = visible;
        }

        public override string GetPluginName()
        {
            return "Ship Editor";
        }

        public override Texture GetPluginIcon()
        {
            return icon;
        }
    }
}