using Godot;

public partial class Projectile : Area2D
{
	[Export] public float Speed = 200f;
	public Node2D Target;

	public override void _PhysicsProcess(double delta)
	{
		if (Target == null || !IsInstanceValid(Target))
		{
			QueueFree(); // projektil se znici pokud neexistuje cil
			return;
		}

		// pohyb projektilu k cili
		Vector2 direction = (Target.GlobalPosition - GlobalPosition).Normalized();
		Position += direction * Speed * (float)delta;

		Rotation = direction.Angle();
	}
}
