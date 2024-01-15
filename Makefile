#Variables
CXXFLAGS = -Wall -std=c++20

ENGINE = Engine
ENGINE_SRC_DIR = Engine/src
ENGINE_OBJ_DIR = intermediate/Engine
ENGINE_SRCS = $(wildcard $(ENGINE_SRC_DIR)/*.cpp)
ENGINE_OBJS = $(ENGINE_SRCS:$(ENGINE_SRC_DIR)/%.cpp=$(ENGINE_OBJ_DIR)/%.o)

SANDBOX_SRC_DIR = Sandbox/src
SANDBOX_OBJ_DIR = intermediate/Sandbox
SANDBOX_SRCS = $(wildcard $(SANDBOX_SRC_DIR)/*.cpp)
SANDBOX_OBJS = $(SANDBOX_SRCS:$(SANDBOX_SRC_DIR)/%.cpp=$(SANDBOX_OBJ_DIR)/%.o)

all: sqEngine.dll Sandbox

#Generate sqEngine.dll
sqEngine.dll: $(ENGINE_OBJS) 
	g++ -shared -o bin/sqEngine.dll $(ENGINE_OBJS) 

#Generate Engine Objs
$(ENGINE_OBJ_DIR)/%.o: $(ENGINE_SRC_DIR)/%.cpp $(ENGINE_SRC_DIR)/%.h
	g++ $(CXXFLAGS) -c $< -o $@

#Generate Sandbox.exe
Sandbox:$(SANDBOX_OBJS) sqEngine.dll
	g++ -o bin/Sandbox $(SANDBOX_OBJS) -Lbin/Engine -Lbin -lsqEngine

#Generate Sandbox Objs
$(SANDBOX_OBJ_DIR)/%.o: $(SANDBOX_SRC_DIR)/%.cpp
	g++ $(CXXFLAGS) -c $< -o $@
