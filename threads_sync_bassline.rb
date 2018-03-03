# Messing with threads, syncs and a bassline... not with the kid

use_bpm 120
set :measure, 1
set :instruments, [:drums]

live_loop :drums, sync: :start_drums do
  if get[:measure] > 1 && get[:measure] % 4 == 1
    sample :drum_splash_hard
  end
  
  2.times do
    sample :drum_bass_hard
    sample :drum_cymbal_closed
    sleep 0.5
    sample :drum_cymbal_closed
    sleep 0.5
    sample :drum_snare_hard
    sample :drum_cymbal_closed
    sleep 0.5
    sample :drum_cymbal_closed
    sleep 0.5
  end
end

live_loop :bass, sync: :start_bass do
  use_synth :fm
  
  24.times do
    play :e3
    sleep 0.5
  end
  
  play_pattern_timed scale(:e3, :minor_pentatonic).reverse,
    [0.5, 0.5, 0.5, 0.5, 1, 1]
end

live_loop :conductor do
  cue :start_drums
  16.times do
    set :beat, (ring 1, 2, 3, 4).tick
    set :measure, get[:measure] + 1 if get[:beat] % 4 == 0
    sleep 1
  end
  cue :start_bass
end
