CURRENT_DIR := $(shell pwd)
SHORTCUT_BIN = ${CURRENT_DIR}/target/release/shortcuts
BASH_FILE = ${CURRENT_DIR}/s.sh
ALIAS = alias s='. ${BASH_FILE}'
BASE_ALIAS = echo "$(ALIAS)" >> ${HOME}/

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
	$(MAKE) permanent-alias
	echo "Installed successfully"
permanent-alias:
	if [ ${HOME}/.bashrc ]; then \
		${BASE_ALIAS}.bashrc; \
		source ${HOME}/.bashrc; \
	fi
	if [ ${HOME}/.zshrc ]; then \
		${BASE_ALIAS}.zshrc; \
		source ${HOME}/.zshrc; \
	fi
	if [ ${HOME}/.bash_profile ]; then \
		${BASE_ALIAS}.bash_profile; \
		source ${HOME}/.bash_profile; \
	fi