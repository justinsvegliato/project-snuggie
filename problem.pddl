(define (problem get-the-code)
	(:domain labrescue)
	(:objects
		dozerbot-home turtlebot-home pickup-area launch-area landing-area secure-area - location
		turtle - turtlebot
		dozer - dozerbot
		fire-bepop - fire-bepop
		power-bepop - power-bepop
		wam - wam
	)

	(:init
        (loc-at turtle turtlebot-home)
        (loc-at dozerbot dozerbot-home)
        (loc-at fire-bepop pickup-area)
        (loc-at power-bepop pickup-area)
        
        (= (dist turtlebot-home launch-area) 0)
        (= (dist turtlebot-home pickup-area) 0)
        (= (dist turtlebot-home landing-area) 0)
        (= (dist turtlebot-home dozerbot-home) 0)
        (= (dist turtlebot-home secure-area) 0)
        
        (= (dist launch-area turtlebot-home) 0)
        (= (dist launch-area pickup-area) 0)
        (= (dist launch-area landing-area) 0)
        (= (dist launch-area dozerbot-home) 0)
        (= (dist launch-area secure-area) 0)
        
        (= (dist pickup-area turtlebot-home) 0)
        (= (dist pickup-area launch-area) 0)
        (= (dist pickup-area landing-area) 0)
        (= (dist pickup-area dozerbot-home) 0)
        (= (dist pickup-area secure-area) 0)
        
        (= (dist landing-area turtlebot-home) 0)
        (= (dist landing-area launch-area) 0)
        (= (dist landing-area pickup-area) 0)
        (= (dist landing-area dozerbot-home) 0)
        (= (dist landing-area secure-area) 0)
        
        (= (dist dozerbot-home turtlebot-home) 0)
        (= (dist dozerbot-home launch-area) 0)
        (= (dist dozerbot-home pickup-area) 0)
        (= (dist dozerbot-home landing-area) 0)
        (= (dist dozerbot-home secure-area) 0)
        
        (= (dist secure-area turtlebot-home) 0)
        (= (dist secure-area launch-area) 0)
        (= (dist secure-area pickup-area) 0)
        (= (dist secure-area landing-area) 0)
        (= (dist secure-area dozerbot-home) 0)
	)

	(:goal (and
		(landed-on fire-bep dozer)
		(landed-on power-bep turtle)
	))
)
