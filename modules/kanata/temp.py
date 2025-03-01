with open("chords.txt") as f:
    pairs = f.read().splitlines()[::2]

fmt = '"{}" = "{}";'
seen = {}

for pair in pairs:
    match pair.split():
        case word,:
            print(fmt.format(word, word))
            s = frozenset(word)
        case "#", word:
            print(pair)
            continue
        case word, alias:
            print(fmt.format(alias, word))
            s = frozenset(alias)
        case _:
            raise ValueError(pair)

    if s not in seen:
        seen[s] = []
    seen[s].append(word)

for k, v in seen.items():
    if len(v) > 1:
        print(k, v)
