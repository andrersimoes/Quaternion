import Base.show
export show

global style=:poly

function set_style( s::Symbol )
    style = s;
end

function show( io::IO, q::Quat )
    global style
    if style == :full_poly
        println( io, "Quat( $(q.w) + $(q.x)$(s)i$(e) + $(q.y)$(s)j$(e) + " *
            "$(q.z)$(s)k$(e) )" )
    elseif style == :poly
        s="\x1B[36m"
        e="\x1B[0m"
        if q.w !=0 && q.x == q.y == q.z == 0
            println( io, "Quat( $(q.w) )" )
        elseif q.x != 0 && q.y == q.z == 0
            println( io, "Quat( $(q.w) + $(q.x)$(s)i$(e) )" )
        elseif q.y != 0 && q.x == q.z == 0
            println( io, "Quat( $(q.w) + $(q.y)$(s)j$(e) )" )
        elseif q.z != 0 && q.x == q.y == 0
            println( io, "Quat( $(q.w) + $(q.z)$(s)k$(e) )" )
        elseif q.x != 0 && q.y != 0 && q.z == 0
            println( io, "Quat( $(q.w) + $(q.x)$(s)i$(e) + $(q.y)$(s)j$(e) )" )
        elseif q.x != 0 && q.z != 0 && q.y == 0
            println( io, "Quat( $(q.w) + $(q.x)$(s)i$(e) + $(q.z)$(s)k$(e) )" )
        elseif q.x == 0 && q.y != 0 && q.z != 0
            println( io, "Quat( $(q.w) + $(q.y)$(s)j$(e) + $(q.z)$(s)k$(e) )" )
        else
            println( io, "Quat( $(q.w) + $(q.x)$(s)i$(e) + $(q.y)$(s)j$(e) + " *
                "$(q.z)$(s)k$(e) )" )
        end
    end
end

