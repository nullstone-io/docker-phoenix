build:
	docker buildx build \
		--push \
		--builder=container \
		--platform=linux/amd64,linux/arm64 \
		-t nullstone/phoenix:local \
		-f local.Dockerfile \
		.

	docker buildx build \
		--push \
		--builder=container \
		--platform=linux/amd64,linux/arm64 \
		-t nullstone/phoenix \
		-f Dockerfile \
		.
