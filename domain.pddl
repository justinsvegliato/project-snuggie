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
		(landed ?u - uav)
		(landed-on ?u - uav ?r - robot)
		(clear ?r - robot)
		(charged ?r - robot)
		(has-charger ?l - location)
		(secured ?r - robot ?p - pickable)
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
		:parameters (?t - turtlebot ?from - location ?to - location)
		:duration (= ?duration 
		    (/ (dist ?from ?to) (mv-speed ?u))
		)
		:condition (
		    (at start (loc-at ?t ?from))
		)
		:effect (and
		    (at start (not (loc-at ?t ?from)))
		    (at end (loc-at ?t ?to))
		)
	)

	(:durative-action charge
		:parameters (?t - turtlebot ?l - location)
	    ; TODO Verify the duration
	    :duration (= ?duration 1)
		:condition (and
		    (over all (loc-at ?t ?l))
		    (at start (has-charger ?l))
		)
		:effect (
		    (at end (charged ?t))
		)
	)

	(:durative-action secure-gadget
	    :parameters (?t - turtlebot ?p - pickable ?l - location)
	    ; TODO Verify the duration
		:duration (= ?duration 1)
		:condition (and 
		    (over all (loc-at ?t ?l))
		    (over all (loc-at ?p ?l))
		)
		:effect (
		    (at end (secured ?t ?p))
		)
	)

	(:durative-action move-debris
	)

	(:durative-action return-to-home
	)

	(:durative-action pickup
	    :parameters (?w - wam ?p1 - pickable ?p2 - object)
	    ; TODO Verify the duration
	    :duration (= ?duration 1)
		:condition (and 
		    (over all (loc-at ?t ?l))
		    (over all (loc-at ?p ?l))
		)
		:effect (
		    (at end (secured ?t ?p))
		)
	)

	(:durative-action place
	    :parameters (?w - wam ?p1 - pickable ?p2 - object)
	    ; TODO Verify the duration
	    :duration (= ?duration 1)
		:condition (and 
		)
		:effect (
		)
	)
)
