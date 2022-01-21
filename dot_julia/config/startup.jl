using Pkg

if isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
end
