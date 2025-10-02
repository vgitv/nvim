local colors = {
    black = "#14151d",
    white = "#828bb8",
    red = "#ff757f",
    green = "#c3e88d",
    blue = "#82aaff",
    purple = "#c099ff",
    yellow = "#ffc777",
    gray = "#a89984",
    darkgray = "#3c3836",
    lightgray = "#3b4261",
}

return {
    normal = {
        a = { bg = colors.blue, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.blue },
        c = { bg = colors.black, fg = colors.white },
    },
    insert = {
        a = { bg = colors.green, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.green },
        c = { bg = colors.black, fg = colors.white },
    },
    visual = {
        a = { bg = colors.purple, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.purple },
        c = { bg = colors.black, fg = colors.white },
    },
    replace = {
        a = { bg = colors.red, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.red },
        c = { bg = colors.black, fg = colors.white },
    },
    command = {
        a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.yellow },
        c = { bg = colors.black, fg = colors.white },
    },
    inactive = {
        a = { bg = colors.darkgray, fg = colors.gray, gui = "bold" },
        b = { bg = colors.darkgray, fg = colors.gray },
        c = { bg = colors.black, fg = colors.gray },
    },
}
