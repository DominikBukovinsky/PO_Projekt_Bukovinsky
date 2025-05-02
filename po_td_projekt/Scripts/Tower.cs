using Godot;
using System.Collections.Generic;

public partial class Tower : Area2D
{
	[Export] private PackedScene _projectileScene;
	private List<Node2D> _targets = new();
	private Timer _attackTimer;

	public override void _Ready()
	{
		_attackTimer = GetNode<Timer>("Timer");
		_attackTimer.Timeout += OnAttackTimerTimeout;
		BodyEntered += OnBodyEntered;
		BodyExited += OnBodyExited;
	}

	private void OnBodyEntered(Node2D body)
	{
		if (body.IsInGroup("enemies"))
			_targets.Add(body);
	}

	private void OnBodyExited(Node2D body)
	{
		_targets.Remove(body);
	}

	private void OnAttackTimerTimeout()
	{
		if (_targets.Count == 0) return;

		// Vytvori se projektil
		var projectile = _projectileScene.Instantiate<Projectile>();
		projectile.GlobalPosition = GlobalPosition;
		projectile.Target = _targets[0];
		GetParent().AddChild(projectile);
	}
}
