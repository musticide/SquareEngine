#pragma once
#include "Application.h"
#include "Log.h"
#include "spdlog/spdlog.h"
#include <iostream>
#include <spdlog/sinks/basic_file_sink.h>

#ifdef SQ_PLATFORM_WINDOWS

extern SqEngine::Application* SqEngine::CreateApplication();

int main(int argc, char** argv)
{
    printf("Hello Engine");

    SqEngine::Log::Init();
    SqEngine::Log::GetCoreLogger()->warn("Initialized Logger!!");
    SqEngine::Log::GetClientLogger()->error("If you see this be happy!");

    auto app = SqEngine::CreateApplication();
    app->Run();
    delete app;
    return 0;
}

#endif
