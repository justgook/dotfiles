SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
include make/colors.mk

# Run with "make V=1" to see the actual compile commands
ifdef V
Q=
else
Q=@
MAKEFLAGS += --no-print-directory
endif

MKDIR_P ?= mkdir -p
CP ?= cp -f
.DEFAULT_GOAL := help

ifeq (, $(shell which brew))
$(error "No brew in $(PATH), consider doing apt-get install brew")
endif

BUILD_DIR ?= ..
#====== MENU CONFIG START=======#
PYTHON=python3
KCONFIG_CONFIG ?= $(CURDIR)/.config

export KCONFIG_CONFIG

#escaping CURDIR spaces
space := $(subst ,, )
KCONFIG_CONFIG_ESCAPED := $(subst $(space),\$(space),$(KCONFIG_CONFIG))

ifneq ($(MAKECMDGOALS),clean)
-include $(KCONFIG_CONFIG_ESCAPED)
endif


config: menuconfig
menuconfig:
	$(Q)$(PYTHON) make/menuconfig.py Kconfig
.PHONY: menuconfig, config
#====== MENU CONFIG END=======#
TARGETS :=

ifdef CONFIG_ENABLE_YABAI
	TARGETS = yabai
endif
ifdef CONFIG_ENABLE_NVIM
	TARGETS += nvim
endif
ifdef CONFIG_ENABLE_FISH
	TARGETS += fish
endif
ifdef CONFIG_ENABLE_KARABINER
	TARGETS += karabiner
endif
ifdef CONFIG_ENABLE_ALACRITTY
	TARGETS += alacritty
endif

help: $(KCONFIG_CONFIG_ESCAPED)
	$(Q)echo -e "Available commands:"
	$(Q)echo -e "$(BICyan)config$(Color_Off)          -     (re)configure applications to use"
	$(Q)echo -e "$(BICyan)save$(Color_Off)            -     save $(Red)ALL$(Color_Off) configuration to remote"
	$(Q)echo -e "$(BICyan)update$(Color_Off)          -     load $(Red)ALL$(Color_Off) application configuration from git"
	$(Q)echo -e "$(BICyan)save/$(Purple)[app]$(BICyan)$(Color_Off)      -     save configuration for application"
	$(Q)echo -e "$(BICyan)load/$(Purple)[app]$(BICyan)$(Color_Off)      -     load application configuration from git"
	$(Q)echo -e "$(BICyan)clean$(Color_Off)           -     clean configuration files"
	$(Q)echo -e ""
	$(Q)echo -e "Available applications:"
	$(Q)for app in $(TARGETS); do \
        echo -e " • $(Purple)$$app$(Color_Off)"; \
    done

.PHONY: help

PRODUCT_DIRS := $(addprefix $(BUILD_DIR)/,$(TARGETS))
UPDATE_DIRS := $(addprefix update/,$(TARGETS))
SAVE_DIRS := $(addprefix save/,$(TARGETS))

save: $(SAVE_DIRS)
.PHONY: save

update: $(UPDATE_DIRS)
.PHONY: update

$(SAVE_DIRS): $(PRODUCT_DIRS)
	$(Q)echo -e " • $(Purple)$(notdir $@)$(Color_Off)"
	$(Q)cd $(addprefix $(BUILD_DIR)/,$(notdir $@)) && git commit -am "$${GITMOJI:-♻️} $${COMMIT:-v$(shell date +'%Y%m%d.%H%M')}"
	$(Q)echo "git push"
.PHONY: $(UPDATE_DIRS)

$(UPDATE_DIRS): $(PRODUCT_DIRS)
	$(Q)echo -e " • $(Purple)$(notdir $@)$(Color_Off)"
	$(Q)cd $(addprefix $(BUILD_DIR)/,$(notdir $@)) && git pull
.PHONY: $(UPDATE_DIRS)

$(PRODUCT_DIRS): $(KCONFIG_CONFIG_ESCAPED)
	if [ -d $(@F) ]; then echo "$(@F) already exists"; else git worktree add -f $@ $(@F); fi


$(KCONFIG_CONFIG_ESCAPED):
	$(Q)$(PYTHON) make/menuconfig.py Kconfig

clean:
	$(Q)git clean -xdf
	$(Q)rm -rf $(PRODUCT_DIRSl)
.PHONY: clean


#export XDG_CONFIG_HOME=~/nvim-tryout/config
#export XDG_DATA_HOME=~/nvim-tryout/data
#
#mkdir -p $XDG_DATA_HOME $XDG_CONFIG_HOME
#nvim
