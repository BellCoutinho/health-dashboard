SHELL := /bin/bash
VENV := .venv
VENV_ACTIVATE := $(VENV)/bin/activate
PYTHON := $(VENV)/bin/python3
REQUIREMENTS_PATH := requirements.txt requirements-dev.txt
DEV_REQUIREMENTS_LIST := "-r requirements.txt"\
						 pytest==7.1.2

all: setup

setup:

	@if [ ! -d $(VENV) ]; then                          \
		echo "-> Creating a python virtual environment";\
		python -m venv $(VENV);                         \
		echo "-> Updating the Pip";                     \
		echo "-> Activating the environment";           \
		source $(VENV_ACTIVATE);                        \
		$(VENV)/bin/pip install -U pip;                 \
	fi

	@for requirement in $(REQUIREMENTS_PATH); do   \
		echo "-> Creating the $$requirement file"; \
		>$$requirement;                            \
	done

requirements:
	@for requirement in $(DEV_REQUIREMENTS_LIST); do       \
		echo "Add $$requirement as development dependency";\
		echo "$$requirement" >> requirements-dev.txt;      \
	done

teardown:
	rm -rf $(VENV)
	rm -rf $(REQUIREMENTS_PATH)
