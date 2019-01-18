release:
	pkgr package .
build_docker:
	docker build . -t mcansky/sinatra_hello:latest
	docker tag mcansky/sinatra_hello:latest mcansky/sinatra_hello:`git rev-parse HEAD`
push_docker:
	docker push mcansky/sinatra_hello:latest
	docker push mcansky/sinatra_hello:`git rev-parse HEAD`
