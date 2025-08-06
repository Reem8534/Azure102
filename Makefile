setup:
	python3 -m venv ~/.udacity-devops

install:
	. ~/.udacity-devops/bin/activate && pip install --upgrade pip && \
	pip install -r requirements.txt

test:
	. ~/.udacity-devops/bin/activate && python -m pytest -vv

lint:
	. ~/.udacity-devops/bin/activate && pylint --disable=R,C,W1203 app.py

all: install lint test
