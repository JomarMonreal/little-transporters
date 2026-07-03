extends GameplayState

func physics_process(delta: float) -> int:
	var gameplay := entity as Gameplay
		
	return GameplayState.State.Playing
