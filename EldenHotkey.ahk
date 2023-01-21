#requires AutoHotkey v2.0
#MaxThreads 1 ;lmaooooooo no need for synchronization


SLEEP_TIME := 25
INDEX_MAX := 7
index := 0


Loop 10
{
    Hotkey A_Index-1, Handler
}

^k::
{
    global index
    index := 0
}

^l::
{
    global INDEX_MAX

    Suspend True
    INDEX_MAX := Integer(InputBox("Enter number of spells: ", "Spell Count").value) - 1
    Suspend False
}

Handler(trig)
{
    global index, INDEX_MAX

    des := SpecMod(trig-1, 9)
    if(des > INDEX_MAX)
        return
    diff := des - index

    if(diff < 0)
        diff += INDEX_MAX + 1

    if(diff > 0)
        Cycle(diff)

    index := Mod(index + diff, INDEX_MAX + 1)

    OutputDebug "Index: " index
}

SpecMod(num, max)
{
    num := Mod(num, max)

    return num < 0 ? (num + max + 1) : num
}

Cycle(idx)
{
    loop idx
    {
        Send "{Up down}"
        Sleep SLEEP_TIME
        Send "{Up up}"
        Sleep SLEEP_TIME
    }
}
