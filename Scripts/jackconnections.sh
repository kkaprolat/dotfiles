#! /bin/bash

# erst alles ab
jack_disconnect "system:capture_1" "PulseAudio JACK Source-01:mono"
jack_disconnect "system:capture_1" "PulseAudio JACK Source:front-left"
jack_disconnect "system:capture_1" "PulseAudio JACK Source:front-right"
jack_disconnect "PulseAudio JACK Sink-01:front-left" "system:playback_1"
jack_disconnect "PulseAudio JACK Sink:front-left" "system:playback_1"
jack_disconnect "PulseAudio JACK Sink-01:front-right" "system:playback_2"
jack_disconnect "PulseAudio JACK Sink:front-right" "system:playback_2"
# Mikrofon-Equalizer
jack_connect "system:capture_1" "Calf Studio Gear:Equalizer 5 Band In #1"
jack_connect "system:capture_1" "Calf Studio Gear:Equalizer 5 Band In #2"

jack_connect "Calf Studio Gear:Equalizer 5 Band Out #1" "PulseAudio JACK Source-01:mono"
jack_connect "Calf Studio Gear:Equalizer 5 Band Out #1" "PulseAudio JACK Source:front-left"
jack_connect "Calf Studio Gear:Equalizer 5 Band Out #2" "PulseAudio JACK Source-01:mono"
jack_connect "Calf Studio Gear:Equalizer 5 Band Out #2" "PulseAudio JACK Source:front-right"

# Compressor
jack_connect "PulseAudio JACK Sink-01:front-left" "Calf Studio Gear:Compressor In #1"
jack_connect "PulseAudio JACK Sink-01:front-right" "Calf Studio Gear:Compressor In #2"
jack_connect "PulseAudio JACK Sink:front-left" "Calf Studio Gear:Compressor In #1"
jack_connect "PulseAudio JACK Sink:front-right" "Calf Studio Gear:Compressor In #2"

jack_connect "Calf Studio Gear:Compressor Out #1" "system:playback_1"
jack_connect "Calf Studio Gear:Compressor Out #2" "system:playback_2"

notify-send -u "low" "JACK" "Compressor und Equalizer angeschlossen."
