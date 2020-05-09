extends Node
class_name System

signal updated()
export (String) var system_name
var components : Array

func register_component(component):
	component.set_system(self)
	components.push_back(component)
