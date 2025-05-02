using Godot;

public partial class Enemy : CharacterBody2D
{
	[Export] public float Speed = 100f;
	private Vector2 _targetPosition;

	public override void _Ready()
	{
		_targetPosition = new Vector2(500, 100);
	}

	public override void _PhysicsProcess(double delta)
	{
		// Pohyb nepritele k cili
		Vector2 direction = (_targetPosition - Position).Normalized();
		Velocity = direction * Speed;
		MoveAndSlide();
	}
}
