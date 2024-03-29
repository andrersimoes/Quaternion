module Quaternion

export Quat
export to_axis_angle, to_axis_angled, get_vector

struct Quat
    w::Float64
    x::Float64
    y::Float64
    z::Float64
end

Quat( a,b,c,d, w_pos::Symbol ) = (w_pos==:w_at_end) ? Quat(d,a,b,c) : 
    Quat(a,b,c,d)

"""
    to_axis_angle(q)

Extracts the rotation angle (given in radians) and rotation vector from 
quaternion q
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

"""
    to_axis_angled(q)

Extracts the rotation angle (given in degrees) and rotation vector from 
quaternion q
"""
function to_axis_angled( q::Quat )
    r = to_axis_angle( q )
    r[1] = r[1] * 180/pi
    r
end

"""
    get_vector(q)
Returns an Array{Float,1} formed with i, j and k coefficients of Quaternion q. 
It can be used to directly extract the resulting vector from a rotation 
q * qv * q', where qv is a pure imaginary quaternion representing the input 
vector.
"""
function get_vector( q::Quat )
    [ q.x; q.y ; q.z ]
end

include( "quat_show.jl" )
include( "quat_operations.jl" )
include( "mat_operations.jl" )

end
