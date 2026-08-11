"""Pull the user's own words out of recent session transcripts."""
import json, sys, re, glob, os

since = sys.argv[1]  # ISO date, e.g. 2026-08-05
out = []
for path in glob.glob(os.path.expanduser('~/.claude/projects/*/*.jsonl')):
    for line in open(path, errors='replace'):
        try:
            d = json.loads(line)
        except ValueError:
            continue
        if d.get('type') != 'user' or d.get('isSidechain'):
            continue
        c = d.get('message', {}).get('content')
        if not isinstance(c, str):
            continue
        ts = d.get('timestamp', '')
        if ts[:10] < since:
            continue
        t = re.sub(r'<system-reminder>.*?</system-reminder>', '', c, flags=re.S).strip()
        if not t or t.startswith('<command-'):
            continue
        # Everything below reaches the user turn but isn't the user typing:
        # compaction continuations, peer-agent traffic, command output, notifications.
        if t.startswith(('This session is being continued',
                         'Another Claude session sent a message:',
                         '<local-command-', '<bash-stdout>', '<bash-stderr>',
                         '<task-notification>', '<teammate-message')):
            continue
        out.append({'session': path.split('/')[-1][:8], 'ts': ts[:16], 'text': t[:1500]})

out.sort(key=lambda r: r['ts'])
seen = set()
out = [r for r in out if not (r['text'] in seen or seen.add(r['text']))]
print(json.dumps(out, indent=1))
