extends CanvasLayer

var money_label: Label

func _ready():
	money_label = get_node("MoneyLabel")
	
	if not money_label:
		money_label = find_child("MoneyLabel", true, false)
	
	if money_label:
		print("UI: MoneyLabel nalezen")
	else:
		push_error("UI: MoneyLabel NENALEZEN!")

func update_money(value):
	if money_label:
		money_label.text = "Peníze: " + str(value)
	else:
		push_error("UI: Pokus o aktualizaci peněz, ale money_label je null")
