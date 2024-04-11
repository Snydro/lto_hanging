Config = {}

Config.MaxDistance = 5 -- Distance from the hanging zone
Config.TooFar = "You Are Too Far To Do This Command !"
Config.Text = "You have been Hanged and will ~e~Die~q~ Soon !"

-- where you want the hand spot for prisonner
Config.Hang = {
    vector4(-314.14, 728.75, 120.61, 97.07), -- Valentine
}

Config.Jobs = { -- Jobs able to hang players.
    'sheriff',
    'marshal'
}

Config.Wait = {
    HangedScreenFade = 12, -- In Seconds. Time to Fade Hanged Players Screen.
    TimeToHang = 14 -- In Seconds. Time to let Hanged Player sit with black screen.
}