local colors = {
    black = "#14151d",
    white = "#afb6d7",
    red = "#ff757f",
    green = "#c3e88d",
    green1 = "4fd6be",
    blue = "#82aaff",
    purple = "#c099ff",
    yellow = "#ffc777",
    gray = "#a89984",
    lightgray = "#4a516d",
    darkgray = "#373c52",
    fixme = "#ffffff",
}

return {
    normal = {
        a = { bg = colors.blue, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.blue },
        c = { bg = colors.darkgray, fg = colors.white },
    },
    insert = {
        a = { bg = colors.green, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.green },
        c = { bg = colors.darkgray, fg = colors.white },
    },
    visual = {
        a = { bg = colors.purple, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.purple },
        c = { bg = colors.darkgray, fg = colors.white },
    },
    replace = {
        a = { bg = colors.red, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.red },
        c = { bg = colors.darkgray, fg = colors.white },
    },
    command = {
        a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.yellow },
        c = { bg = colors.darkgray, fg = colors.white },
    },
    terminal = {
        a = { bg = colors.green1, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.green1 },
        c = { bg = colors.darkgray, fg = colors.white },
    },
    inactive = {
        a = { bg = colors.fixme, fg = colors.gray, gui = "bold" },
        b = { bg = colors.fixme, fg = colors.gray },
        c = { bg = colors.black, fg = colors.gray },
    },
}
