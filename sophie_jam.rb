use_bpm 120

root = :e4

in_thread name: :guitar do
  sync :start_guitar
  
  define :main_progression do
    play chord(get[:root], :major)
    sleep 1
    play chord(get[:root], :major)
    sleep 1
    play get[:root] + 3, amp: 0.5
    sleep 1
    play chord(get[:root] + 5, :major)
    sleep 2/3.0
    play get[:root] + 7, amp: 0.5
    play get[:root] + 3, amp: 0.5
    sleep 1/3.0
  end
  
  define :simple_chord_shuffle do
    4.times do
      play chord(get[:root], :major)
      sleep 2/3.0
      play chord(get[:root], :major)
      sleep 1/3.0
    end
  end
  
  define :simple_chord_triples do
    4.times do
      3.times do
        play chord(get[:root], :major)
        sleep 1/3.0
      end
    end
  end
  
  loop do
    with_fx :distortion do
      use_synth :pluck
      
      8.times do
        main_progression
        
        sync :root
      end
      
      2.times do
        simple_chord_shuffle
        sync :root
      end
      
      main_progression
      sync :root
      
      simple_chord_triples
      sync :root
    end
  end
  
end

live_loop :bass, sync: :start_bass do
  use_synth :fm
  opts = { amp: 0.3 }
  
  play get[:root] - 12, opts
  sleep 2/3.0
  play get[:root] - 12, opts
  sleep 1/3.0
  play get[:root] - 12, opts
  sleep 1
  play get[:root] - 12 + 3, opts
  sleep 2/3.0
  play get[:root] - 12 + 3, opts
  sleep 1/3.0
  
  major_4 = chord(get[:root] - 12 + 5, :major)
  3.times do
    play major_4.tick, opts
    sleep 1/3.0
  end
  
  sync :root
end

live_loop :drums, sync: :start_drums do
  sample :drum_bass_soft, amp: 1.3
  sample :drum_cymbal_closed
  sleep 2/3.0
  sample :drum_cymbal_closed
  sleep 1/3.0
  sample :drum_snare_hard, amp: 0.6
  sample :drum_cymbal_closed
  sleep 2/3.0
  sample :drum_cymbal_closed
  sleep 1/3.0
end

in_thread name: :conductor do
  define :tick_measure do |new_root = nil|
    set :root, new_root if new_root
    sleep 4
    cue :measure
  end
  
  cue :start_drums
  cue :start_bass
  cue :start_guitar
  
  loop do
    4.times { tick_measure root }
    
    2.times { tick_measure root + 5 }
    2.times { tick_measure root }
    
    tick_measure root + 7
    tick_measure root + 5
    tick_measure root
    tick_measure root + 7
  end
end
