extends Reference
class_name NetAPI

const version = 1

enum Commands {
	GLOBAL_PARAM_GET,
	GLOBAL_PARAM_SET,
	GLOBAL_PARAM_LIST,
	GAMES_LIST,
	GAME_PARAM_GET,
	GAME_PARAM_SET,
	GAME_PARAM_LIST,
}

enum Responses {
	OK, # Command executed succesfully
	BUG, # Unexpected error
	ERROR, # Misc error. See error message
	INVALID_DATA, # Packet doesn't have the right format
	INVALID_COMMAND, 
	INCORRECT_PARAM_COUNT,
	INCORRECT_PARAM_TYPE,
}

class Response:
	var type
	var data
	func _init( p_type : int, p_data : Dictionary ):
		type = p_type
		data = p_data
	func as_array() -> Array:
		return [type, data]
	static func from_array( arr : Array ):
		if arr.size() != 2:
			return Response.new(Responses.ERROR, { "message" : "Ivalid array size" })
		if typeof(arr[0]) != TYPE_INT or typeof(arr[1]) != TYPE_DICTIONARY:
			return Response.new(Responses.ERROR, { "message" : "Ivalid array element type" })
		return Response.new(arr[0], arr[1])

const COMMAND_INFO = {
	Commands.GLOBAL_PARAM_GET: {
		"description" : "Retrieves a global gameplay param",
		"parameters" : [
			{
				"name" : "key",
				"type" : TYPE_STRING,
				"description" : "A unique key identifying the param",
			}
		],
	},
	Commands.GLOBAL_PARAM_SET: {
		"description" : "Sets a global gameplay param",
		"parameters" : [
			{
				"name" : "key",
				"type" : TYPE_STRING,
				"description" : "A unique key identifying the param",
			},
			{
				"name" : "value",
				"description" : "A Variant with the value to set",
			},
		],
	},
	Commands.GLOBAL_PARAM_LIST: {
		"description" : "Gets the list of global params and its type hints",
		"parameters" : [],
	},
	Commands.GAMES_LIST: {
		"description" : "Gets the list of games as a dictionary<int id, String name>",
		"parameters" : [],
	},
	Commands.GAME_PARAM_GET: {
		"description" : "Retrieves a specific param for a specific game",
		"parameters" : [
			{
				"name" : "game",
				"type" : TYPE_INT,
				"description" : "An int identifying the game"
			},
			{
				"name" : "key",
				"type" : TYPE_STRING,
				"description" : "A unique(within that game) key identifying the param",
			},
		],
	},
	Commands.GAME_PARAM_SET: {
		"description" : "Sets a specific param for a specific game",
		"parameters" : [
			{
				"name" : "game",
				"type" : TYPE_INT,
				"description" : "An int identifying the game"
			},
			{
				"name" : "key",
				"type" : TYPE_STRING,
				"description" : "A unique(within that game) key identifying the param",
			},
			{
				"name" : "value",
				"description" : "A Variant with the value to set",
			},
		],
	},
	Commands.GAME_PARAM_LIST: {
		"description" : "Gets the list of gameplay params for a specific game, and its type hints",
		"parameters" : [
			{
				"name" : "game",
				"type" : TYPE_INT,
				"description" : "An int identifying the game"
			},
		],
	},
}

