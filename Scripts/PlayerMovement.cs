using Godot;
using System;

public partial class PlayerMovement : CharacterBody3D
{
	public const float Speed = 1.0f;
	public const float JumpVelocity = 4.5f;

	private AnimatedSprite3D playerSprite;
	private SpotLight3D playerSpotLight;


    // Get the gravity from the project settings to be synced with RigidBody nodes.
    public float gravity = ProjectSettings.GetSetting("physics/3d/default_gravity").AsSingle();

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
		playerSprite = GetNode<AnimatedSprite3D>("AnimatedSprite3D");
		playerSpotLight = GetNode<SpotLight3D>("SpotLight3D");
    }

    public override void _PhysicsProcess(double delta)
	{
		Vector3 velocity = Velocity;

		// Add the gravity.
		if (!IsOnFloor())
			velocity.Y -= gravity * (float)delta;

		// Handle Jump.
		//if (Input.IsActionJustPressed("ui_accept") && IsOnFloor())
		//	velocity.Y = JumpVelocity;

		// Get the input direction and handle the movement/deceleration.
		// As good practice, you should replace UI actions with custom gameplay actions.
		Vector2 inputDir = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
		Vector3 direction = (Transform.Basis * new Vector3(inputDir.X, 0, inputDir.Y)).Normalized();
		if (direction != Vector3.Zero)
		{
			velocity.X = direction.X * Speed;
			velocity.Z = direction.Z * Speed;
		}
		else
		{
			velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
			velocity.Z = Mathf.MoveToward(Velocity.Z, 0, Speed);
		}

		Velocity = velocity;
		MoveAndSlide();
		Update3DSprite();

	}

    private void Update3DSprite()
    {

		if(Velocity.X is not 0)
		{
			playerSprite.Animation = "walk";
			playerSprite.Play();
		}
		else
		{
            playerSprite.Animation = "idle";
			playerSprite.Stop();
        }

        if (Velocity.X > 0)
		{
            playerSprite.FlipH = false;
            playerSpotLight.RotationDegrees = new Vector3(0, -90, 0);

        }
		else if(Velocity.X < 0)
		{
            playerSprite.FlipH = true;
            playerSpotLight.RotationDegrees = new Vector3(0, 90, 0);

        }
    }

	private void _on_area_3d_body_entered(Node3D body)
	{
		GD.Print("_on_area_3d_body_entered");

		//todo: door mechanic
	}
}
