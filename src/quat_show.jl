import Base.show
export show, show_styles, set_style

global styles_array = [ :poly :full_poly :vector :w_at_end ]
global style=:poly

function show_styles()
    println( "Quat.show_styles() - possible styles are: " )
    global styles_array
    for e in styles_array
        println( "    :"*string(e) )
    end
end

function set_style( s::Symbol )
    if findfirst( x->x==s, styles_array ) != nothing
        global style
        style = s;
    else
        println( "Symbol :" *string(s)*" is not a valid option."  )
        show_styles()
    end
end

function show( io::IO, q::Quat )
    global style
    s="\x1B[36m"
    e="\x1B[0m"

    w=q.w
    x=abs(q.x)
    y=abs(q.y)
    z=abs(q.z)

    sx=q.x < 0 ? "-" : "+"
    sy=q.y < 0 ? "-" : "+"
    sz=q.z < 0 ? "-" : "+"

    if style == :full_poly
        println( io, "Quat( $(w) $(sx) $(x)$(s)i$(e) $(sy) $(y)$(s)j$(e) " *
            "$(sz) $(z)$(s)k$(e) )" )
    elseif style == :vector
        println( io, "Quat( w = $(q.w), $(s)v$(e) = ( $(q.x), $(q.y), $(q.z) ) )" )
    elseif style == :w_at_end
        println( io, "Quat( $(sx)$(x), $(sy)$(y), $(sz)$(z), $(w) )" )
    elseif style == :poly
        if q.w !=0 && q.x == q.y == q.z == 0
            println( io, "Quat( $(w) )" )
        elseif q.x != 0 && q.y == q.z == 0
            println( io, "Quat( $(w) $(sx) $(x)$(s)i$(e) )" )
        elseif q.y != 0 && q.x == q.z == 0
            println( io, "Quat( $(w) $(sy) $(y)$(s)j$(e) )" )
        elseif q.z != 0 && q.x == q.y == 0
            println( io, "Quat( $(w) $(sz) $(z)$(s)k$(e) )" )
        elseif q.x != 0 && q.y != 0 && q.z == 0
            println( io, "Quat( $(w) $(sx) $(x)$(s)i$(e) $(sy) $(y)$(s)j$(e) )" )
        elseif q.x != 0 && q.z != 0 && q.y == 0
            println( io, "Quat( $(w) $(sx) $(x)$(s)i$(e) $(sz) $(z)$(s)k$(e) )" )
        elseif q.x == 0 && q.y != 0 && q.z != 0
            println( io, "Quat( $(w) $(sy) $(y)$(s)j$(e) $(sz) $(z)$(s)k$(e) )" )
        else
            println( io, "Quat( $(w) $(sx) $(x)$(s)i$(e) $(sy) $(y)$(s)j$(e) " *
                "$(sz) $(z)$(s)k$(e) )" )
        end
    end
end

