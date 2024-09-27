# Source files
ASM_SRCS = \
	main.s

# Extra dependencies
DEPENDENCIES =

ASM_FLAGS = -mc5 -i. -ms1

NAME = scroll

TARGET_PRG = $(NAME).prg

MAPFILE_PRG = $(TARGET_PRG:%.prg=%.map)

# Paths
VPATH = src
DEPS_DEBUG_PATH = .deps
DEPS_RELEASE_PATH = .deps-release
BUILD_DEBUG_PATH = .build
BUILD_RELEASE_PATH = .build-release

# Object files
OBJS_PRG = $(ASM_SRCS:%.s=%.o)
OBJS_PRG_RELEASE = $(OBJS_PRG:%=$(BUILD_RELEASE_PATH)/%)
OBJS_PRG_DEBUG = $(OBJS_PRG:%=$(BUILD_DEBUG_PATH)/%)

all: $(TARGET_PRG)

# Build rules
$(BUILD_RELEASE_PATH)/%.o: %.s $(DEPS_RELEASE_PATH)/%.d | $(DEPS_RELEASE_PATH) $(BUILD_RELEASE_PATH)
	@motor6502 $(ASM_FLAGS) -d$(DEPS_RELEASE_PATH)/$*.d -o$@ $<

$(BUILD_DEBUG_PATH)/%.o: %.s $(DEPS_DEBUG_PATH)/%.d | $(DEPS_DEBUG_PATH) $(BUILD_DEBUG_PATH)
	@motor6502 $(ASM_FLAGS) -DDEBUG -d$(DEPS_DEBUG_PATH)/$*.d -o$@ $<

$(TARGET_PRG): $(DEPENDENCIES) $(OBJS_PRG_RELEASE)
	@xlink -cmega65 -fmega65 -m$(MAPFILE_PRG) -o$@ -sEntry $(OBJS_PRG_RELEASE)

# Clean utility
clean:
	@rm -rf $(BUILD_RELEASE_PATH) $(BUILD_DEBUG_PATH) $(DEPS_RELEASE_PATH) $(DEPS_DEBUG_PATH) $(DEPENDENCIES)
	@rm -f $(TARGET_PRG) $(MAPFILE_PRG)

# Make directory utility
$(DEPS_RELEASE_PATH) $(DEPS_DEBUG_PATH) $(BUILD_RELEASE_PATH) $(BUILD_DEBUG_PATH): ; @mkdir -p $@

# Dependency files
DEP_RELEASE_FILES := $(OBJS_PRG:%.o=$(DEPS_RELEASE_PATH)/%.d)
DEP_DEBUG_FILES := $(OBJS_PRG:%.o=$(DEPS_DEBUG_PATH)/%.d)

$(DEP_RELEASE_FILES):

$(DEP_DEBUG_FILES):

include $(DEP_RELEASE_FILES) $(DEP_DEBUG_FILES)
