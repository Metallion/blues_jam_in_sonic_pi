# Welcome to Sonic Pi v3.1

use_bpm 100
root = 48

in_thread do
  current_measure = 0
  
  live_loop :measure_setter do
    if current_measure < 12
      set :measure, current_measure += 1
    else
      set :measure, current_measure = 1
    end
    
    sleep 4
  end
end

in_thread do
  live_loop :key_setter do
    4.times do
      #TODO: Set second bar to 4th based on RNG
      set :root, root
      sleep 4
    end
    
    2.times do
      set :root, root + 5
      sleep 4
    end
    
    2.times do
      set :root, root
      sleep 4
    end
    
    set :root, root + 7
    sleep 4
    
    set :root, root + 5
    sleep 4
    
    set :root, root
    sleep 4
    
    set :root, root + 7
    sleep 4
  end
end

in_thread do
  live_loop :drums do
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
  use_synth :chiplead
  root_ = root
  
  live_loop :bass do
    play root_
    sleep 2/3.0
    play root_
    sleep 1/3.0
    play root_ + 4
    sleep 2/3.0
    play root_ + 4
    sleep 1/3.0
    play root_ + 8
    sleep 2/3.0
    play root_ + 8
    sleep 1/3.0
    play root_ + 4
    sleep 2/3.0
    play root_ + 4
    sleep 1/3.0
    
    root_ = sync :root
  end
end
