#Variables
CXXFLAGS = -Wall -std=c++20

#output directories
BINARIES = bin
ENGINE_BINARIES = $(BINARIES)/Engine
SANDBOX_BINARIES = $(BINARIES)/Sandbox

INTERMEDIATE = intermediate
ENGINE_INTERMEDIATE = $(INTERMEDIATE)/Engine
SANDBOX_INTERMEDIATE = $(INTERMEDIATE)/Sandbox

ENGINE = Engine
ENGINE_SRC_DIR = Engine/src
ENGINE_OBJ_DIR = intermediate/Engine
ENGINE_SRCS = $(wildcard $(ENGINE_SRC_DIR)/*.cpp)
ENGINE_OBJS = $(ENGINE_SRCS:$(ENGINE_SRC_DIR)/%.cpp=$(ENGINE_OBJ_DIR)/%.o)

SANDBOX_SRC_DIR = Sandbox/src
SANDBOX_OBJ_DIR = intermediate/Sandbox
SANDBOX_SRCS = $(wildcard $(SANDBOX_SRC_DIR)/*.cpp)
SANDBOX_OBJS = $(SANDBOX_SRCS:$(SANDBOX_SRC_DIR)/%.cpp=$(SANDBOX_OBJ_DIR)/%.o)
SANDBOX_INCLUDE = -I$(ENGINE_SRC_DIR)

all: sqEngine.dll Sandbox

#Generate directories TO BE DONE
targetDirectories:
	mkdir -p $(BINARIES)
	mkdir -p $(ENGINE_INTERMEDIATE)

#Generate sqEngine.dll
sqEngine.dll: $(ENGINE_OBJS) 
	g++ $(CXX_FLAGS) -shared -o bin/sqEngine.dll $(ENGINE_OBJS) 

#Generate Engine Objs
$(ENGINE_OBJ_DIR)/%.o: $(ENGINE_SRC_DIR)/%.cpp $(ENGINE_SRC_DIR)/%.h
	g++ $(CXXFLAGS) -DSQ_PLATFORM_WINDOWS -DSQ_BUILD_DLL -c $< -o $@

#Generate Sandbox.exe
Sandbox:$(SANDBOX_OBJS) sqEngine.dll
	g++ -o bin/Sandbox $(SANDBOX_OBJS) -Lbin/Engine -Lbin -lsqEngine

#Generate Sandbox Objs
$(SANDBOX_OBJ_DIR)/%.o: $(SANDBOX_SRC_DIR)/%.cpp
	g++ $(CXXFLAGS) -DSQ_PLATFORM_WINDOWS -c $< -o $@ -IEngine/src
