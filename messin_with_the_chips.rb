use_bpm 120

key = :c5
set :key, key

define :play_intro do |interval = 0, opts = {}|
  intro = (ring get[:key] + 12, get[:key] + 10, get[:key] + 7,
           get[:key] + 5, get[:key] + 3, get[:key] + 2, get[:key],
           get[:key] - 2, get[:key])
  
  4.times do
    play intro.tick + interval, opts
    sleep 1
  end
  5.times do
    play intro.tick + interval, opts
    sleep 0.5
  end
  sleep 1.5
end

in_thread name: :bass do
  use_synth :chipbass
  opts = { amp: 0.5 }
  
  play_intro -12, opts
  
  root = sync :root
  loop do
    10.times do
      play root - 12, opts
      sleep 1.5
      play root - 12 + 7, opts
      sleep 0.5
      play root - 12 + 10, opts
      sleep 0.5
      play root - 12 + 7, opts
      sleep 0.5
      play root - 12 + 10, opts
      sleep 0.5
      play root, opts
      sleep 0.5
      
      root = sync :root
    end
    
    play_intro -12, opts
  end
end

in_thread name: :lead do
  use_synth :chiplead
  
  opts = { amp: 0.5 }
  
  with_fx :distortion do
    play_intro 0, opts
    
    # We have to do this because even after sync :root
    # some times get[:root] isn't updated yet
    root = sync :root
    loop do
      10.times do
        play root, opts
        sleep 1.5
        play root + 5, opts
        sleep 0.2
        play root + 7, opts
        sleep 0.8
        play root + 10, opts
        sleep 0.5
        play root + 7, opts
        sleep 0.25
        play root + 5, opts
        sleep 0.25
        play root + 10, opts
        
        root = sync :root
      end
      
      play_intro 0, opts
    end
  end
  
end

live_loop :drums, sync: :start_drums do
  sample :drum_bass_soft, amp: 1.3
  sample :drum_cymbal_closed
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.5
  sample :drum_snare_hard, amp: 0.6
  sample :drum_cymbal_closed
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.5
end

in_thread name: :conductor do
  define :tick_measure do |new_root = nil|
    set :root, new_root if new_root
    sleep 4
    cue :measure
  end
  
  cue :start_drums
  #cue :start_bass
  #cue :start_guitar
  
  sleep 8
  
  loop do
    4.times { tick_measure get[:key] }
    
    2.times { tick_measure get[:key] + 5 }
    2.times { tick_measure get[:key] }
    
    tick_measure get[:key] + 7
    tick_measure get[:key] + 5
    tick_measure get[:key]
    tick_measure get[:key] + 7
  end
end
