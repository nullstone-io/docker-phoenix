build:
	docker build -t nullstone/phoenix:local -f local.Dockerfile .
	docker build -t nullstone/phoenix .

push:
	docker push nullstone/phoenix:local
	docker push nullstone/phoenix
