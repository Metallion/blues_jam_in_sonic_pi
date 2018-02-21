# Welcome to Sonic Pi v3.1

use_bpm 100
root = 48

in_thread(name: :measure_setter) do
  current_measure = 0
  set :chorus, current_chorus = 1
  
  loop do
    if current_measure < 12
      set :measure, current_measure += 1
    else
      set :measure, current_measure = 1
      set :chorus, current_chorus += 1
    end
    
    sleep 4
  end
end

in_thread(name: :key_setter) do
  loop do
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

in_thread(name: :drums) do
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

in_thread(name: :bass) do
  use_synth :blade
  root_ = root
  
  loop do
    play root_
    sleep 2/3.0
    play root_
    sleep 1/3.0
    play root_ + 4
    sleep 2/3.0
    play root_ + 4
    sleep 1/3.0
    play root_ + 7
    sleep 2/3.0
    play root_ + 7
    sleep 1/3.0
    play root_ + 4
    sleep 2/3.0
    play root_ + 4
    sleep 1/3.0
    
    root_ = sync :root
  end
end
