class_name Player extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var gravity = 800

@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var state: Label = $State
