extends Node
class_name System

signal updated()

export (String) var system_name
var ship
var components : Dictionary

func register_component(component):
	component.set_system(self)
	components[component.component_name] = component

func initialize():
	pass
