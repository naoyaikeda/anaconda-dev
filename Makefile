WSLPROCPATH=/proc/sys/fs/binfmt_misc/WSLInterop
USER=nikeda
NAME=anaconda-dev
VERSION=0.0.0
build:
	docker build -t $(USER)/$(NAME):$(VERSION) .
build-no-cache:
	docker build --no-cache=true -t $(USER)/$(NAME):$(VERSION) .

restart: stop start

start:
ifneq ("$(wildcard $(WSLPROCPATH))","")
	docker run -it --rm \
		-v `wslpath -w $$PWD`/works:/works \
		-p 8080:8080 \
		--name $(NAME) \
		$(USER)/$(NAME):$(VERSION)
else
	docker run -it --rm \
		-v $$PWD/worker:/home/worker\
		-p 10000:8080 \
		--name $(NAME) \
		$(USER)/$(NAME):$(VERSION)
endif
stop:
	docker stop $(NAME)
