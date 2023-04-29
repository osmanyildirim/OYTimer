Pod::Spec.new do |s|
  s.name                      = "OYTimer"
  s.version                   = "1.0"
  s.summary                   = "Swift SDK of Timer with Countdown, Repeat and After types"

  s.homepage                  = "https://github.com/osmanyildirim/OYTimer.git"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "osmanyildirim" => "github.com/osmanyildirim" }

  s.ios.deployment_target     = "11.0"
  s.swift_version             = "5.7"
  s.requires_arc              = true

  s.source                    = { git: "https://github.com/osmanyildirim/OYTimer.git", :tag => s.version }
  s.source_files              = "Sources/**/*.*"
end