CURRENT_DIR := $(shell pwd)
SHORTCUT_BIN = ${CURRENT_DIR}/target/release/shortcuts
BASH_FILE = ${CURRENT_DIR}/s.sh

create-config:
	mkdir -p ${HOME}/.config/rshortcuts
	if [ ! -f ${HOME}/.config/rshortcuts/setup.json ]; then \
		cp ./setup.example.json ${HOME}/.config/rshortcuts/setup.json; \
	fi
install: 
	$(MAKE) create-config
	cargo build --release
	echo 'eval $$(${SHORTCUT_BIN} $$1)' > ${BASH_FILE}
	chmod +x ${BASH_FILE}
	alias s='. ${BASH_FILE}'