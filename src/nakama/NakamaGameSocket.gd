extends Node2D
class_name NakamaGameSocket

signal _on_match_finished(player_winner_slot: int, return_code: int)
signal _on_match_ready_to_load()
signal _on_socket_setup_done()
#signal _on_level_ready(level: Level) # is used in the level node


@export var multiplayer_level_spawner: MultiplayerSpawner = null

const MAX_FAILED_CONNECTIONS = 10
const MINIMUM_PING = 10000

var pings_reviced = []
var nakama_ping = 999
var ping_counter = 0
var failed_connection_counter = 0

var socket: NakamaSocket = null
var mp_bridge: NakamaMultiplayerBridge = null
var matchmaking_ticket: NakamaRTAPI.MatchmakerTicket = null
var nakama_match: NakamaRTAPI.MatchmakerMatched = null
var other_player_net_ids:Array = []


func init_socket_connection(galaxy_client: NakamaWebClient):
	if socket != null:
		socket.close()
	socket = Nakama.create_socket_from(galaxy_client.nakama_client)
	socket.connected.connect(self._on_socket_connected)
	socket.closed.connect(self._on_socket_closed)
	socket.received_error.connect(self._on_socket_error)
	socket.received_matchmaker_matched.connect(self._on_matchmaker_matched)
	socket.received_match_presence.connect(self.received_match_presence)
	await socket.connect_async(galaxy_client.nakama_session)
	mp_bridge = NakamaMultiplayerBridge.new(socket)
	mp_bridge.match_join_error.connect(self._on_match_join_error)
	mp_bridge.match_joined.connect(self._on_match_joined)
	get_tree().get_multiplayer().set_multiplayer_peer(mp_bridge.multiplayer_peer)
	get_tree().get_multiplayer().peer_connected.connect(self._on_peer_connected)
	get_tree().get_multiplayer().peer_disconnected.connect(self._on_peer_disconnected)
	_on_socket_setup_done.emit()


func am_i_server():
	return get_tree().get_multiplayer().get_unique_id() == 1


func join_match_making():
	if matchmaking_ticket != null:
		await socket.remove_matchmaker_async(matchmaking_ticket.ticket)
		matchmaking_ticket = null
	matchmaking_ticket = await socket.add_matchmaker_async("*",2,2)
	if matchmaking_ticket.is_exception() == true:
		push_error("ERROR IN MM TICKET:")
		push_error(matchmaking_ticket.get_exception())
		return false
	mp_bridge.start_matchmaking(matchmaking_ticket)
	return true


func received_match_presence(_presence):
	pass

func get_own_net_id():
	return get_tree().get_multiplayer().get_unique_id()

func leave_match_making():
	await socket.remove_matchmaker_async(matchmaking_ticket.ticket)
	mp_bridge.leave()


func get_user_to_read_data(p_matched: NakamaRTAPI.MatchmakerMatched):
	for user in p_matched.users:
		if user != nakama_match.self_user:
			return user.presence


func _on_matchmaker_matched(p_matched : NakamaRTAPI.MatchmakerMatched):
	if p_matched != null:
		nakama_match = p_matched
	print("TWES_on_socket_setup_done_on_socket_setup_done")


func leave_match(winner_player_slot: int, return_code: int):
	mp_bridge.leave()
	socket.close()
	nakama_match = null
	#SyncManager.clear_peers()
	_on_match_finished.emit(winner_player_slot,return_code)


func _on_peer_connected(peer_id):
	#SyncManager.add_peer(peer_id)
	other_player_net_ids.append(peer_id)
	if am_i_server() == true:
		await get_tree().create_timer(2.0).timeout
	_on_match_ready_to_load.emit()


func _on_peer_disconnected(peer_id):
	#SyncManager.remove_peer(peer_id)
	if peer_id > 1:
		_on_match_finished.emit()
	elif peer_id == 1:
		_on_match_finished.emit()


func _on_match_join_error(error):
	print ("Unable to join match: ", error.message)


func _on_match_joined() -> void:
	print ("Joined match with id: ", mp_bridge.match_id)



func _on_socket_connected():
	print("Socket connected")


func _on_socket_closed():
	print("Socket closed.")


func _on_socket_error(err):
	printerr("Socket error %s" % err)


@rpc("authority", "reliable")
func _add_player_to_match():
	pass


@rpc("any_peer","reliable")
func data_recived():
	pass
	#if GameStatics.IS_MATCH_SERVER == true:
		#pass
