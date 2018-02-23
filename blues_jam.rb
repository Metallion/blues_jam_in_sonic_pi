use_bpm 100
key = note(:G3)
set :bpm, 100
set :key, note(:G3)
root_dir = "~/work/blues_jam_in_sonic_pi"

in_thread(name: :conductor) do
  loop do
    set :key, key
    sleep 4

    # Some times play the 4chord on the second bar
    if rand(0..1) == 0
      set :key, key + 5
    else
      set :key, key
    end
    sleep 4

    2.times do
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
  loop do
    run_file("#{root_dir}/bass/simple_major_chord_arpeggio.rb")
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
