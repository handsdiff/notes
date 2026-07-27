# Data

Build and deploy sensors from scratch, then iterate from what they actually expose rather than predefining the final data structure.

**North star:** qualitative temporal fidelity of snapshots—capturing, as closely as possible, what information was available to the human and what the human produced, in the correct causal order.

**Loop:** deploy the smallest useful sensor → inspect its raw snapshots during real work → compare them with the actual inbound/outbound experience → fix the sensor or snapshotting → repeat.

Keep raw signals replayable with minimal source, version, timestamp, identity, privacy, and health metadata. Use relevance to next-write prediction as a practical proxy; defer stable semantics and training-data structure until the sensors work.
