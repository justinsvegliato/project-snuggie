(define (domain lab-rescue)
	(:requirements
		:typing
		:numeric-fluents
		:durative-actions
		:duration-inequalities
	)

	(:types
		location locatable pickable - object
		wam robot uav - locatable
		turtlebot dozerbot - robot
		fire-bepop power-bepop - uav
		computer greenblock - pickable
	)

	(:predicates
		(computer-secured ?c - computer)
	)

	(:functions
	)

	(:durative-action launch-from-ground
		:parameters (?u - uav ?r - robot ?l - location)
	)

	(:durative-action launch-from-
		:parameters (?u - uav ?r - robot ?l - location)
	)

	(:durative-action fly-to
		:parameters (?u - uav ?from - location ?to - location)
	)

	(:durative-action land
		:parameters (?u - uav)
	)

	(:durative-action land-on-robot
		:parameters (?u - uav)
	)

	(:durative-action put-out-fire
		:parameters (?u - fire-bepop)
	)

	(:durative-action power-dozerbot
		:parameters (?u - power-bepop)
	)

	(:durative-action drive-to
		:parameters (?t - turtlebot)
	)

	(:durative-action move
		:parameters (?w - wam ?o - pickable)
	)

	(:durative-action charge
	)

	(:durative-action secure-gadget
	)

	(:durative-action move-debris
	)

	(:durative-action return-to-home
	)

	(:durative-action pickup
	)

	(:durative-action place
	)
)
