-- an audio and music submodule

godlike.audio = godlike.audio or {}

godlike.audio.play  = godlike.audio.play  or function() godlike.sexec("playerctl play-pause") end
godlike.audio.stop  = godlike.audio.stop  or function() godlike.sexec("playerctl stop") end
godlike.audio.next  = godlike.audio.next  or function() godlike.sexec("playerctl next") end
godlike.audio.prev  = godlike.audio.prev  or function() godlike.sexec("playerctl previous") end
godlike.audio.mute  = godlike.audio.mute  or function() end
godlike.audio.raise = godlike.audio.raise or function() godlike.sexec("amixer sset Master 8%+") end
godlike.audio.lower = godlike.audio.lower or function() godlike.sexec("amixer sset Master 8%-") end

return godlike
