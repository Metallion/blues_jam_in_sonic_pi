use_bpm 100
key = note(:G3)

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

  def main_line(root)
    notes = (ring root, root + 4, root + 7, root + 4)

    4.times do
      note = notes.tick
      play note
      sleep 2/3.0
      play note
      sleep 1/3.0
    end
  end

  def walkup_to_4th(root)
    notes = (ring root, root + 1, root + 2, root + 3)

    4.times do
      note = notes.tick
      play note
      sleep 2/3.0
      play note
      sleep 1/3.0
    end
  end

  loop do
    3.times { main_line(root); root = sync :key }

    if rand(0..1) == 0
      main_line(root)
    else
      walkup_to_4th(root)
    end
    root = sync :key

    8.times { main_line(root); root = sync :key }
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
