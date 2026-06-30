
reward function autonomy


- Shared open tabs  
- Shared claude/gemini conversations    
- Programmatic for Background Intelligence with own sudo VM and internet search    
- –  
- Save links for future reading  
- All notes \+ browser history \+ AI chats to be referenced by an AI (for now just chat interface, later proactive consolidation/research/suggestion)      
- Would be nice if i didnt have to copy paste and i could just press a button to flag a visited site as ‘important’


- my context comes from my thoughts, browser history, and AI chats
- want to auto scrape and index browser history
- after that core is there, it becomes about feeding in context more seamlessly, helping me create context via proactive stimulation, then allowing others to input context (public AI chat with access to own VM, internet search, and notes + note history)

- recursive link indexing as part of intelligence over data. Is this what memory is for? Eh. Feels like RLM over git and link scraping makes more sense. Maybe later instead of now? Do I feel comfortable deleting stuff now since it’s easily fetch able later? Depending on the quality of my local Claude code reading git. Test and see.
- Probably need to figure out how to link the substack here. as well as calendar link.
- Probably should show on the ui the latest diffs to make it easier for people to know what’s going on… hmm
- for putting a chatbot on the UI, what boundary to be drawn? just expose the git history and let people bring their own weights? or serve the weights as well?
	- https://developers.openai.com/codex/app-server seems to imply users bringing their own weights?
- just expose MCP to data and data history? in vein of showing data history on the UI?

one of the reasons for this setup is to increase legibility / produce more context for future more capable data hungry systems

depth 1 recursive link fetching as part of the link indexing?

obsidian search but over git history as well?

i need cursor in obsidian to help me create backlinks [[Ideas#^8c0496]]

note taking ^^ into social network where the value prop is provenance? (i came up with this first) (lowest friction to write an idea down)

"Didn't think I'd get this far. Here goes: - need to be able to quickly write down thoughts/ideas on mobile (one button click) and have it sync across devices. this should go to a default note that i can then parse later as needed into my more structured notes. - need better UX of structuring multiple note files where lines in one notes file can point to either a full other note or specific line in another note file (basically obsidian's value prop, but their random hashes are gross) - absolutely 100% need git on the set of notes. otherwise I start hoarding ideas to not lose them and the product becomes cluttered and useless. - the AI should be able to read/fetch git history as needed (perhaps a toggle) to answer questions/propose next steps, I just don't want to see it on my view - dont want 'sources' directly. i want my notes, which will be interleaved with links i drop in. the AI should index the content of those links as needed, as well as my ideas, as the default. (i know i can make notes sources but its clunkier imo) - would be amazing if notebookLM could parse gemini chats when i drop those links into my notes. a lot of the time i'll talk to gemini to research something, then throw the chat link into obsidian so I can reference it later, but there's no existing solution for me to be able to later talk to an AI that has background context of a set of chats - finally, want to be able to share my entire set of notes on a premade UI like Quartz, along with the git history sorted by most recent first, so that people can easily understand what I'm working on. even better if they have access to the AI chat as well to interact with my process. There's also a ton of more 'vision' features I want, orbiting around CIRL/interactive learning, passive context collection, making the answering AI more agentic, social networking around the shared context/ideas, agent to agent collaboration, but that comes later. As a simple example, giving the AI a secure VM that it could code up small experiments on. I'll often a read a paper and want to implement a simple version of the ideas but the friction is so high. And obviously I'd want this to be auto-shared. Overall, I'm trying to maximally expose the process of my work so that AI can be maximally useful to me, now and in the future. So much friction associated with getting my granular context persisted and legible in real time. I think Obsidian does decent with note taking, sharing, and git persistence if you set it up, while NotebookLM does well with AI augmentation and link parsing. At a high level, I think what's needed is largely an Obsidian frontend but NotebookLM backend."

the next step for the AI vision would be codifying the state, actions, observations, and rewards akin to how its done in the appendix of [[Google Pi Team#^b98596]]

the app should enrich links to be able to more quickly skim and handle as needed. specifically X and arxiv

for showing git commit history on the UI, i scoped it out and its a bit complicated. my claude has a local md file with the spec in its own words. essentially what's needed is the right hand view of quartz should show a reverse chronological list of commits. when a commit is clicked it should be shaded to indicate its selected and quartz should show the version of the notes at the commit, along with the diff from the parent commit. the green/red highlighting should match the yellow highlighting for backlinks that already exists, and the files that are edited should be highlighted yellow in the left hand list. if deselected, the notes should go back to the current version.
	intermediate step would be just showing the prior version, without any special highlighting

struggling with implementing the diff view on the UI vs doing something else. feels a bit uncomfortable in terms of having 'blinders' on. i have a scope listed to my ai

Most people probably don’t/can’t have their internal monologue publicized? Need to sample the environment

https://github.com/siyuan-note/siyuan And logseq

track page visits to my site

cofounders confirmed that showing recent updates and/or having something to just plug into an agent is necessary for it to be useful (the agent plugin would need history)

generative not summarative as an explainer for the notetaking aspect

shared by sam https://lazy.so/

 the ai dot engineer conference in sf has a gemini chat in the bottom corner: https://github.com/smol-ai/skills/blob/main/public-qa-chatbot/SKILL.md. use for my public notes? [[PDEV]]

https://news.ycombinator.com/item?id=48675435 new notetaking app. built by inkeep, which I was previously exploring as a solution because it indexed links well, but was for enterprises, didnt want to spend 400/mo on it. it may actually be worth it though

https://gemini.google.com/app/5ebb19454b814c5e can use opentimestamps for true provenance on the notes via publishing git commits to Bitcoin

it doesnt seem like obsidian will build what i want [[PDEV]] since their core value prop involves privacy, whereas i want public by default + cloud AI analyzing everything/always on

do you end up having to improve on algos to win? (whether thats prompt space or weight space). probably? the thing is, so many people are working on this, no? not many people actually piping data into it? need better answers here
	- actual sync + easy entry (+ screenpipe) + version control + opentimestamps + data cleaning + predictive actions + link enhancement + public

"predict me" game that allows people to compete to take the public data and predict my next actions? to solve algorithms side? if you win you get hired?

probably related to my data thesis https://www.dwarkesh.com/p/the-sample-efficiency-black-hole

obsidian search sucks (double click button, doesnt handle spaces)
inputting into obsidian i've worked around with extra bullet, i guess its fine
obsidian sync sucks - not always up to date
existing stack, since team might set it up as well, for explanatory purposes, is obsidian + git + quartz + auto commit and deploy
obsidian backlinking sucks, should be AI recommended by searching over everything, i shouldnt need to specify the overall note and then scroll through the whole thing. i dont necessarily know where everything is