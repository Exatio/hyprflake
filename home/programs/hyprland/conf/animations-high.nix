this will crash if imported. and it should not be imported since its not ready to use

# -----------------------------------------------------
# Animations
# -----------------------------------------------------
animations {
    enabled = true
    bezier = wind, 0.05, 0.9, 0.1, 1.05
    bezier = winIn, 0.1, 1.1, 0.1, 1.1
    bezier = winOut, 0.3, -0.3, 0, 1
    bezier = liner, 1, 1, 1, 1
    animation = windows, 1, 6, wind, slide
    animation = windowsIn, 1, 6, winIn, slide
    animation = windowsOut, 1, 5, winOut, slide
    animation = windowsMove, 1, 5, wind, slide
    animation = border, 1, 1, liner
    animation = borderangle, 1, 30, liner, loop
    animation = fade, 1, 10, default
    animation = workspaces, 1, 5, wind
}

##JA KOOLIT ANIMATIONS
animations {
    enabled = yes

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    bezier = liner, 0, 0, 1, 1
    bezier = wind, 0.05, 0.9, 0.1, 1.05
    bezier = winIn, 0.1, 1.1, 0.1, 1.1
    bezier = winOut, 0.3, -0.3, 0, 1
    bezier = liner, 1, 1, 1, 1
    bezier = slow, 0, 0.85, 0.3, 1
    bezier = overshot, 0.7, 0.6, 0.1, 1.1
    bezier = bounce, 1.1, 1.6, 0.1, 0.85
    bezier = sligshot, 1, -1, 0.15, 1.25
    bezier = nice, 0, 6.9, 0.5, -4.20

    animation = windowsIn, 1, 5, slow, popin
    animation = windowsOut, 1, 5, winOut, popin
    animation = windowsMove, 1, 5, wind, slide
    animation = border, 1, 20, nice
    animation = borderangle, 1, 30, liner, loop
    animation = fade, 1, 5, overshot
    animation = workspaces, 1, 5, wind
    animation = windows, 1, 5, bounce, popin
}
