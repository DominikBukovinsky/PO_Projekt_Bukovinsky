extends CanvasLayer

var money_label: Label
var health_label: Label

func _ready():
	money_label = get_node("MoneyLabel")
	health_label = get_node("HealthLabel")
	if not health_label:
		health_label = find_child("HealthLabel", true, false)
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
		push_error("UI: MoneyLabel je null")
		
func update_health(value):
	if health_label:
		health_label.text = "Životy: " + str(value)
	else:
		push_error("HealthLabel je null")
		
func update_towers(current, max):
	$TowerCounter.text = "Věže: %s / %s" %[current, max]
