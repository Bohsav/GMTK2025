extends Node

func getChildByType(parent: Node, type: Variant) -> Variant:
	for child in parent.get_children():
		if is_instance_of(child, type):
			return child
	return null
	
func getChildByTypeDeep(parent: Node, type: Variant):
	for child in parent.get_children():
		if is_instance_of(child, type):
			return child
		var grandchild = getChildByType(child, type)
		if grandchild != null:
			return grandchild
	return null
