# Welcome to Sonic Pi v3.1

use_bpm 100
key = note(:G3)

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
      set :key, key
      sleep 4
    end
    
    2.times do
      set :key, key + 5
      sleep 4
    end
    
    2.times do
      set :key, key
      sleep 4
    end
    
    set :key, key + 7
    sleep 4
    
    set :key, key + 5
    sleep 4
    
    set :key, key
    sleep 4
    
    set :key, key + 7
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
  root = key
  
  loop do
    play root
    sleep 2/3.0
    play root
    sleep 1/3.0
    play root + 4
    sleep 2/3.0
    play root + 4
    sleep 1/3.0
    play root + 7
    sleep 2/3.0
    play root + 7
    sleep 1/3.0
    play root + 4
    sleep 2/3.0
    play root + 4
    sleep 1/3.0
    
    root = sync :key
  end
end

in_thread(name: :guitar) do
  use_synth :pluck
  root = key
  
  loop do
    play chord(root, :major7), amp: 1.5
    sleep 1
    sleep 2/3.0
    play chord(root, :major7), amp: 1.5
    sleep 1/3.0
    play chord(root, :major7), amp: 1.5
    sleep 2/3.0
    play chord(root, :major7), amp: 1.5
    sleep 1/3.0
    sleep 1
    root = sync :key
  end
end
