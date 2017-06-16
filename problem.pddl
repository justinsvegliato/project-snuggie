(define (problem get-the-code)
	(:domain labrescue)
	(:objects
		home loc1 loc2 - location
		turtle - turtlebot
		dozer - dozerbot
		fire-bep - firedrone
		power-bep - driverdrone
	)

	(:init
		(loc-at turtle home)
		(loc-at dozer home)

		(landed-on power-bep turtle)
		(landed-on fire-bep dozer)

		(= (mv-speed turtle) 2)
		(= (mv-speed dozer) 1)
		(= (fly-speed fire-bep) 10)
		(= (fly-speed power-bep) 10)

		(= (dist home loc1) 40)
		(= (dist loc1 home) 40)
		(= (dist home loc2) 50)
		(= (dist loc2 home) 50)
		(= (dist loc1 loc2) 30)
		(= (dist loc2 loc1) 30)
	)

	(:goal (and
		(landed-on fire-bep dozer)
		(landed-on power-bep turtle)
	))
)
