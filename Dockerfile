FROM ubuntu:22.04

RUN apt update && \
	apt install -y \
	build-essential \
	clang-13 \
	clang-14
