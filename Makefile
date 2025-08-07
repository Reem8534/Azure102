# Create virtual environment (run once manually)
setup:
	python3 -m venv ~/.azure102-env

# Install dependencies, upgrading pip first
install:
	~/.azure102-env/bin/pip install --upgrade pip
	~/.azure102-env/bin/pip install -r requirements.txt

# Run pylint with some warnings disabled
lint:
	~/.azure102-env/bin/pylint --disable=R,C,W1203,W0702 app.py

test:
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb


all: install lint test
