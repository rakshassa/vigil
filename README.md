# TODO

bugs:
- trinkets do not wrap to 2nd line
- weapon prices must scale
- win boss fight -> leave (no selection) causes day to fail resetting

enhancements:
- rspec tests
- monsters and bosses through level 15
- weapons and armor through level 15
- player level_ups through level 15
- weekly bosses
    - switch between big_hp/low_atk and big_atk, low_hp
    - list of attributes
        - canine: squirrel reduces hit chance
        - feline: hamster reduces hit chance
        - has_mesmerize = 25% chance each round to be stunned
        - immune to skill attacks (backstab)
        - destroys trinkets (instead of doing dmg?)
        - add more attributes/effects for bosses
- scouting the weekly boss
    - cost in hours: days_until_boss_arrives
    - discovers boss type (atk/def) and/or an attribute
        - results should display all known data and ??? for unknown data
        - don't let user scout when all data is already known



DEFER
=========
- login: if web app, need authentication to seperate state between users
- start-game screen
    - class
    - challenges
    - modifiers

- track rounds in a single combat to allow trinkets/abilities to trigger on specific rounds
- Action: scouts - info about incoming boss
- full stat sheet (crit, critdmg, hitrate, runrate, etc)
- new class: Bard - seduces anything as skill with percent chances of failures
- achievements (need users to attach to these persisted achievements)
- level-up talent selection
- trinket upgrades

https://vigil-svo7.onrender.com

DATABASE_URL="postgres://myuser:mypass@localhost/somedatabase"
postgresql://vigil:redacted@dpg-ctths79u0jms73bj593g-a/vigil_production
postgresql://vigil:redacted@dpg-ctths79u0jms73bj593g-a.oregon-postgres.render.com/vigil_production
