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
end

live_loop :vocals do
  r = get[:root]
  sleep 4 * 7
  sleep 2.5
  
  with_fx :distortion do
    play_pattern_timed [r, r, r, r + 3, r, r],
      [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]
    sleep 2.5
    
    sleep 1.5
    play_pattern_timed [r, r, r, r, r],
      [0.5, 0.5, 0.5, 0.5, 0.5]
    play_pattern_timed [r, r, r, r, r, r, r],
      [0.5, 0.5, 0.5, 0.5, 0.75, 0.75, 1]
    
    sleep 2
    #TODO: Slide this major 3rd
    play_pattern_timed [r, r, r, r + 4, r, r],
      [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]
    sleep 2.5
    
    sleep 2
    play_pattern_timed [r, r, r], [0.5, 0.5, 0.5]
    sleep 0.5
  end
end

live_loop :drums do
  sleep 16
  
  (16 + 32).times do
    sample :drum_bass_hard, amp: 0.7
    sleep 1
  end
  
  32.times do
    sample :drum_bass_hard, amp: 0.7
    sleep 1
    sample :drum_snare_soft
    sleep 1
  end
end

live_loop :ending, sync: :finish do
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