workspace "SquareEngine"
    architecture "x64"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

OutputDir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "SqEngine"
    location "Engine"
    kind "SharedLib"
    language "C++"

    targetdir ("bin/" .. OutputDir .. "%{prj.name}")
    objdir ("intermediate/" .. OutputDir .. "%{prj.name}")

    files
    {
        "Engine/src/**.h",
        "Engine/src/**.cpp",
    }

    includedirs
    {
        "Engine/vendor/spdlog/include",
    }

    filter "system.windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "SQ_PLATFOMR_WINDOWS",
            "SQ_BUILD_DLL"
        }

        postbuildcommands
        {
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. OutputDir .. "/Sandbox")
        }

    filter "configurations:Debug"
        defines "SQ_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "SQ_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "SQ_DIST"
        optimize "On"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"

    targetdir ("bin/" .. OutputDir .. "%{prj.name}")
    objdir ("intermediate/" .. OutputDir .. "%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
    }

    includedirs
    {
        "Engine/vendor/spdlog/include",
        "Engine/src"
    }

    links
    {
        "SqEngine"
    }

    filter "system.windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "SQ_PLATFOMR_WINDOWS",
        }

    filter "configurations:Debug"
        defines "SQ_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "SQ_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "SQ_DIST"
        optimize "On"
