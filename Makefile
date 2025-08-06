setup:
	python3 -m venv venv

install:
	. venv/bin/activate && pip install --upgrade pip && \
	pip install -r requirements.txt

test:
	. venv/bin/activate && python -m pytest -vv

lint:
	. venv/bin/activate && pylint --disable=R,C,W1203 ./app.py

all: install lint test
