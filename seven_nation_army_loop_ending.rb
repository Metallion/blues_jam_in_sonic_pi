set :root, :c3
use_bpm 120

define :bassline do |opts = {}|
  default_opts = {
    interval: 0,
    root: get[:root],
    chord_tones: [],
    chord_synth: current_synth,
    bass_synth: current_synth
  }
  
  opts = default_opts.merge(opts)
  
  define :play_note_with_harmonics do |note|
    use_synth opts[:bass_synth]
    play note + opts[:interval]
    
    use_synth opts[:chord_synth]
    opts[:chord_tones].each do |i|
      play note + opts[:interval] + i
    end
  end
  
  play_note_with_harmonics opts[:root]
  sleep 1.5
  play_note_with_harmonics opts[:root]
  sleep 0.5
  play_note_with_harmonics opts[:root] + 3
  sleep 0.75
  play_note_with_harmonics opts[:root]
  sleep 0.75
  play_note_with_harmonics opts[:root] - 2
  sleep 0.5
  
  play_note_with_harmonics opts[:root] - 4
  sleep 2
  play_note_with_harmonics opts[:root] - 5
  sleep 2
  
  use_synth opts[:bass_synth]
end

define :buildup do
  8.times do
    play get[:root] + 3
    sleep 0.5
  end
  
  8.times do
    play get[:root] + 5
    sleep 0.5
  end
end

live_loop :bass do
  root = get[:root]
  use_synth :fm
  
  with_fx :distortion do
    1.times do
      bassline
    end
    
    play get[:root], sustain: 3
    sleep 3
    play get[:root], amp: 1.2, release: 0.2
    stop
    
    buildup
    
    4.times do
      bassline(chord_tones: [7])
    end
    
    4.times do
      bassline(chord_tones: [7, 12, 19, 31],
               chord_synth: :pluck)
    end
    
    buildup
  end
end

live_loop :drums do
  #sleep 16
  
  
  8.times do
    sample :drum_bass_hard, amp: 0.7
    sleep 1
  end
  
  sample :drum_bass_hard, amp: 0.7
  sample :drum_splash_hard
  sleep 3
  sample :drum_snare_soft
  sleep 0.2
  sample :drum_snare_soft
  sleep 0.2
  sample :drum_snare_soft
  sleep 0.2
  stop
  
  8.times do
    sample :drum_bass_hard, amp: 0.7
    sleep 1
    sample :drum_snare_soft
    sleep 1
  end
  
  2.times do
    sample :drum_splash_hard
    4.times do
      sample :drum_bass_hard, amp: 0.7
      sleep 1
    end
  end
  
  32.times do
    sample :drum_splash_hard
    sample :drum_bass_hard, amp: 0.7
    sleep 1
    sample :drum_splash_hard
    sample :drum_snare_soft
    sleep 1
  end
  
  2.times do
    sample :drum_splash_hard
    4.times do
      sample :drum_bass_hard, amp: 0.7
      sleep 1
    end
  end
  
  sample :drum_splash_hard
end
