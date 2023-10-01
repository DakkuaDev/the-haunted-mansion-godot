extends AnimationPlayer


func fade_in():
	self.play("FadeInEffectAnim")
	
	var timer = Timer.new()
	timer.connect("timeout",fade_out, 0) 
	timer.wait_time = 1
	timer.one_shot = true
	add_child(timer)
	timer.start()

func fade_out():
	self.play("FadeOutEffectAnim")
	
	




