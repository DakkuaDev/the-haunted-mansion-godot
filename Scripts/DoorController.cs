using Godot;
using System;

public partial class DoorController : Area3D
{
    private Vector3[] DoorTransformArray;

    [Export]
    private int DoorIndex = 0;
    [Export]
    private bool HasDoorUp = false;
    [Export]
    private bool HasDoorDown = false;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        DoorTransformArray = new Vector3[3];
        DoorTransformArray[0] = new Vector3(0, 0, 0); // todo
        DoorTransformArray[1] = new Vector3(0, 0, 0); // todo
        DoorTransformArray[2] = new Vector3(0, 0, 0); // todo
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
    {
    }

    private void _on_player_trigger_area_entered(Area3D area) 
    {
        GD.Print("Enter DoorController Trigger Event Invoke");
    }
}
