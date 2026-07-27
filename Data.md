# Data

## Current scope: implement sensors and iterate

Do not begin by deciding the final event schema or training-data structure. First determine what the relevant applications and macOS actually expose, how reliable those signals are, and how closely they can approximate the information entering and leaving the human.

I already have a general sense of the intended prediction target: the next human write given the preceding causal stream of inbound information and prior human writes. Use that objective as a proxy when judging sensor quality, without requiring the Phase 1 representation to be settled first.

```text
sensors
    ↓
lossless raw event journal
    ↓
live local inspector
    ↓
provisional interpretations
    ↓
compare against actual inbound/outbound experience
    ↓
revise sensors and interpretations
```

The current deliverable is a working sensor and inspection system that can be improved through use. A canonical interaction ledger, final segmentation policy, and Phase 1 dataset compiler come later, after the available evidence is understood.

### Minimal commitments

The sensor layer needs only enough common structure to preserve and replay observations:

- event ID;
- sensor name and version;
- wall-clock and monotonic timestamps;
- raw source payload or blob reference;
- application, process, window, document, tab, or conversation identifiers when exposed;
- source-native sequence or correlation identifiers when exposed;
- sensor configuration and permission state;
- dropped-event, gap, and health information;
- privacy or capture-exclusion status.

Do not require sensors to emit semantic `read`, `write`, `action`, `presentation`, or `content revision` records. Those are provisional interpretations over raw signals. Preserve enough source information to recompute them when the interpretation changes.

### Sensor surfaces to test

Start with the surfaces that dominate the intended Phase 1 context and targets:

1. **Obsidian:** editor/document snapshots, diffs, cursor and selection changes, focus, file identity, saves, typing, paste, undo, redo, and the existing inactivity-triggered git behavior.
2. **Codex and other AI chats:** prompt-field contents, typing versus paste, submission, the prompt's later rendering in history, response streaming, tool results, conversation identity, and scroll/focus state.
3. **Browser:** tabs, URL and navigation, DOM/accessibility text, actual viewport, scroll and dwell, input fields, searches, submitted messages, and dynamic content changes.
4. **macOS-wide fallback:** application/window focus, accessibility tree and notifications, keyboard/mouse/scroll events, clipboard, screenshots, and OCR.
5. **Screenpipe evaluation:** run a pinned version as a candidate implementation of the generic sensor layer; inspect its raw frames, elements, input events, triggers, timing, gaps, and resource cost before deciding what to reuse or replace.

Application-native sensors should be tested where they offer materially better signals, but this is an empirical question rather than an architectural assumption. The generic fallback establishes what is available everywhere.

### Local inspector

The sensor must be developed with a local screen that updates during real work. It should initially show:

- the raw chronological events from each sensor;
- source timestamps and arrival timestamps;
- the current application, window, document/tab/conversation, focus, and viewport when available;
- raw text, accessibility/DOM output, screenshots, input events, clipboard events, and before/after snapshots;
- sensor health, missing permissions, capture gaps, and dropped events;
- a small number of provisional interpretations, each visibly marked as inferred rather than raw;
- manual annotation controls for “correct,” “wrong,” “missing,” “duplicate,” “wrong author,” “wrong boundary,” and “should be excluded.”

The inspector is the main research instrument. It should make it easy to answer: “Does this record closely resemble what was actually inbound to me and outbound from me?” It does not initially need to display a finalized token sequence or training example.

Watching the inspector can change behavior, so calibration sessions should be distinguishable from normal collection.

### Iteration loop

For each sensor or reconstruction hypothesis:

1. Perform controlled actions: type, paste, edit, delete, undo, submit, receive a response, scroll quickly, dwell, switch windows, revisit content, and work across multiple monitors.
2. Inspect every raw signal produced.
3. Compare it with what actually happened and what would be relevant to predicting the next write.
4. Record missing, duplicated, delayed, misattributed, or privacy-sensitive data.
5. Change the sensor or add a provisional interpretation.
6. Replay the same raw journal through the new interpretation where possible.
7. Repeat during normal work and across the primary applications.

Prefer small end-to-end probes over implementing all sensors at once. Each probe should establish what a source can and cannot expose.

### Initial proxy tests

The prediction objective provides practical tests of whether a signal matters:

- Can the system recover the exact human-authored write and distinguish it from pasted, model-generated, tool-generated, or merely re-rendered text?
- Immediately before that write, can it reconstruct the external text and prior human writes that were actually available?
- Does it avoid treating a submitted Codex prompt rendered in chat history as new inbound information?
- Does opening an article expose only the visible portion rather than imply that the entire article was read?
- Can it represent fast scrolling, partial visibility, rereading, multiple windows, and new inbound information arriving during a long write without obvious temporal leakage?
- Are ambiguities and capture failures visible rather than silently converted into confident labels?

These are sensor-quality probes, not yet frozen dataset rules.

### Implementation order

1. Build the append-only raw journal and a minimal inspector shell.
2. Evaluate Screenpipe's emitted data as the first generic sensor baseline.
3. Add one high-fidelity write surface, likely Obsidian, and make its events inspectable.
4. Add one inbound-information surface, likely the browser.
5. Add Codex/chat and explicitly test authorship, submission, re-rendering, streaming, and tool-result cases.
6. Compare native sensors with accessibility/input/screenshot fallbacks.
7. Only after repeated live inspection, stabilize useful interpretations and begin defining a Phase 1 projection.

Privacy controls, an obvious pause mechanism, and capture-health reporting are required from the beginning. Training is not.

### Out of scope for now

- Finalizing the shared data model for Phases 1, 2, and 3.
- Choosing a universal definition of an event or macro-action.
- Freezing the three-second segmentation rule.
- Implementing the complete Phase 1 cleaning and training-data compiler.
- Designing Phase 2 proposal/feedback records or Phase 3 trajectories.
- Proving that every captured signal improves prediction before basic sensing works.

Phase 1 remains WIP and supplies direction for what ultimately needs to be predicted. This Data scope is currently about learning what can be observed and making those observations inspectable and iteratively better.

## Prior notes and research queue

These notes may inform sensor experiments, but they are not commitments about the resulting structure.

- [[Experiment Plan]]
- some nitpicks for data construction ^527840
	- need to handle copy / paste actions from different apps into obsidian to not mistake that for user typing
	- need to handle moving a cursor in between sentences across notes or anywhere else typing is occurring, editing, deletion, typos, etc
	- git across my entire computer wherever im writing? it nicely handles breaking down actions into chunks, whereas raw keystrokes have a ton of noise around moving cursors, backspacing, typos, etc. hmmm.
	- does defining actions as time steps like this make sense (i.e. git commit after x seconds of no action as natural 'states')? how does it relate to thinking machines focus on 'time based' chunking of data? worth exploring. time based vs turn based. they have an SGLang PR that I should review.
		- still such a banger https://thinkingmachines.ai/blog/interaction-models/. every source they city resonates ^15beb6
		- "with a wider release later this year"
		- personal models / interaction models / proactive models + local data exposure will collect tacit knowledge orders of magnitude more than systems that take a prompt and work for hours
	- maybe the lack of this work publicly is simply that the data production + data cleaning combination is too high of a hill to climb?
- [[Interaction#^f5c205]]
- [[Interaction]] overall
- https://arxiv.org/pdf/2309.12170 older RNN predicting mouse/keyboard data
- https://x.com/screenpipe/status/2077045452579778664?s=20
	- it might be in a gemini chat, at the very least in browser history, but there was an old screenpipe PR that cleaned up screenpipe data for training. i think it was for retrieval so maybe it was whatever, but im surprised i did not note it down
- ways to think about data from Levine https://x.com/svlevine/status/2075721405929508942?s=20
- https://github.com/experientiallabs/world-model-harness (yc, seems to be productized data cleaning)
- tension between improving data collection vs experimenting with algorithms to make it useful. need both long term pending ongoing discovery. my current load bearing has been phrased as algorithms, but maybe thats because i already write down thoughts, and the additional work there doesn't feel like i learn anything besides if i write down more thoughts, which would require actually measuring usage rate. the ai could easily do this, pending how the actual git commitments work (is it actually when i stop typing, or just every 10 mins). but iterating on the algorithms will act as a forcing function for what type of data is needed and how it should be structured, which probably makes it more useful as a load bearing
- "possible experiment / toy example to have the git history of notes, randomly remove increasing portions of it, in-context prompt frontier and/or weight space update a smaller LLM, rank predictions based on personal expected usefulness/predictive ability (perhaps just pairwise), establish trend line if any. compare across differing frontier models and/or differing small/local LLMs. do this online to collect more data on how it evolves over time"
- https://www.markovstudios.com/data_samples/writing-and-research yc startup computer use data sample. is this actually what computer use data looks like?
	- come to think of it, how would I actually codify the action space for next thought prediction? would the action space be infinite if the action consists of the full thought rather than tokens? if tokens how exactly would start/stop tags work?
	- minecraft dreamer v4 seems to directly relate to computer use in terms of algorithms that could be useful to apply to non minecraft scenarios
- (2) the structure of the data required to actually implement a predictive algorithm likely requires context into what im seeing, not just what im outputting. its unclear how to best structure the data to predict outputs, but at the very least i'd likely need surrounding context which probably very simply takes the form of browser history with proper auths. what are the best existing tools and/or custom solutions for this?
- i suspect the data should interleave write actions (content, app) with read actions (content, app). obsidian (+ ai chats, search) are most of write. the browser history is most of read. but i only want the model to predict what i write, not what i read. and i dont want to trade off intelligence, since the point is superhuman
- somewhat helpful gemini thread regarding data structure and previous attempts. but need to parse the bs https://gemini.google.com/app/b242920671bf7d32
- what should the data structure be for training on an open source model, if the goal is to predict 'writes' (obsidian note, browser search, message to ai chatbot) given previous reads and writes (browser history, ai chatbot answers, previous notes)
- (read, app, content) and (write, app, content). obsidian covers some write. the browser history script that fetches some read and write, but some issues flagged by Fable
- super relevant analysis of algorithms, compared to prompt space, and data tricks/tips needed to juice performance at least in that specific domain https://thinkingmachines.ai/news/learning-to-replicate-expert-judgment-in-financial-tasks/
	- is it cheaper to update weights continuously or update prompts continuously? actually feels like weights? since querying prompts on a frontier model is super expensive?
