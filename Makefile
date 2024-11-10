NAME         := ld_warn_mre
IN_CONTAINER := docker run --name $(NAME) --rm -v ./wd:/wd -w /wd $(NAME) 
FIND_IMG     := docker images --format '{{.Repository}}' | grep -wq $(NAME)

.PHONY: FORCE

run: build FORCE
	$(IN_CONTAINER) make

info: build FORCE
	$(IN_CONTAINER) make info

build: FORCE
	$(FIND_IMG) || docker build . -t $(NAME)

fclean: FORCE
	-$(FIND_IMG) && $(IN_CONTAINER) make fclean
	docker rmi $(NAME)
