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
		(?loc-at ?o - locatable ?l - location)
		(flying ?u - uav)
		(landed ?u - uav)
		(landed-on ?u - uav ?r - robot)
		(clear ?r - robot)

		(dozer-on)
		(dozer-at-home)
		(fire-on)
		(debris-cleared)
	)

	(:functions
		(dist ?from - location ?to - location)
		(mv-speed ?r - robot)
		(fly-speed ?u - uav)
	)

	(:durative-action launch-from-ground
		:parameters (?u - uav ?l - location)
		:duration (= ?duration 1)
	)

	(:durative-action launch-from-robot
		:parameters (?u - uav ?r - robot ?l - location)
		:duration (= ?duration 1)
	)

	(:durative-action fly-to
		:parameters (?u - uav ?from - location ?to - location)
		:duration (= ?duration
			(/ (dist ?from ?to) (fly-speed ?u))
		)
		:condition (and
			(over all (flying ?u))
			(at start (loc-at ?u ?from))
		)
		:effect (and
			(at start (not (loc-at ?u ?from)))
			(at end (loc-at ?u ?to))
		)
	)

	(:durative-action land-on-ground
		:parameters (?u - uav ?l - location)
	)

	(:durative-action land-on-robot
		:parameters (?u - uav ?r - robot ?l - location)
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
		:duration (= ?duration 100)
		:condition (and
			(at start (fire-off))
			(over all (dozer-on))		
		)
		:effect (and
			(at end (debris-cleared))
		)
	)

	(:durative-action return-to-home
		:duration (= ?duration 100)
		:condition (and
			(over all (dozer-on))
			(at start (fire-off))
			(over all (debris-cleared))
		)
		:effect (and
			(at end (dozer-at-home))
		)
	)

	(:durative-action pickup
	)

	(:durative-action place
	)
)
