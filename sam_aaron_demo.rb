live_loop :foo do
  sample :loop_industrial, beat_stretch: 1
  sleep 1
end

live_loop :bass_drum do
  sample :bd_haus, amp: 1
  sleep 0.5
end

live_loop :vortex do
  use_synth :blade
  
  play scale(:e4, :minor_pentatonic).choose, release: 0.1
  sleep 0.125
end