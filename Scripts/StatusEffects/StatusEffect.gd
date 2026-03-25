@abstract
class_name StatusEffect extends Resource

@export var effectName: String
@export var maxStacks: int = -1 #no limit
var stacks: int = 1

func onApply(_target): pass
func onTurnEnd(_target): pass
func onTurnStart(_target): pass
func onRemove(_target): pass
func onDamageTaken(_target, _damage: int) -> int: return _damage
func onAttack(_target): pass
func onUtility(_target): pass #blocking for player, non-attack for enemies
