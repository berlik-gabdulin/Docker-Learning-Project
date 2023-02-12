mongo:
	docker run -p 27017:27017 \
		-d \
		--rm \
		--name mongodb \
		--network notes-net \
		--env-file ./config/development.env \
		-v mongo-data:/data/db \
		mongo

back:
	docker run -p 5000:5000 \
		-d \
		--rm \
		--name notes-backend \
		--network notes-net \
		-v /Users/icepanda/Projects/DockerNode/server:/app  \
		-v /app/node_modules \
		--env-file ./config/development.env \
		notes-backend

front:
	docker run -p 3000:3000 \
		-d \
		--rm \
		--name notes-frontend \
		-v /Users/icepanda/Projects/DockerNode/client/src:/app/src  \
		notes-frontend

start:
	make mongo back front

b_back:
	cd server && docker build -t notes-backend .

b_front:
	cd client && docker build -t notes-frontend .

re_b_back:
	make s_back && b_back && make back

re_b_front:
	make s_front && b_front && make front

s_mongo:
	docker stop mongodb

s_back:
	docker stop notes-backend

s_front:
	docker stop notes-frontend

stop:
	make s_mongo s_back s_front

dev:
	docker-compose -f docker-compose.yml up -d

build:
	docker-compose -f docker-compose.production.yml up

down:
	docker-compose down