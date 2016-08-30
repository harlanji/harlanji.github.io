#!/bin/sh

DICT=${DICT-/usr/share/dict/words}
COUNT=${COUNT-4}
ASK=${ASK-'Y'}

dict_count=`wc -l < ${DICT}`

pass=''
i=0
while [ $i -lt $COUNT ]; do
	random=$(( ((RANDOM<<15)|RANDOM) % ${dict_count} ))
	word=`head -$((${random} % ${dict_count} + 1)) ${DICT} | tail -1`
	word=`echo $word| tr '[:upper:]' '[:lower:]'`

	if [[ $ASK =~ ^[Yy]$ ]]; then
		>&2 echo "$pass$word"
		>&2 read -p "Add the word ${word}? [y/n]: " -n 1 -r
		>&2 echo
	fi

	if [[ ! $ASK =~ ^[Yy]$ || $REPLY =~ ^[Yy]$ ]]; then
		pass="${pass}${word} "
		i=$[$i + 1]
	fi
done

pass=`echo $pass | xargs`

echo $pass
