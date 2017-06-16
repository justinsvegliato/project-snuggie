(define (domain labrescue)
	(:requirements
		:duration-inequalities
		:durative-actions
		:numeric-fluents
		:typing
	)

	(:types
		location locatable - object
		robot wam drone - locatable
		turtlebot dozerbot - robot
		firedrone driverdrone - drone
	)

	(:predicates
		(loc-at ?o - locatable ?l - location)
		(landed-on ?d - drone ?r - robot)
		(flying ?d - drone)
		(clear ?r - robot)
	)

	(:functions
		(dist ?l1 - location ?l2 - location)
		(mv-speed ?r - robot)
		(fly-speed ?d - drone)
	)

	(:durative-action move-t
		:parameters (?r - turtlebot ?l1 - location ?l2 - location)
		:duration (= ?duration 
			(/ (dist ?l1 ?l2) (mv-speed ?r))	
		)
		:condition (and
			(at start (loc-at ?r ?l1))
		)
		:effect (and
			(at start (not (loc-at ?r ?l1)))
			(at end (loc-at ?r ?l2))
		)
	)

	(:durative-action move-d
		:parameters (?r - dozerbot ?d - driverdrone ?l1 - location ?l2 - location)
		:duration (= ?duration 
			(/ (dist ?l1 ?l2) (mv-speed ?r))	
		)
		:condition (and
			(over all (landed-on ?d ?r))
			(at start (loc-at ?r ?l1))
		)
		:effect (and
			(at start (not (loc-at ?r ?l1)))
			(at end (loc-at ?r ?l2))
		)
	)

	(:durative-action fly
		:parameters (?d - drone ?l1 - location ?l2 - location)
		:duration (= ?duration 
			(/ (dist ?l1 ?l2) (fly-speed ?d))	
		)
		:condition (and
			(over all (flying ?d))
			(at start (loc-at ?d ?l1))
		)
		:effect (and
			(at start (not (loc-at ?d ?l1)))
			(at end (loc-at ?d ?l2))
		)
	)

	(:durative-action take-off
		:parameters (?d - drone ?r - robot ?l - location)
		:duration (= ?duration 1)
		:condition (and
			(at start (landed-on ?d ?r))
			(at start (loc-at ?r ?l))
		)
		:effect (and
			(at start (not (landed-on ?d ?r)))
			(at start (loc-at ?d ?l))
			(at end (flying ?d))
			(at end (clear ?r))
		)
	)

	(:durative-action land
		:parameters (?d - drone ?r - robot ?l - location)
		:duration (= ?duration 1)
		:condition (and
			(over all (loc-at ?d ?l))
			(over all (loc-at ?r ?l))
			(at start (flying ?d))
			(at start (clear ?r))
		)
		:effect (and
			(at start (not (clear ?r)))
			(at end (not (loc-at ?d ?l)))
			(at end (not (flying ?d)))
			(at end (landed-on ?d ?r))
		)
	)
)
