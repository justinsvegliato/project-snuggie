(define (domain lab-rescue)
    (:requirements
        :typing
        :numeric-fluents
		:equality
        :durative-actions
        :duration-inequalities
    )

    (:types
        location locatable - object
        wam robot uav pickable - locatable
        turtlebot dozerbot - robot
        fire-bepop power-bepop - uav
    )

    (:predicates
        (loc-at ?o - locatable ?l - location)

		(flyable ?l - location)
        (flying ?u - uav)
        (landed ?u - uav ?l - location)
        (landed-on ?u - uav ?r - robot)
        (clear ?r - robot) 

        (dozer-on)
        (dozer-at-home)
        (fire-off)
        (debris-cleared)

        (on-fire ?l - location)
        (has-charger ?l - location)
		(is-secure ?l - location)

        (computer-secured ?p - pickable)

		(reachable ?l - location)
		(placed ?top - pickable ?l - location)
		(placed-above ?top - pickable ?bot - pickable)
		(placed-on ?p - pickable ?t - turtlebot)
		(free-arm ?w - wam)
		(holding-u ?w - wam ?u - uav)
		(holding-p ?w - wam ?p - pickable)
    )

    (:functions
        (dist ?from - location ?to - location)
        (mv-speed ?r - robot)
        (fly-speed ?u - uav)

		(bat-lvl ?t - turtlebot)
		(chr-speed ?t - turtlebot)
    )

    (:durative-action launch-from-ground
        :parameters (?u - uav ?l - location)
        :duration (= ?duration 3)
        :condition (and
			(over all (flyable ?l))
            (at start (landed ?u ?l))
        )
        :effect (and
            (at start (not (landed ?u ?l)))
            (at end (loc-at ?u ?l))
            (at end (flying ?u))
        )
    )

    (:durative-action launch-from-robot
        :parameters (?u - uav ?r - robot ?l - location)
        :duration (= ?duration 3)
        :condition (and
            (over all (loc-at ?r ?l))
            (at start (landed-on ?u ?r))
        )
        :effect (and
            (at start (not (landed-on ?u ?r)))
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
            (over all (flyable ?to))
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
        :duration (= ?duration 5)
        :condition (and
            (over all (loc-at ?u ?l))
            (at start (flying ?u))
        )
        :effect (and
            (at end (not (flying ?u)))
            (at end (landed ?u ?l))
        )
    )

    (:durative-action land-on-robot
        :parameters (?u - uav ?r - robot ?l - location)
        :duration (= ?duration 12)
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
        :duration (= ?duration 2)
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
        :duration (= ?duration 2)
        :condition
            (over all (landed-on ?u ?r))
        :effect
            (at start (dozer-on))
    )

    (:durative-action drive-to
        :parameters (?t - turtlebot ?from - location ?to - location)
        :duration (= ?duration 
            (/ (dist ?from ?to) (mv-speed ?t))
        )
        :condition (and
            (at start (loc-at ?t ?from))
			(at start (> (bat-lvl ?t) 0))
		)
        :effect (and
            (at start (not (loc-at ?t ?from)))
            (at end (loc-at ?t ?to))
			(at end (decrease (bat-lvl ?t) 1))
        )
    )

    (:durative-action charge
        :parameters (?t - turtlebot ?l - location)
        :duration (= ?duration 5)
        :condition (and
            (over all (loc-at ?t ?l))
            (at start (has-charger ?l))
			(at start (< (bat-lvl ?t) 5))
		)
        :effect
			(at end (assign (bat-lvl ?t) 5))
    )

    (:durative-action secure-gadget
        :parameters (?t - turtlebot ?p - pickable ?l - location)
        :duration (= ?duration 2)
        :condition (and 
            (over all (loc-at ?t ?l))
            (over all (is-secure ?l))
            (over all (placed-on ?p ?t))
        )
        :effect
            (at start (computer-secured ?p))
    )

    (:durative-action move-debris
        :parameters ()
        :duration (= ?duration 15)
        :condition (and
            (at start (fire-off))
            (over all (dozer-on))       
        )
        :effect
            (at end (debris-cleared))
    )

    (:durative-action return-to-home
        :parameters ()
        :duration (= ?duration 15)
        :condition (and
            (over all (dozer-on))
            (at start (fire-off))
            (over all (debris-cleared))
        )
        :effect
            (at end (dozer-at-home))
    )

	(:durative-action pickup-uav-loc
		:parameters (?w - wam ?u - uav ?l - location)
		:duration (= ?duration 10)
		:condition (and
			(over all (reachable ?l))
			(at start (landed ?u ?l))
			(at start (free-arm ?w))
		)
		:effect (and
			(at start (not (free-arm ?w)))
			(at start (not (landed ?u ?l)))
			(at end (holding-u ?w ?u))
		)
	)

	(:durative-action pickup-gadget-other
		:parameters (?w - wam ?top - pickable ?bot - pickable)
		:duration (= ?duration 10)
		:condition (and
			(at start (placed-above ?top ?bot))
			(at start (free-arm ?w))
		)
		:effect (and
			(at start (not (free-arm ?w)))
			(at start (not (placed-above ?top ?bot)))
			(at end (holding-p ?w ?top))
		)
	)

	(:durative-action place-uav-loc
		:parameters (?w - wam ?u - uav ?l - location)
		:duration (= ?duration 10)
		:condition (and
			(over all (reachable ?l))
			(at start (holding-u ?w ?u))
		)
		:effect (and
			(at end (not (holding-u ?w ?u)))
			(at end (free-arm ?w))
			(at end (landed ?u ?l))
		)
	)

	(:durative-action place-gadget-robot
		:parameters (?w - wam ?p - pickable ?t - turtlebot ?l - location)
		:duration (= ?duration 10)
		:condition (and
			(over all (reachable ?l))
			(over all (loc-at ?t ?l))
			(at start (clear ?t))
			(at start (holding-p ?w ?p))
		)
		:effect (and
			(at start (not (clear ?t)))
			(at end (free-arm ?w))
			(at end (placed-on ?p ?t))
		)
	)
)
