# Ralph Starter

A simple starter repo demonstrating how Ralph works - an autonomous coding loop that builds software from some specs.

## How Ralph Works

Ralph operates on three core files:

| File | Purpose |
|------|---------|
| `prd.json` | **The Goal** - A JSON file containing user stories with acceptance criteria. This represents how you want the world to look like. |
| `progress.txt` | **The Current State** - A log of what has been implemented, patterns discovered, and learnings. This represents how the world currently is. |
| `prompt.md` | **The Transformer** - Instructions that tell the agent how to pick up the next task, implement it, and update progress. |

Each iteration, Ralph:
1. Reads the PRD to understand the goal
2. Reads progress to understand current state
3. Picks the highest priority unfinished story
4. Implements it, runs tests
5. Updates `prd.json` (marks `passes: true`)
6. Appends learnings to `progress.txt`

When all stories pass, Ralph exits with `<promise>COMPLETE</promise>`.

## Getting Started

### Prerequisites

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed
- Node.js (for the example to-do app)

### Running Ralph

1. Make the script executable:
   ```bash
   chmod +x ralph.sh
   ```

2. Run Ralph:
   ```bash
   ./ralph.sh
   ```

Ralph will iterate through the user stories, implementing them one by one until the app is complete.

### Optional: Set Max Iterations

By default, Ralph runs for up to 10 iterations. You can change this:

```bash
./ralph.sh 20  # Run up to 20 iterations
```

## Customizing for Your Project

This repo includes an example PRD for a to-do list app. To use Ralph for your own project:

1. **Edit `prd.json`** - Replace the user stories with your own. Each story needs:
   - `id` - Unique identifier (e.g., "US-001")
   - `title` - Short description of the feature
   - `acceptanceCriteria` - List of requirements to satisfy
   - `priority` - Number (lower = higher priority)
   - `passes` - Set to `false` for unimplemented stories

2. **Clear `progress.txt`** - Start fresh or keep the header structure:
   ```
   # Ralph Progress Log
   Started: [DATE]

   ## Codebase Patterns

   [Patterns will be added here as Ralph learns]

   ## Key Files

   [Key files will be documented here]

   ---
   ```

3. **Run Ralph** - Let it build your project story by story

## Example PRD Structure

```json
{
  "branchName": "my-feature/branch",
  "userStories": [
    {
      "id": "US-001",
      "title": "Initialize project",
      "acceptanceCriteria": [
        "Package.json exists",
        "Basic folder structure created"
      ],
      "priority": 1,
      "passes": false,
      "notes": ""
    }
  ]
}
```

## How It Works Under the Hood

`ralph.sh` runs a loop that:
1. Pipes `prompt.md` to Claude Code
2. Streams the output through a visualizer
3. Repeats until max iterations or completion

The magic is in the prompt design - it tells the agent exactly how to pick work, implement it, and track progress in a way that persists across iterations.