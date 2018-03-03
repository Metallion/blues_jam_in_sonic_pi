set :root, note(:e3)

use_bpm 120

live_loop :bass do
  with_fx :distortion do
    use_synth :fm
    
    play get[:root]
    sleep 1.5
    play get[:root]
    sleep 0.5
    play get[:root] + 3 # minor third
    sleep 0.75
    play get[:root]
    sleep 0.75
    play get[:root] - 2 # minor seventh
    sleep 0.5
    
    # second bar
    play get[:root] - 4 # minor sixth
    sleep 2
    play get[:root] - 5 # perfecft fifth
    sleep 2
  end
  
  set :end_it, true
  stop
end

live_loop :drums do
  stop if get[:end_it]
  sample :drum_bass_hard, amp: 0.7
  sleep 1
  sample :drum_snare_soft
  sleep 1
end

live_loop :ending do
  sync :end_it
  use_synth :fm
  
  with_fx :distortion do
    play get[:root], sustain: 3
  end
  
  sample :drum_bass_hard
  sample :drum_splash_hard
  sleep 3
  with_fx :distortion do
    play get[:root]
  end
  sample :drum_snare_hard
  sleep 0.25
  sample :drum_snare_hard
  sleep 0.25
  sample :drum_snare_hard
  sleep 0.25
  stop
end