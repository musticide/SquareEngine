#pragma once
#include "Application.h"

#ifdef SQ_PLATFORM_WINDOWS

extern SqEngine::Application *SqEngine::CreateApplication();

int main(int argc, char **argv) {

  auto app = SqEngine::CreateApplication();
  app->Run();
  delete app;
  return 0;
}

#endif
