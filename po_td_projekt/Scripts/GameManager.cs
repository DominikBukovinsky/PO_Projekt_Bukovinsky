using Godot;

public partial class GameManager : Node
{
	// Singleton instance
	public static GameManager Instance { get; private set; }

	private int _gold = 100;
	
	[Signal]
	public delegate void GoldChangedEventHandler(int newAmount);

	public override void _Ready()
	{
		Instance = this; // Inicializace singletonu
	}

	public void AddGold(int amount)
	{
		_gold += amount;
		EmitSignal(nameof(GoldChanged), _gold);
	}

	public bool SpendGold(int amount)
	{
		if (_gold < amount) return false;
		
		_gold -= amount;
		EmitSignal(nameof(GoldChanged), _gold);
		return true;
	}
}
