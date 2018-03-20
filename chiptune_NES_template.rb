in_thread do
  use_synth :pulse
  play 60
end

in_thread do
  use_synth :pulse
  play 60
end

in_thread do
  use_synth :tri
  play 60
end

in_thread do
  use_synth :fm
  use_synth_defaults divisor: 1.6666, attack: 0.0, depth: 1500, sustain: 0.05, release: 0.0
  play 60
end