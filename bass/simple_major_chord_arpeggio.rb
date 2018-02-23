use_bpm get[:bpm]

use_synth :blade
root = get[:key]

def simple_shuffle_bass(notes)
  4.times do
    note = notes.tick
    play note
    sleep 2/3.0
    play note
    sleep 1/3.0
  end
end

define :major_chord_arpeggio do
  simple_shuffle_bass (ring root, root + 4, root + 7, root + 4)
  root = sync :key
end

define :walkup_to_4th do
  simple_shuffle_bass (ring root, root + 1, root + 2, root + 3)
  root = sync :key
end

define :walkup_to_5th do
  simple_shuffle_bass (ring root, root + 4, root + 5, root + 6)
  root = sync :key
end

define :turnaround_5th do
  play root
  sleep 1
  sleep 2/3.0
  play root, sustain: (2 + 1/3.0)
  root = sync :key
end

3.times { major_chord_arpeggio }

if rand(0..1) == 0
  major_chord_arpeggio
else
  walkup_to_4th
end

6.times { major_chord_arpeggio }

walkup_to_5th
turnaround_5th
