using Godot;

public partial class Projectile : Area2D
{
	[Export] public float Speed = 200f;
	[Export] public int Damage = 10; // Přidáno poškození
	public Node2D Target;

	public override void _Ready()
	{
		// Přidáme detekci kolizí
		BodyEntered += OnBodyEntered;
		GD.Print("Projektil vytvořen. Target: ", Target != null);
	}

	private void OnBodyEntered(Node2D body)
	{
		GD.Print("Projektil zasáhl: ", body.Name);
		
		if (body is Enemy enemy)
		{
			GD.Print("Zpracovávám zásah nepřítele");
			enemy.TakeDamage(Damage);
			QueueFree();
		}
	}

	public override void _PhysicsProcess(double delta)
	{
		if (Target == null || !IsInstanceValid(Target))
		{
			GD.Print("Projektil nemá platný cíl - mizí");
			QueueFree();
			return;
		}

		Vector2 direction = (Target.GlobalPosition - GlobalPosition).Normalized();
		Position += direction * Speed * (float)delta;
		Rotation = direction.Angle();
	}
}
