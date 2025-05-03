using Godot;

public partial class Enemy : CharacterBody2D
{
	[Export] public float Speed = 100f;
	[Export] public int Health = 30;
	[Export] public int RewardGold = 10;
	
	private PathFollow2D _pathFollow;
	private Vector2 _targetPosition;

	public override void _Ready()
	{
		// Přidáme debug výstup
		GD.Print("Enemy připraven. Skupiny: ", GetGroups());
		
		if (GetParent() is PathFollow2D pathFollow)
		{
			_pathFollow = pathFollow;
		}
		else
		{
			_targetPosition = new Vector2(500, 100);
		}
	}

	public override void _PhysicsProcess(double delta)
	{
		if (_pathFollow != null)
		{
			_pathFollow.Progress += Speed * (float)delta;
			Position = _pathFollow.Position;
		}
		else
		{
			Vector2 direction = (_targetPosition - Position).Normalized();
			Velocity = direction * Speed;
			MoveAndSlide();
		}
	}

	public void TakeDamage(int damage)
	{
		GD.Print($"Nepřítel obdržel poškození: {damage}. Zbývající životy: {Health - damage}");
		Health -= damage;
		
		if (Health <= 0)
		{
			GD.Print("Nepřítel umírá!");
			if (GameManager.Instance != null)
			{
				GameManager.Instance.AddGold(RewardGold);
			}
			QueueFree();
		}
	}

	[Signal]
	public delegate void DiedEventHandler();
}
