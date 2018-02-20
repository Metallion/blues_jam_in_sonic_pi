# Welcome to Sonic Pi v3.1

use_bpm 100

in_thread do
  loop do
    sample :drum_bass_soft
    sample :drum_cymbal_closed
    sleep 2/3.0
    sample :drum_cymbal_closed
    sleep 1/3.0
    sample :drum_snare_soft
    sample :drum_cymbal_closed
    sleep 2/3.0
    sample :drum_cymbal_closed
    sleep 1/3.0
  end
end

in_thread do
  root = 48
  
  use_synth :dsaw
  
  loop do
    play root
    sleep 2/3.0
    play root
    sleep 1/3.0
    play root + 4
    sleep 2/3.0
    play root + 4
    sleep 1/3.0
    play root + 8
    sleep 2/3.0
    play root + 8
    sleep 1/3.0
    play root + 10
    sleep 2/3.0
    play root + 10
    sleep 1/3.0
    play root + 11
    sleep 2/3.0
    play root + 11
    sleep 1/3.0
    play root + 10
    sleep 2/3.0
    play root + 10
    sleep 1/3.0
    play root + 8
    sleep 2/3.0
    play root + 8
    sleep 1/3.0
    play root + 4
    sleep 2/3.0
    play root + 4
    sleep 1/3.0
  end
end
