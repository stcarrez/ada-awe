
dir=.
sources="-I$dir -I$dir/util -I$dir/model -I$dir/engine"
xml=`xmlada-config`
flags="-gnatwa -gnatd -gnath -gnatl -g "
gnatmake $sources awe_model_sizes $xml $flags
