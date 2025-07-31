extends Node
# Here is a singleton bus that will be a list of signals 
# used throughout the game. Different parts of code will connect signals to this bus while other parts of
# code may emit or handle those signals.

signal empty()

# Labeling scheme for triggers and levels, universal triggers don't need a prefix for what level its used in.
signal exit_reached(object)
signal player_death(player)

signal level_0_obtain_key
