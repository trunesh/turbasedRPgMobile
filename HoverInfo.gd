 extends Control


export(String , MULTILINE ) var description =  ""
 

func _on_HoverInfo_mouse_entered():
	var main = get_tree().current_scene
	var textBox =	main.find_node("TextBox")
	if textBox != null:
		textBox.text = description


func _on_HoverInfo_mouse_exited():
	var main = get_tree().current_scene
	var textBox =	main.find_node("TextBox")
	if textBox != null:
		textBox.text = "Welcome to Dark Rooms, I have great naming sense"
