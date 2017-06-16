(define (problem get-the-code)
    (:domain labrescue)
    (:objects
        dozerbot-home turtlebot-home pickup-area launch-area landing-area secure-area tabletop - location
		fire - location
        turtle - turtlebot
        dozer - dozerbot
        fire-bepop - fire-bepop
        power-bepop - power-bepop
        wam - wam
		computer greenblock - pickable
    )

    (:init
        (loc-at turtle turtlebot-home)
        (loc-at dozer dozerbot-home)

        (landed fire-bepop tabletop)
        (landed power-bepop tabletop)

        (placed greenblock tabletop)
        (placed-above computer greenblock)

		(flyable launch-area)
		(flyable dozerbot-home)
		(flyable landing-area)
		(flyable secure-area)
		(flyable fire)

		(on-fire fire)
		(is-secure secure-area)
		
		(free-arm wam)
		(clear dozer)
		(clear turtle)

		(no-debris launch-area)
		(no-debris pickup-area)
		(no-debris turtlebot-home)

		(reachable pickup-area)
		(reachable tabletop)

		(has-charger turtlebot-home)
		(= (bat-lvl turtle) 5)

		(= (mv-speed turtle) 300)
		(= (fly-speed fire-bepop) 800)
		(= (fly-speed power-bepop) 800)
        
        (= (dist turtlebot-home launch-area) 1355.95)
        (= (dist turtlebot-home pickup-area) 2466.00)
        (= (dist turtlebot-home landing-area) 2528.13)
        (= (dist turtlebot-home dozerbot-home) 3151.72)
        (= (dist turtlebot-home secure-area) 2553.62)
		(= (dist turtlebot-home fire) 2624.293396)
        
        (= (dist launch-area turtlebot-home) 1355.95)
        (= (dist launch-area pickup-area) 1309.31)
        (= (dist launch-area landing-area) 2156.48)
        (= (dist launch-area dozerbot-home) 2024.12)
        (= (dist launch-area secure-area) 2669.47)
		(= (dist launch-area fire) 2421.521467)
        
        (= (dist pickup-area turtlebot-home) 2466.00)
        (= (dist pickup-area launch-area) 1309.31)
        (= (dist pickup-area landing-area) 3224.31)
        (= (dist pickup-area dozerbot-home) 2369.20)
        (= (dist pickup-area secure-area) 3891.10)
		(= (dist pickup-area fire) 3543.517718)
        
        (= (dist landing-area turtlebot-home) 2528.13)
        (= (dist landing-area launch-area) 2156.48)
        (= (dist landing-area pickup-area) 3224.31)
        (= (dist landing-area dozerbot-home) 1694.65)
        (= (dist landing-area secure-area) 935.75)
		(= (dist landing-area fire) 361.781397)
        
        (= (dist dozerbot-home turtlebot-home) 3151.72)
        (= (dist dozerbot-home launch-area) 2024.12)
        (= (dist dozerbot-home pickup-area) 2369.20)
        (= (dist dozerbot-home landing-area) 1694.65)
        (= (dist dozerbot-home secure-area) 2628.47)
		(= (dist dozerbot-home fire) 2044.878352)
        
        (= (dist secure-area turtlebot-home) 2553.62)
        (= (dist secure-area launch-area) 2669.47)
        (= (dist secure-area pickup-area) 3891.10)
        (= (dist secure-area landing-area) 935.75)
        (= (dist secure-area dozerbot-home) 2628.47)
		(= (dist secure-area fire) 610.4140521)

		(= (dist fire turtlebot-home) 2624.293396)
		(= (dist fire launch-area) 2421.521467)
		(= (dist fire pickup-area) 3543.517718)
		(= (dist fire landing-area) 361.781397)
		(= (dist fire dozerbot-home) 2044.878352)
		(= (dist fire secure-area) 610.4140521)
    )

	(:goal (and
		(computer-secured computer)
		(landed fire-bepop landing-area)
	))
)
