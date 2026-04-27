@abstract
class_name Damagable extends AnimatedSprite3D

@onready var vBox: VBoxContainer = $HealthViewPort/VBoxContainer
@onready var statusEffectComponent: StatusEffectComponent = $StatusEffectComponent
@onready var statusEffectRow: HBoxContainer = $HealthViewPort/VBoxContainer/StatusEffectRow
@onready var healthBar: ProgressBar = $HealthViewPort/VBoxContainer/ProgressBar
@export var maxHp: int
@export var damageNumberManager: DamageNumberManager
var currentHp: int
const statusEffectIcon = preload("res://Scenes/UI/status_effect_icon.tscn")

func startCombat():
	currentHp = maxHp
	vBox.set_anchors_preset(Control.PRESET_FULL_RECT)
	
	healthBar.max_value = maxHp
	healthBar.value = currentHp
	
	healthBar.custom_minimum_size = Vector2 (0, 20)
	
	statusEffectRow.custom_minimum_size = Vector2(0, 20)
	
	statusEffectComponent.effectsChanged.connect(updateStatusEffects)

func _ready() -> void:
	pass

func takeDamage(damage: int, type: String = "normal") -> int: #returns damage taken
	damage = $StatusEffectComponent.triggerDamageTaken(damage)
	damageNumberManager.spawn(damage, type, global_position)
	currentHp-=damage
	healthBar.value = currentHp
	if currentHp<=0:
		die()
	return damage

func updateStatusEffects() -> void:
	for child in statusEffectRow.get_children():
		child.queue_free()
	for effect in statusEffectComponent.activeEffects:
		var icon := statusEffectIcon.instantiate()
		statusEffectRow.add_child(icon)
		icon.setup(effect, effect.stacks)
		
@abstract 
func die()
