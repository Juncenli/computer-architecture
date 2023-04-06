# Pin kit path
PIN_KIT ?= /usr/local/bin/pin
# Target architecture
ARCH ?= intel64

# Source files
SOURCES = pintool.cpp

# Compiler and linker flags
CXXFLAGS = -Wall -Werror
LDFLAGS = -shared

# Pin tool name
TOOL_NAME = pintool.so

# Pin tool target
TOOL_TARGET = obj-$(ARCH)/$(TOOL_NAME)

# Pin tool dependencies
TOOL_DEPS = $(SOURCES:%.cpp=$(PIN_KIT)/$(TOOL_TARGET))

# Build the Pin tool
$(TOOL_TARGET): $(SOURCES)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^

# Clean up
.PHONY: clean
clean:
	rm -f $(TOOL_TARGET)
