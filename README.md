# Daily Reward System

> **AI review:**  
> A simple, server-authoritative daily reward system with persistent player data. The Server controls eligibility, reward timing, and currency updates, so the Client cannot manipulate claims or coin values.

## Overview

Players receive **100 coins** when joining if at least **24 hours** have passed since their previous reward claim.

Player data stores:

```lua
{
    lastDailyRewardClaim = 0,
    coins = 0,
}
```

## Architecture

- **Data initialization script** — creates the player data template and starts the service.
- **`DailyRewardServiceServer`** — checks eligibility and grants rewards.
- **`DataService`** — loads, reads, updates, and saves player data.

## Security

- Reward validation runs entirely on the Server.
- The Client cannot change timestamps or reward amounts.
- `os.time()` is used instead of the player's device clock.
- Saved timestamps prevent rewards from being claimed again after rejoining.
- Player data is loaded before any reward logic runs.

## Reward Logic

```lua
local DAY_IN_SECONDS = 24 * 60 * 60
local DAILY_REWARD = 100

local function canClaimDailyReward(player: Player): boolean
    local lastClaim = DataService:get(player, "lastDailyRewardClaim")

    return lastClaim == nil
        or lastClaim == 0
        or lastClaim + DAY_IN_SECONDS <= os.time()
end
```

## Known Limitations

- Reward is claimed automatically on join.
- Fixed 24-hour cooldown.
- No streak system or countdown UI.