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
		(loc-at ?o - locatable ?l - location)
		(flying ?u - uav)
		(landed ?u - uav ?l - location)
		(landed-on ?u - uav ?r - robot)
		(clear ?r - robot)
		(on-fire ?l - location)
	)

	(:functions
		(dist ?from - location ?to - location)
		(mv-speed ?r - robot)
		(fly-speed ?u - uav)
	)

	(:durative-action launch-from-ground
		:parameters (?u - uav ?l - location)
		:duration (= ?duration 1)
		:condition (and
			(over all (loc-at ?u ?l))
			(at start (landed ?u ?l))
		)
		:effect (and
			(at start (not (landed ?u ?l)))
			(at end (flying ?u))
		)
	)

	(:durative-action launch-from-robot
		:parameters (?u - uav ?r - robot ?l - location)
		:duration (= ?duration 1)
		:condition (and
			(over all (loc-at ?r ?l))
			(at start (landed-on ?u ?r))
		)
		:effect (and
			(at start (not (landed-on ?d ?r)))
			(at start (loc-at ?u ?l))
			(at end (flying ?u))
			(at end (clear ?r))
		)
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
		:duration (= ?duration 1)
		:condition (and
			(over all (loc-at ?u ?l))
			(at start (flying ?u))
		)
		:effect (and
			(at end (not (flying ?u)))
			(at end (landed-on ?u ?r))
		)
	)

	(:durative-action land-on-robot
		:parameters (?u - uav ?r - robot ?l - location)
		:duration (= ?duration 1)
		:condition (and
			(over all (loc-at ?u ?l))
			(over all (loc-at ?r ?l))
			(at start (flying ?u))
			(at start (clear ?r))
		)
		:effect (and
			(at start (not (clear ?r)))
			(at end (not (loc-at ?u ?l)))
			(at end (not (flying ?u)))
			(at end (landed-on ?u ?r))
		)
	)

	(:durative-action put-out-fire
		:parameters (?u - fire-bepop ?l - location)
		:duration (= ?duration 1)
		:condition (and
			(over all (loc-at ?u ?l))
			(over all (flying ?u))
		)
		:effect (and
			(at end (not (on-fire ?l)))
		)
	)

	(:durative-action power-dozerbot
		:parameters (?u - power-bepop ?r - dozerbot)
		:duration (= ?duration 1)
		:condition (and
			(over all (landed-on ?u ?r))
		)
		:effect (and
			(at start (dozer-on ?r))
		)
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
