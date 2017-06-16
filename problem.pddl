(define (problem get-the-code)
    (:domain labrescue)
    (:objects
        dozerbot-home turtlebot-home pickup-area launch-area landing-area secure-area - location
		fire-loc table-loc - location
		tabletop - platform
        turtle - turtlebot
        dozer - dozerbot
        fire-bepop - fire-bepop
        power-bepop - power-bepop
        wam - wam
    )

    (:init
        (loc-at turtle turtlebot-home)
        (loc-at dozer dozerbot-home)
        (loc-at fire-bepop pickup-area)
        (loc-at power-bepop pickup-area)

		(flyable launch-area)
		(flyable dozerbot-home)
		(flyable landing-area)
		(flyable secure-area)
		(flyable fire-loc)

		(on-fire fire-loc)
		(is-secure secure-area)

		(can-pick-from pickup-area)
		(can-pick-from table-loc)
		(loc-at tabletop table-loc)

		(has-charger turtlebot-home)
		(= (chr-speed turtle) 1)
		(= (bat-lvl turtle) 5)
        
        (= (dist turtlebot-home launch-area) 1355.95)
        (= (dist turtlebot-home pickup-area) 2466.00)
        (= (dist turtlebot-home landing-area) 2528.13)
        (= (dist turtlebot-home dozerbot-home) 3151.72)
        (= (dist turtlebot-home secure-area) 2553.62)
        
        (= (dist launch-area turtlebot-home) 1355.95)
        (= (dist launch-area pickup-area) 1309.31)
        (= (dist launch-area landing-area) 2156.48)
        (= (dist launch-area dozerbot-home) 2024.12)
        (= (dist launch-area secure-area) 2669.47)
        
        (= (dist pickup-area turtlebot-home) 2466.00)
        (= (dist pickup-area launch-area) 1309.31)
        (= (dist pickup-area landing-area) 3224.31)
        (= (dist pickup-area dozerbot-home) 2369.20)
        (= (dist pickup-area secure-area) 3891.10)
        
        (= (dist landing-area turtlebot-home) 2528.13)
        (= (dist landing-area launch-area) 2156.48)
        (= (dist landing-area pickup-area) 3224.31)
        (= (dist landing-area dozerbot-home) 1694.65)
        (= (dist landing-area secure-area) 935.75)
        
        (= (dist dozerbot-home turtlebot-home) 3151.72)
        (= (dist dozerbot-home launch-area) 2024.12)
        (= (dist dozerbot-home pickup-area) 2369.20)
        (= (dist dozerbot-home landing-area) 1694.65)
        (= (dist dozerbot-home secure-area) 2628.47)
        
        (= (dist secure-area turtlebot-home) 2553.62)
        (= (dist secure-area launch-area) 2669.47)
        (= (dist secure-area pickup-area) 3891.10)
        (= (dist secure-area landing-area) 935.75)
        (= (dist secure-area dozerbot-home) 2628.47)
    )

    (:goal (and
    ))
)
