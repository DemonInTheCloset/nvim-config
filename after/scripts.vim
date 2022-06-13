if did_filetype()       " filetype already set
    finish              " don't do these checks
endif

if getline(1) =~# '^#!.*/bin/zsh\>'
    setfiletype zsh
elseif getline(1) =~# '^#.*/bin/env\s\+python.\='
    setfiletype python
endif
