using Godot;
using System;

public partial class DoorController : Area3D
{
    private Vector3[] DoorTransformArray;

    [Export]
    private int DoorIndex = 0;
    [Export]
    private int DoorUpID = -1;
    [Export]
    private int DoorDownID = -1;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        DoorTransformArray = new Vector3[3];
        DoorTransformArray[0] = new Vector3(-2.4f, 3.1f, -0.1f); // todo
        DoorTransformArray[1] = new Vector3(2.076f, 0.37f, -0.1f); // todo
        DoorTransformArray[2] = new Vector3(0, 0, 0); // todo
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
    {
    }

    private void _on_player_trigger_area_entered(Area3D player) 
    {
        GD.Print("Enter DoorController Trigger Event Invoke");
        player.Position = DoorTransformArray[DoorUpID];

        if (Input.IsActionJustPressed("ui_up") && DoorUpID is not -1)
        {
            player.Position = DoorTransformArray[DoorUpID];         
        }
        if (Input.IsActionJustPressed("ui_down") && DoorDownID is not -1)
        {
            player.Position = DoorTransformArray[DoorDownID];
        }

        //todo, me da que está al revés xd
    }
}
