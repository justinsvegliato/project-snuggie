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

		(dozer-on)
		(dozer-at-home)
		(fire-off)
		(debris-cleared)

		(on-fire ?l - location)
		(fire-off)
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
			(at start (on-fire ?l))
		)
		:effect (and
			(at end (not (on-fire ?l)))
			(at end (fire-off))
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
		:parameters (?t - turtlebot ?from - location ?to - location)
		:duration (= ?duration 
		    (/ (dist ?from ?to) (mv-speed ?u))
		)
		:condition (
		    (at start (at-loc ?t ?from))
		)
		:effect (and
		    (at start (not (at-loc ?t ?from)))
		    (at end (at-loc ?t ?to))
		)
	)

; 	(:durative-action move
; 		:parameters (?w - wam ?o - pickable)
; 		:duration (
; 		)
; 		:condition (
; 		)
; 		:effect (
; 		)
; 	)

	(:durative-action charge
		:parameters (?t - turtlebot ?l - location)
	    ; TODO Verify the duration
	    :duration (= ?duration 1)
		:condition (and
		    (over all (at-loc ?t ?l))
		    (at start (has-charger ?l))
		)
		:effect (
		    (at end (charged ?t))
		)
	)

	(:durative-action secure-gadget
	    :parameters (?t - turtlebot ?g - pickable ?l - location)
	    ; TODO Verify the duration
		:duration (= ?duration 1)
		:condition (and 
		    (over all (at-loc ?t ?l))
		    (over all (at-loc ?g ?l))
		)
		:effect (
		    (at end (secured ?t ?g))
		)
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
