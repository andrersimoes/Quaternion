module Quaternion

export Quat
export to_axis_angle

struct Quat
    w::Float64
    x::Float64
    y::Float64
    z::Float64
end

"""
    to_axis_angle(q)

Extracts the rotation angle (given in radians) and rotation vector from quaternion q
"""
function to_axis_angle( q::Quat )
    if( abs( q.w ) ≤ 1 ) 
        half_rad = acos( q.w )
    else
        n = normalize( q )
        half_rad = acos( n.w )
    end

    if half_rad > 0
        x = q.x / sin( half_rad )
        y = q.y / sin( half_rad )
        z = q.z / sin( half_rad )

        [ half_rad*2, [x,y,z] ]
    else
        [ 0, [0,0,0] ]
    end
end

include( "quat_show.jl" )
include( "quat_operations.jl" )

end
