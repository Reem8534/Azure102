setup:
	python3 -m venv ~/.azure102-env

install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

lint:
	pylint --disable=R,C,W1203,W0702 app.py

test:
	pytest tests/test_app.py

all: install lint test


