sudo apt install make cmake build-essential git sox libsox-fmt-all

git clone https://github.com/ggml-org/whisper.cpp.git && cd whisper.cpp

#make
cmake -B build -S .
cmake --build build --target whisper
make

/home/pc/whisper.cpp/build/bin/whisper-cli -version

# Модели
https://huggingface.co/ggerganov/whisper.cpp/tree/main

wget ggml.bin -O ggml.bin https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small-q5_1.bin?download=true
wget ggml.bin -O ggml-tiny.bin https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny-q5_1.bin?download=true

wget ggml.bin -O ggml-medium.bin https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-medium-q8_0.bin?download=true


./whisper-cli audio.wav --model ggml.bin --language ru --output-srt
./whisper-cli /home/pc/recordings/rec_2026-08-10_10-55-49_605620190.wav --model ggml-medium.bin --language ru --output-srt

###########################################
# Запись

rec --no-show-progress output.wav silence 1 0.5 2% 1 3.0 2%
rec -c 1 -r 16000 --no-show-progress output.wav silence 1 0.5 2% 1 3.0 2% # Моно 16k


nano rec.sh

"
#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR="$HOME/recordings"
mkdir -p "$OUTPUT_DIR"

# Только параметры для эффекта silence:
# 1 период по 0.5 сек с порогом 2% → старт при звуке
# 1 период по 3.0 сек с порогом 2% → стоп при тишине
SILENCE_ARGS="1 0.5 2% 1 3.0 2%"

while true; do
  fname="rec_$(date +%F_%H-%M-%S_%N).wav"
  full_path="$OUTPUT_DIR/$fname"

  echo "Starting recording: $fname (waiting for sound…)"
  # -c и -r выносим сюда, отдельно от silence
  rec -c 1 -r 16000 --no-show-progress "$full_path" silence $SILENCE_ARGS
  echo "Recording finished: $full_path"
done
"

chmod +x rec.sh
./rec.sh




###########################################
# Декодинг

nano whisper.sh

#!/usr/bin/env bash

cd /home/pc/recordings
for f in *.wav ; do
  [ -f "$f" ] || continue
  name="${f%.*}"
  /home/pc/whisper.cpp/build/bin/whisper-cli "$f" --model /home/pc/whisper.cpp/build/bin/ggml-medium.bin --language ru -otxt
done


chmod +x whisper.sh




#sudo apt install qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools qtmultimedia5-dev
#git clone https://github.com/sgpinkus/audio-trap.git
#qmake
#make -j4




