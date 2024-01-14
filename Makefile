#Variables
CXXFLAGS = -Wall -std=c++20

ENGINE = Engine
ENGINE_SRC = Engine/src
SANDBOX = Sandbox
SANDBOX_SRC = Sandbox/src

all: sqEngine.dll Sandbox

sqEngine.dll: intermediate/$(ENGINE)/*.o
	g++ -shared -o bin/sqEngine.dll intermediate/$(ENGINE)/*.o

intermediate/$(ENGINE)/*.o: $(ENGINE_SRC)/*.cpp $(ENGINE_SRC)/*.h
	g++ $(CXXFLAGS) -c $(ENGINE_SRC)/Test.cpp -o intermediate/$(ENGINE)/Test.o

Sandbox: intermediate/$(SANDBOX)/*.o sqEngine.dll
	g++ -o bin/Sandbox intermediate/$(SANDBOX)/*.o -Lbin/Engine -Lbin -lsqEngine

intermediate/$(SANDBOX)/*.o: $(SANDBOX_SRC)/SandboxApp.cpp
	g++ $(CXXFLAGS) -c $(SANDBOX_SRC)/SandboxApp.cpp -o intermediate/$(SANDBOX)/SandboxApp.o

bin intermediate:
	mkdir $@

# clean:
# 	rm -rf intermediate/Engine intermediate/Sandbox bin/ bin/Engine bin/Sandbox

clean:
	rm -f ./bin/Sandbox.exe
# # Compiler settings
# CXX = g++
# CXXFLAGS = -Wall -std=c++20 -O2
# LDFLAGS =
#
# # Directories
# ENGINE_DIR = Engine/src
# ENGINE_SRC_DIR = Engine
# SANDBOX_DIR = Sandbox
# SANDBOX_SRC_DIR = Sandbox/src
# INT_DIR = intermediate
# BIN_DIR = bin
#
# # Engine targets
# ENGINE_SRCS = $(wildcard $(ENGINE_SRC_DIR)/*.cpp)
# ENGINE_OBJS = $(patsubst $(ENGINE_SRC_DIR)/%.cpp,$(INT_DIR)/%.o,$(ENGINE_SRCS))
# ENGINE_DLL = $(BIN_DIR)/sqengine.dll
#
# # Sandbox targets
# SANDBOX_SRCS = $(wildcard $(SANDBOX_SRC_DIR)/*.cpp)
# SANDBOX_OBJS = $(patsubst $(SANDBOX_SRC_DIR)/%.cpp,$(INT_DIR)/%.o,$(SANDBOX_SRCS))
# SANDBOX_EXE = $(BIN_DIR)/editor
#
# # Default rule: build everything
# all: $(ENGINE_DLL) $(SANDBOX_EXE)
#
# # Engine DLL rule
# $(ENGINE_DLL): $(ENGINE_OBJS)
# 	$(CXX) -shared -o $@ $^ $(LDFLAGS)
#
# # Sandbox executable rule
# $(SANDBOX_EXE): $(SANDBOX_OBJS) $(ENGINE_DLL)
# 	$(CXX) -o $@ $^ -L$(BIN_DIR) -lsqengine $(LDFLAGS)
#
# # Object files rule (for both engine and editor)
# $(INT_DIR)/%.o: $(ENGINE_SRC_DIR)/%.cpp $(ENGINE_SRC_DIR)/%.h | $(INT_DIR)
# 	$(CXX) $(CXXFLAGS) -c $< -o $@
# $(INT_DIR)/%.o: $(SANDBOX_SRC_DIR)/%.cpp $(SANDBOX_SRC_DIR)/%.h | $(INT_DIR)
# 	$(CXX) $(CXXFLAGS) -c $< -o $@
#
# # Create output directories
# $(BIN_DIR) $(INT_DIR):
# 	mkdir -p $@
#
# # Clean rule
# clean:
# 	rm -rf $(INT_DIR) $(BIN_DIR)
