#include <SqEngine.h>

class Sandbox : public SqEngine::Application {
public:
  Sandbox() {}
  ~Sandbox() {}
};

SqEngine::Application *SqEngine::CreateApplication() { 
    return new Sandbox(); 
}
