extends Node

signal state_changed(current_state)

export(NodePath) var initial_state

var states_map = {}
var states_stack = []
var current_state = null
var _active = false setget set_active

func _ready():
	for child in get_children():
		child.connect("finished", self, "_change_state")
	initialize(initial_state)

func initialize(initial_state):
	set_active(true)
	states_stack.push_back(get_node(initial_state))
	current_state = states_stack[states_stack.size() -1]
	current_state.enter()

func set_active(value):
	_active = value
	set_physics_process(value)
	set_process_input(value)
	if not _active:
		states_stack = []
		current_state = null

func _input(event):
	current_state.handle_input(event)

func _physics_process(delta):
	current_state.update(delta)

func _change_state(state_name):
	if not _active:
		return
	current_state.exit()
	if state_name == "previous":
		states_stack.pop_back()
	else:
		states_stack[states_stack.size() -1] = states_map[state_name]
	current_state = states_stack[states_stack.size() -1]
	emit_signal("state_changed", current_state)
	current_state.enter()