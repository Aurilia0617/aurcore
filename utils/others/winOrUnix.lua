return {
    win = (package.config:sub(1, 1) == '\\'),
    unix = (package.config:sub(1, 1) == '/')
}