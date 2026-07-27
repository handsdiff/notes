likely need to 
1) go through and clean up Entry, separate things that should be handled during backlog/minor work push, to enable step 2 below
2) generate a data hypothesis by collecting all the disparate notes around data processing i've collected
3) review the data structures from relevant similar papers like I did for algorithms to determine which is worth implementing
4) implement the data ingestion and cleaning pipeline and monitor it
	1) codify data structure needed for chosen algorithms, codify how to extract from base data structure to algorithm structure for each step, set up all ingestion points and monitor cleanliness

disparate notes:
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

## Initial data pipeline hypothesis (working)

This is a starting hypothesis to test with a local inspector, not a settled schema. The central design choice is to collect a source-faithful record once, reconstruct a common interaction ledger from it, and only then produce separate datasets for Phases 1, 2, and 3.

```text
source-native capture
        ↓
reconstructed interaction ledger
        ├── Phase 1: causal context → next human write
        ├── Phase 2: proposal / display / response data
        └── Phase 3: state → action → resulting-state trajectories
```

The shared ledger should preserve anything plausibly useful across the three phases. It should not force all three phases into one training schema. In particular, `read` and `write` should be derived roles, not labels attached directly to screenshots or keystrokes during collection.

### 1. Source-native capture

Capture the lowest-level facts available from each source before interpreting them.

**Text and editing**

- Raw keyboard events where permitted, including shortcuts and special keys.
- Clipboard operations and contents, distinguishing copy, cut, and paste.
- Application-native document or text-field snapshots before and after changes.
- Cursor position, selection, focused element, and document or conversation identity.
- Submit, send, save, undo, redo, deletion, replacement, and navigation actions.
- Streaming boundaries for model responses and tool results.
- Stable source IDs, source-local sequence numbers, wall-clock time, and monotonic time.

The application-native snapshot or edit transaction is more authoritative than reconstructing text from keystrokes. Keystrokes remain useful for timing, provenance, paste detection, and diagnosing failures.

**What was presented**

- Monitor, window, tab, application, URL/document, focus, geometry, and occlusion state.
- Accessibility tree or DOM, including text spans, element bounds, scroll position, and visible viewport.
- Screenshot as a visual fallback and audit artifact.
- OCR only where structured text is unavailable or incomplete.
- Audio or media position where spoken information may later matter.
- Repeated presentations of the same content revision, rather than duplicating that content as if it were new.

Presentation is observable; attention and comprehension are not. A visible span is evidence that information was available to the human, not proof that it entered the human's mind.

**State and transitions**

- Periodic or action-triggered state snapshots.
- Environment instance identity: document revision, conversation, browser tab, repository/worktree, terminal session, application state, etc.
- Actions taken by the human, models, tools, and the environment.
- Before/after state and exogenous changes when recoverable.

This is mostly unnecessary for the first Phase 1 implementation, but failing to retain it now could make later Phase 3 reconstruction impossible.

**Capture integrity and privacy**

- Capture-source version and configuration.
- Gap, permission, dropped-event, clock, and health diagnostics.
- Hard deny-lists for password managers, private windows, secrets, and other content that should never enter the raw store.
- A separate sanitization and eligibility decision before anything reaches a training dataset.

### 2. Reconstructed interaction ledger

The ledger should separate content identity, actions, presentations, and state. A preliminary set of records:

- `RawCapture`: immutable source payload plus capture metadata and integrity status.
- `ContentRevision`: a stable content object and its versioned text or media.
- `ContentProvenanceSpan`: a span-level attribution such as human-typed, human-pasted, model-generated, tool-generated, quoted, or unknown.
- `Action`: an actor caused a mutation or navigation over an interval.
- `Presentation`: a content revision or span was rendered in a location over an interval.
- `StateSnapshot`: the state of a particular environment instance at a particular time.
- `Relation`: typed links such as `derived_from`, `presented_by`, `mutated`, `submitted_as`, `response_to`, `before`, `after`, and `same_content_as`.
- `AuditAnnotation`: human correction, confidence, exclusion reason, or pipeline-version note.

These records need at least:

- stable IDs;
- source and environment identity;
- actor, initiator, and content-author as separate fields;
- began, ended, observed, committed, and first-available times where relevant;
- raw-source references;
- confidence and reconstruction version;
- privacy and downstream-eligibility status.

This avoids the central ambiguity in a flat `(read|write, app, content)` stream. The same text can be:

1. authored by the human in a text field;
2. submitted by the human;
3. rendered back into a chat transcript by the application; and
4. shown again later when the human scrolls.

Those are related events, not four independent pieces of inbound information. For example, a Codex prompt is a human write target. Its later appearance in chat history is a presentation of the same human-authored content, not a new external `read`.

### 3. Reconstructing exposure

For each presentation, derive an exposure estimate using:

- actual visible text spans rather than the whole linked document;
- foreground/focus state;
- window geometry and occlusion;
- dwell time;
- scroll velocity and direction;
- repeated viewing;
- whether the content was already visible before the current snapshot;
- source quality: DOM/accessibility, OCR, or screenshot-only.

The initial Phase 1 projection should be conservative. Include text as observed context only when it was actually rendered and plausibly available long enough to perceive. Do not mark an entire article as observed because its URL was opened. The URL and document identity can be retained even when only the first paragraph qualifies as visible.

This estimate must remain inspectable. It should never be represented as ground-truth human attention.

### 4. Reconstructing human write actions

Preserve every raw mutation, then derive semantic write actions from document diffs and input provenance.

Initial segmentation hypothesis:

- After keyboard, pointer, or scroll activity stops for approximately three seconds, take a semantic snapshot.
- Diff it against the prior snapshot of the same document or text field.
- Treat the resulting human-authored mutation as a candidate action.
- Force a boundary at explicit submit/send/save actions, focus or document changes, and newly arriving inbound information.
- Preserve the action's full interval, before/after revisions, patch, selection, and raw inputs.

The three-second threshold belongs in the derived segmentation layer, not the collector. It should be configurable and evaluated against the inspector. Mouse movement should only extend a segment when it plausibly belongs to the same interaction; otherwise incidental motion could prevent boundaries indefinitely.

Typing and paste must remain distinct:

- `typed`: directly produced by human keyboard input;
- `pasted`: inserted from clipboard with source linkage where possible;
- `mixed`: contains both;
- `transformed`: human edit of pasted/model/tool text;
- `unknown`: provenance could not be recovered.

For the first clean behavioral-cloning dataset, use directly human-authored writes as targets. Retain pasted, mixed, transformed, deletion-only, and tool-generated actions in the ledger, but exclude them or evaluate them as separate target classes until their semantics are understood.

### 5. Phase 1 projection

Phase 1 should be a deterministic view over the ledger, not the ledger itself.

```text
P1Example
  target:
    next eligible human write action
  cutoff:
    instant immediately before the target begins
  context:
    causal sequence of eligible observations and prior human writes
    whose contents were available before the cutoff
  metadata:
    source IDs, timestamps, context-token count, eligibility decisions,
    confidence, projection version, and target provenance
```

Possible context atoms:

- `EXTERNAL_OBSERVATION`: content authored by another human, model, tool, or environment and actually presented to the human.
- `PRIOR_HUMAN_WRITE`: a previous human action, included as history but never mislabeled as new inbound information.
- `GROUNDING_STATE`: minimal application/document/navigation state needed to interpret the content.

The model input is the serialized causal event stream, truncated to the most recent fixed token window. The initial implementation uses 32K context. Retrieval is not part of Phase 1.

The target is the next eligible human-authored write. Loss applies only to target tokens. Exact serialization, ordering, truncation, and target masking must be versioned so live evaluation and overnight training use the same construction.

Important causal rules:

- Nothing first available after the target starts may enter its context.
- If new inbound information arrives during a long write, split or invalidate the target rather than leak it into the past.
- A render caused by the target itself is not target context.
- A repeated view should reference the existing content revision but create a new presentation interval.
- Concurrent monitors and windows must be ordered by their actual availability intervals, not by arbitrary database insertion order.

### 6. Processing stages

An initial end-to-end pipeline:

1. Append source-native payloads to the immutable raw store.
2. Normalize clocks, source identity, applications, windows, documents, conversations, and actors.
3. Reconstruct content revisions and environment state.
4. Assign span-level authorship and lineage.
5. Reconstruct presentation intervals and visible spans.
6. Estimate exposure without claiming gaze or comprehension.
7. Segment candidate human write actions.
8. Apply privacy rules, confidence thresholds, and Phase 1 eligibility rules.
9. Produce Phase 1 context atoms and write targets at exact causal cutoffs.
10. Serialize the fixed-length causal window and target mask.
11. Display the example for audit, then publish an immutable, versioned dataset manifest.

Raw data should be append-only. Corrections should create new derived versions rather than silently mutate old examples. This is necessary to reproduce which data trained each nightly checkpoint.

### 7. Phase boundaries

The shared collector should retain enough information for later work, but each phase gets a separate projection:

- **Phase 1:** what the human observed and previously wrote → next human write.
- **Phase 2:** exact candidate generated, whether and when it was shown, abstention, human response, edits, accept/reject/ignore behavior, and preference comparisons.
- **Phase 3:** state, action, actor, environment instance, resulting state, and observed/predicted/simulated trajectories.

No Phase 2 proposal or feedback records should be invented inside the Phase 1 schema. No Phase 3 transition semantics should be inferred from a screen snapshot when the required before/after state is unavailable.

### 8. First implementation and audit loop

Start with the sources most likely to produce high-fidelity text:

1. Obsidian native snapshots and diffs.
2. Codex/AI-chat prompt submission, response streaming, and tool-result events.
3. Browser DOM/accessibility plus tab, focus, viewport, and scroll state.
4. OS-level input, clipboard, window, screenshot, and OCR capture as a cross-application backstop.

Build a local inspector that updates while work is happening and shows, side by side:

- raw source events;
- reconstructed content/actions/presentations;
- the Phase 1 context/target projection;
- the exact token sequence and loss mask the model would receive;
- uncertainty, exclusions, and dropped-capture warnings.

Use the inspector to label disagreements between the reconstruction and what was actually inbound to or outbound from the human. Calibration sessions should be flagged or excluded, since watching the inspector can itself alter behavior.

Questions to answer empirically:

- Is three seconds the right default boundary, and should the threshold differ for typing, scrolling, and pointer activity?
- Which accessibility/DOM fields reliably identify visible spans across the main applications?
- How should partially occluded, rapidly scrolled, or peripheral content be weighted or excluded?
- Can application-native hooks reliably distinguish typing, paste, model insertion, and later human edits?
- What minimum confidence is required for a clean Phase 1 target?
- Which low-fidelity sources improve prediction enough to justify their noise and privacy cost?
